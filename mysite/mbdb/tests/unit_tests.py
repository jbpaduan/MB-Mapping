#!/usr/bin/env python

__author__ = "Mike McCann"
__copyright__ = "Copyright 2020, Monterey Bay Aquarium Research Institute"

import os
import sys
import time
import json
import time
import logging

from django.conf import settings
from django.test import TestCase
from django.urls import reverse
from mbdb.models import Expedition, Mission

logger = logging.getLogger(__name__)

class BaseMbdbTestCase(TestCase):

    def test_expedition(self):
        q = Expedition(expedition_name="Extravert Cliff", region_name="Monterey Bay")
        result = q.was_started_recently()
        self.assertEqual(result, True, f"Expedition {q} just created, 'was_started_recently()' should return True")
