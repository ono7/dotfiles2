import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s: %(name)s - %(levelname)s - %(funcName)s - %(message)s')
logger = logging.getLogger(__name__)

def my_function():
    logger.info("This is an info message")
    try:
        1/0
    except Exception as e:
        logger.error("", exc_info=True)

my_function()
