#!/bin/bash
set -e

# Gunakan docker image untuk testing
docker run --rm -v "$(pwd)/sources:/src" qnib/pytest py.test --junit-xml test-reports/results.xml ../../sources/test_calc.py
