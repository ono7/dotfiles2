package main

import (
	"crypto/tls"
	"crypto/x509"
	"encoding/pem"
	"flag"
	"fmt"
	"io/ioutil"
	"net"
	"net/http"
	"os"
	"time"
)

func main() {
	var (
		targetHost = flag.String("s", "www.google.com", "target site e.g. www.google.com")
		targetPort = flag.String("p", "443", "target tcp port")
		outputFile = flag.String("o", "root_ca.crt", "output file (default root_ca.crt)")
		timeout    = flag.Duration("t", 5*time.Second, "timeout value for dialing in seconds, use s = seconds, eg. 10s, 5s")
	)
	flag.Parse()

	dialer := &net.Dialer{
		Timeout: *timeout,
	}

	targetURL := fmt.Sprintf("%s:%s", *targetHost, *targetPort)

	// Create a TLS configuration with InsecureSkipVerify set to true
	// to allow self-signed certificates or invalid hostnames
	tlsConfig := &tls.Config{
		InsecureSkipVerify: true,
	}

	// Establish a TLS connection to the target website
	// conn, err := tls.Dial("tcp", targetURL, tlsConfig)
	conn, err := tls.DialWithDialer(dialer, "tcp", targetURL, tlsConfig)
	if err != nil {
		fmt.Printf("Failed to establish connection: %v\n", err)
		os.Exit(1)
	}
	defer conn.Close()

	// Retrieve the remote certificate
	remoteCert := conn.ConnectionState().PeerCertificates[0]

	// Find the root CA certificate
	rootCACert := findRootCACertificate(remoteCert)

	// Save the root CA certificate in PEM format
	// TODO: (jlima) ~ take optional flag to save as
	saveCertificateAsPEM(*outputFile, rootCACert)
}

// Helper function to find the root CA certificate from a certificate chain
func findRootCACertificate(cert *x509.Certificate) *x509.Certificate {
	// Iterate through the certificate chain until we find the root CA certificate
	for {
		if cert.IsCA {
			fmt.Printf("%-20s %50s\n", "Issuer:", cert.Issuer.CommonName)
			return cert
		}

		if len(cert.IssuingCertificateURL) > 0 {
			// Fetch and validate the issuing certificate
			resp, err := http.Get(cert.IssuingCertificateURL[0])
			if err != nil {
				fmt.Printf("Failed to fetch issuing certificate: %v\n", err)
				return nil
			}
			defer resp.Body.Close()

			issuingCertBytes, err := ioutil.ReadAll(resp.Body)
			if err != nil {
				fmt.Printf("Failed to read issuing certificate: %v\n", err)
				return nil
			}

			issuingCert, err := x509.ParseCertificate(issuingCertBytes)
			if err != nil {
				fmt.Printf("Failed to parse issuing certificate: %v\n", err)
				return nil
			}

			cert = issuingCert
		} else if cert.Issuer.CommonName == cert.Subject.CommonName {
			// Reached the root CA certificate
			fmt.Printf("found cert %-20s\n", cert.Issuer)
			return cert
		} else {
			fmt.Println("Failed to find root CA certificate")
			return nil
		}
	}
}

// Helper function to save a certificate in PEM format
func saveCertificateAsPEM(filename string, cert *x509.Certificate) {
	certBytes := pem.EncodeToMemory(&pem.Block{
		Type:  "CERTIFICATE",
		Bytes: cert.Raw,
	})
	fmt.Printf("%-20s %50s\n", "Valid from:", cert.NotBefore)
	fmt.Printf("%-20s %50s\n", "Valid to:", cert.NotAfter)
	delta := cert.NotAfter.Sub(cert.NotBefore)
	fmt.Printf("%-20s %50d\n", "Expires in (days): ", int(delta.Hours()/24))
	err := ioutil.WriteFile(filename, certBytes, 0644)
	if err != nil {
		fmt.Printf("Failed to save certificate: %v\n", err)
		os.Exit(1)
	}
	fmt.Printf("%-20s %50s\n", "Saved as:", filename)
}
