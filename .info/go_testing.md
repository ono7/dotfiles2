# go tests

- run all tests in this directory
  `go test -v` versbose

- test specific tests
  `go tests -v TestEqualPlayers` only tests the TestEqualPlayers function

- skip cache
  `go test -v -count=1` tricks cache so that test is fresh every time
