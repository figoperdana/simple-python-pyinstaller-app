#!/bin/bash
cd sources
pytest --junit-xml=/test-reports/results.xml test_calc.py
