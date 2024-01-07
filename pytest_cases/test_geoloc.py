#!/usr/bin/env python3
"""
    Author:  Jose Lima (jlima)
    Date:    2024-01-07  00:28

"""

import pytest
from unittest.mock import patch, Mock
from geoloc import get_coordinates


resp = {"data": {"data": {"lat": "123", "lon": "456"}}}


@pytest.fixture
def mock_response_success():
    mock_resp = Mock()
    # Mimic the structure of the response you expect from the real API
    mock_resp.json.return_value = resp
    mock_resp.json.status_code = 200
    return mock_resp


@patch("geoloc.requests.get")
def test_get_coordinates(mock_get, mock_response_success):
    response = get_coordinates("600 S. Collier Street, Marco Island, USA")

    assert response.json == resp
    assert response.status_code == 300
