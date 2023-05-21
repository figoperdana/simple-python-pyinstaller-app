#!/bin/bash
cd sources/test_calc.py
pytest --junit-xml=/test-reports/results.xml test_calc.py
