#!/usr/bin/env python
from distutils.core import setup

VERSION = "1.03"

setup(
name = "SocksiPy-chain",
version = VERSION,
description = "A Python SOCKS/HTTP Proxy module",
long_description = "This Python module allows you to create TCP connections through a chain of SOCKS or HTTP proxies without any special effort.",
url = "http://github.com/PageKite/SocksiPyChain",
author = "Bjarni R. Einarsson",
author_email="bre@pagekite.net",
license = "BSD",
py_modules=["socks"]
)

