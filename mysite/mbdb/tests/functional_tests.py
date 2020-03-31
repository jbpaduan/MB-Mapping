#!/usr/bin/env python

__author__ = "Mike McCann"
__copyright__ = "Copyright 2020, Monterey Bay Aquarium Research Institute"

from django.contrib.staticfiles.testing import StaticLiveServerTestCase
from django.conf import settings
from selenium import webdriver
from selenium.common.exceptions import TimeoutException, NoSuchElementException
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.firefox.options import Options

import logging
import os
import re
import time

logger = logging.getLogger(__name__)

class BaseTestCase(StaticLiveServerTestCase):
    # Note that the test runner sets DEBUG to False:
    # https://docs.djangoproject.com/en/1.8/topics/testing/advanced/#django.test.runner.DiscoverRunner.setup_test_environment

    multi_db = False

    def setUp(self):
        headless = True
        if not headless:
            # Needs X-Server - opens browser windows
            self.browser = webdriver.Firefox()
        else:
            # The defaule - for running on CI servers
            options = Options()
            options.headless = True
            self.browser = webdriver.Firefox(options=options)

    def tearDown(self):
        self.browser.quit()


class BrowserTestCase(BaseTestCase):
    '''Use selenium to test standard things in the browser
    '''

    def test_mbdb_page(self):
        self.browser.get(os.path.join(self.live_server_url, 'mbdb'))
        # TODO: As tutorial progresses to template driven response update '' with actual title of web page
        self.assertIn('', self.browser.title)

