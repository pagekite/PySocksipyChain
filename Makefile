dist: .targz .rpm .deb
	@echo ======= BUILD OK =====================
	@ls -l dist/

VERSION=`python setup.py --version`

.targz:
	@echo ======= .TAR.GZ =====================
	@python setup.py sdist
	@touch .targz

.deb: .targz debian/control.in setup.py Makefile
	@echo ======= .DEB =====================
	@cp -v dist/SocksipyChain*tar.gz \
                ../python-socksipychain-$(VERSION)_$(VERSION).orig.tar.gz
	@sed -e "s/@VERSION@/$(VERSION)/" \
		< debian/control.in >debian/control
	@debuild -i -us -uc -b
	@mv ../python-socksipychain_*.deb dist/
	@rm ../python-socksipychain-*
	@touch .deb

.rpm: setup.py sockschain/__init__.py Makefile
	@echo ======= .RPM =====================
	@sed -i -e 's/"Socks/"python-Socks/g' setup.py
	@python setup.py bdist_rpm --install scripts/rpm-install.sh
	@sed -i -e 's/"python-Socks/"Socks/g' setup.py
	@touch .rpm

clean:
	@rm -rf .rpm .targz .deb build MANIFEST *.egg-info

distclean: clean
	@rm -rf dist

