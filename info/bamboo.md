# python testing / bamboo


1. create build job, need to run testing manually using script


```bash
#!/bin/bash
pytest --junitxml=test-reports/results.xml

exit 0
```

2. create JUnit parser job, by default will use the test-reports/results.xml
