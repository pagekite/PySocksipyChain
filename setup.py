#!/usr/bin/env python
from setuptools import setup

VERSION = "2.0.8"

setup(
    name = "SocksipyChain",
    version = VERSION,
    description = "A Python SOCKS/HTTP Proxy module",
    long_description = """\
This Python module allows you to create TCP connections through a chain
of SOCKS or HTTP proxies without any special effort. It also supports
TLS/SSL encryption if the OpenSSL modules are installed.
""",
     url = "http://github.com/PageKite/SocksiPyChain",
     author = "Bjarni R. Einarsson",
     author_email="bre@pagekite.net",
     license = "BSD",
     packages=["sockschain"],
     entry_points = {
         'console_scripts': [
             'sockschain = sockschain:Main'
         ]
     }
)

