#!/bin/bash
# Unit and functional tests for MB-Database (mbdb)

echo "Running unit tests..."
mysite/manage.py test mbdb.tests.unit_tests

echo "Running functional tests..."
mysite/manage.py test mbdb.tests.functional_tests
