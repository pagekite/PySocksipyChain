#!/usr/bin/python
from __future__ import print_function
from six.moves.urllib.request import urlopen

import telnetlib

try:
    import urllib.request as urllib_request  # Python 3
except ImportError:
    import urllib2 as urllib_request  # Python 2

# Import SocksiPy
import sockschain as socks
def DEBUG(msg): print(msg)
socks.DEBUG = DEBUG

# Set the proxy information
socks.setdefaultproxy(socks.PROXY_TYPE_SOCKS5, 'localhost', 9050)

# Route an HTTP request through the SOCKS proxy 
socks.wrapmodule(urllib_request)
print('\n%s\n' % urlopen('https://ipconfig.me/').read())

# Route a telnet connection through the SOCKS proxy
socks.wrapmodule(telnetlib)
tn = telnetlib.Telnet('india.colorado.edu', 13)
print(tn.read_all())
tn.close()
