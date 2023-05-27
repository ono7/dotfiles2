package main

import (
	"crypto/tls"
	"crypto/x509"
	"encoding/pem"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
)

func main() {
	// Specify the target website's address
	args := os.Args
	targetURL := args[1] + ":443"

	// Create a TLS configuration with InsecureSkipVerify set to true
	// to allow self-signed certificates or invalid hostnames
	tlsConfig := &tls.Config{
		InsecureSkipVerify: true,
	}

	// Establish a TLS connection to the target website
	conn, err := tls.Dial("tcp", targetURL, tlsConfig)
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
	saveCertificateAsPEM("root_ca.pem", rootCACert)
}

// Helper function to find the root CA certificate from a certificate chain
func findRootCACertificate(cert *x509.Certificate) *x509.Certificate {
	// Iterate through the certificate chain until we find the root CA certificate
	for {
		if cert.IsCA {
			log.Printf("found cert %s", cert.Issuer)
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
			log.Printf("found cert %s", cert.Issuer)
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
	err := ioutil.WriteFile(filename, certBytes, 0644)
	if err != nil {
		fmt.Printf("Failed to save certificate: %v\n", err)
		os.Exit(1)
	}
	fmt.Printf("Root CA certificate saved as %s\n", filename)
}
