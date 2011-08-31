# These are rules for building various types of distributions of this
# module.  This Makefile is known to work on an Ubuntu 11.04 and builds
# the following packages:
#
#    - Source .tar.gz distribution
#    - Source and binary (noarch) .rpm for: RHEL 4/5/6, Fedora 13/14/15
#    - Binary (all) .deb
#
dist: .rpm .targz
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

.rpm: rpm_el4 rpm_el5 rpm_el6-fc13 rpm_fc14-15
	@touch .rpm

rpm_fc14-15:
	@./scripts/rpm-setup.sh 0pagekite_fc14fc15 /usr/lib/python2.7/site-packages
	@make rpm

rpm_el4:
	@./scripts/rpm-setup.sh 0pagekite_el4 /usr/lib/python2.3/site-packages
	@make rpm

rpm_el5:
	@./scripts/rpm-setup.sh 0pagekite_el5 /usr/lib/python2.4/site-packages
	@make rpm

rpm_el6-fc13:
	@./scripts/rpm-setup.sh 0pagekite_el6fc13 /usr/lib/python2.6/site-packages
	@make rpm

rpm: setup.py sockschain/__init__.py Makefile
	@echo ======= .RPM =====================
	@sed -i -e 's/"Socks/"python-Socks/g' setup.py
	@python setup.py bdist_rpm --install scripts/rpm-install.sh
	@sed -i -e 's/"python-Socks/"Socks/g' setup.py

clean:
	@rm -rf .rpm .targz .deb build MANIFEST *.egg-info setup.cfg
	@rm -rf debian/files debian/control debian/copyright debian/python-*
	@rm -rf debian/changelog

distclean: clean
	@rm -rf dist

