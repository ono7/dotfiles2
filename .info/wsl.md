# Start-Process powershell -Verb runas

run this as admin to set metric on vpn client to 6000, should run every time we connect
needs LxssManager to restart

```powershell
Get-NetAdapter | Where-Object {$_.InterfaceDescription -Match "Cisco AnyConnect"} | Set-NetIPInterface -InterfaceMetric 6000
Restart-Service LxssManager
```

# nat ports

```powershell
netsh interface portproxy add v4tov4 listenport=[PORT] listenaddress=0.0.0.0 connectport=[PORT] connectaddress=[WSL_IP]

<!-- view ports -->

netsh interface portproxy show v4tov4

<!-- windows firewall add ports -->

New-NetFirewallRule -DisplayName "WSL2 Port Bridge" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 80,443,10000,3000,5000

```
