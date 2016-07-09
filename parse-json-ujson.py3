#!/usr/bin/env python3
import sys,ujson
for line in sys.stdin:
    ujson.loads(line)
