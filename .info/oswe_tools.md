# info gathering

- read exam guide

https://support.offensive-security.com/oswe-exam-guide/

- nodejs maybe vulnerable in its Buffer construtor to encode characters

```javascript
let buf = new Buffer('hello', 'utf8');
```

# RDP

xfreerdp +clipboard /u:administrator /p:studentlab /v:me
alias setup in zshrc -> rdp='xfreerdp +clipboard'
