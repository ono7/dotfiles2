#!/usr/bin/env python3
"""
    Author:  Jose Lima (jlima)
    Date:    2024-01-07  16:19
    test for apireq
"""

from unittest import mock
from apireq import get_api


@mock.patch("apireq.requests.get")
def test_get_ip(mock_requests_get):
    # ** unpacking allows us to inject the corret objects when the mock requires multiple
    # e.g. response.json()["origin"]
    mock_requests_get.return_value = mock.Mock(
        **{"status_code": 200, "json.return_value": {"origin": "1.1.1.2"}}
    )
    assert get_api() == "1.1.1.2"
    # make sure that this was called with the correct URL every time
    # see the mock object for other things we can do here
    mock_requests_get.assert_called_once_with("https://httpbin.org/ip")


# this is what this would look like testing without the pytest decorator
# ** unpacking allows us to inject the corret objects when the mock requires multiple
# fields/properties/methods
# mock_response = mock.Mock(
#     name="mock response",
#     **{"status_code": 200, "json.return_value": {"origin": "1.1.1.2"}}
# )

# mock_request_get = mock.Mock(name="mock request", return_value=mock_response)
#
# call with mock_request_get().json() -> {"origin" : "1.1.1.2"}
#
# request.get = mock_request_get
# print(get_ip())
