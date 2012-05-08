#!/usr/bin/python
import ftplib
import telnetlib
import urllib2

# Import SocksiPy
import sockschain as socks
def DEBUG(msg): print msg
socks.DEBUG = DEBUG

# Set the proxy information
#socks.setdefaultproxy(socks.PROXY_TYPE_SOCKS5, 'localhost', 9050)
socks.setdefaultproxy(socks.PROXY_TYPE_HTTP, 'klaki.net', 18080)

# Route an HTTP request through the SOCKS proxy 
socks.wrapmodule(urllib2)
print urllib2.urlopen('http://automation.whatismyip.com/n09230945.asp').read()

# Route an FTP session through the SOCKS proxy 
#socks.wrapmodule(ftplib)
#ftp = ftplib.FTP('cdimage.ubuntu.com')
#ftp.login('anonymous', 'support@aol.com')
#print ftp.dir('cdimage')
#ftp.close()

# Route a telnet connection through the SOCKS proxy
socks.wrapmodule(telnetlib)
tn = telnetlib.Telnet('achaea.com')
print tn.read_very_eager()
tn.close()
