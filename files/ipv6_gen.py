#!/usr/bin/env python

import sys
import os

peers = int(sys.argv[1])

hex_num = hex(peers)[2:]

print(hex_num)
