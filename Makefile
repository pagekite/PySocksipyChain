# These are rules for building various types of distributions of this
# module.  This Makefile is known to work on an Ubuntu 11.04 and builds
# the following packages:
#
#    - Source .tar.gz distribution
#    - Binary (all) .deb
#
dist: .deb .targz
	@echo ======= BUILD OK =====================
	@ls -l dist/

VERSION=`python setup.py --version`

.targz:
	@echo ======= .TAR.GZ =====================
	@python setup.py sdist
	@touch .targz

.deb: .targz debian/control.in setup.py Makefile
	@echo ======= .DEB =====================
	@rm -f setup.cfg
	@cp -v dist/SocksipyChain*tar.gz \
                ../python-socksipychain-$(VERSION)_$(VERSION).orig.tar.gz
	@sed -e "s/@VERSION@/$(VERSION)/g" \
		< debian/control.in >debian/control
	@sed -e "s/@VERSION@/$(VERSION)/g" \
		< debian/copyright.in >debian/copyright
	@sed -e "s/@VERSION@/$(VERSION)/g" \
	     -e "s/@DATE@/`date -R`/g" \
		< debian/changelog.in >debian/changelog
	@debuild -i -us -uc -b
	@mv ../python-socksipychain_*.deb dist/
	@rm ../python-socksipychain-*
	@touch .deb

clean:
	@rm -rf .targz .deb build MANIFEST *.egg-info setup.cfg
	@rm -rf debian/files debian/control debian/copyright debian/python-*
	@rm -rf debian/changelog

distclean: clean
	@rm -rf dist/*

