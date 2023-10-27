`https://github.com/ansible/awx-operator/issues/917`

adding replicas and affinity to the yaml deployment file

```yaml
AWX:
  enabled: true
  name: awx
  spec:
    replicas: 2
---
AWX:
  spec:
    ingress_annotations: |
      nginx.ingress.kubernetes.io/affinity: "cookie"
      nginx.ingress.kubernetes.io/session-cookie-name: "AWX-SESSION-COOKIE-COM"
      nginx.ingress.kubernetes.io/session-cookie-expires: "172800"
      nginx.ingress.kubernetes.io/session-cookie-max-age: "172800"
      nginx.ingress.kubernetes.io/affinity-mode: persistent
      nginx.ingress.kubernetes.io/session-cookie-hash: sha1
```
