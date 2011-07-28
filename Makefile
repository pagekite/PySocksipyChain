dist: .rpm .targz

.targz: setup.py sockschain/__init__.py Makefile
	@python setup.py sdist
	@touch .targz

.rpm: setup.py sockschain/__init__.py Makefile
	@sed -i -e 's/"Socks/"python-Socks/g' setup.py
	@python setup.py bdist_rpm --install scripts/rpm-install.sh
	@sed -i -e 's/"python-Socks/"Socks/g' setup.py
	@touch .rpm

clean:
	@rm -rf .rpm .targz dist build MANIFEST *.egg-info
