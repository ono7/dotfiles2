# python

1. bamboo should clone and pip install requirements for the modules

2. bamboo should run pytest suite, for this bamboo needs to run on a virtual
   environment so that dependency versions can be met for different packages

pytest test_suite --junitxml=pytest.xml

3. bamboo works on the pytest.xml file generated to decide if this test passed
   or not

bamboo runs: JUnit parser plugin from bamboo on pytest.xml

4. bamboo continues to create pipeline -> merge to master or other branch and
   continue to create pipeline deployment
