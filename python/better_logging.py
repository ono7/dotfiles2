import logging
from requests.cookies import cookielib

api_logger = logging.getLogger(__name__)

api_formatter = logging.Formatter(
    "%(levelname)s [%(name)s.%(funcName)s:%(lineno)d] %(message)s"
)
api_handler = logging.StreamHandler()
api_handler.setFormatter(api_formatter)


# get other module loggers
urllib3_logger = logging.getLogger("requests.packages.urllib3")
urllib3_retry_logger = logging.getLogger("urllib3.util.retry")
cookie_logger = logging.getLogger("http.cookiejar")


# remove existing handlers
api_logger.handlers = []
urllib3_logger.handlers = []
urllib3_retry_logger.handlers = []
cookie_logger.handlers = []

# set this to anything else and it does not print output
_debuglevel = 2 

if _debuglevel == 2:
    cookie_logger.addHandler(api_handler)
    cookie_logger.setLevel(logging.DEBUG)
    cookielib.debug = False
    api_logger.addHandler(api_handler)
    api_logger.setLevel(logging.DEBUG)


def this_is_a_test(p):
    # drop calls to the api_logger anywhere in code for detailed logging
    api_logger.debug(f"{p}")
    print(p)


"""
other examples

if not sensitive:
    try:
        api_logger.debug('RESPONSE HEADERS: %s\n', json.dumps(
            json.loads(text_type(response.headers)), indent=4))
    except ValueError:
        api_logger.debug('RESPONSE HEADERS: %s\n', text_type(response.headers))
    try:
        api_logger.debug('RESPONSE: %s\n', json.dumps(response.json(), indent=4))
    except ValueError:
        api_logger.debug('RESPONSE: %s\n', text_type(response.text))
else:
    api_logger.debug('RESPONSE NOT LOGGED (sensitive content)')

api_logger.debug("Error, non-200 response received: %s", response.status_code)
"""


this_is_a_test("this")
