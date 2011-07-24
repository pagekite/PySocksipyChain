dist: .rpm .targz

.targz: setup.py sockschain.py Makefile
	@python setup.py sdist
	@touch .targz

.rpm: setup.py sockschain.py Makefile
	@sed -i -e 's/"SocksipyChain"/"python-socksipychain"/g' setup.py
	@python setup.py bdist_rpm --install scripts/rpm-install.sh
	@sed -i -e 's/"python-socksipychain"/"SocksipyChain"/g' setup.py
	@touch .rpm

clean:
	@rm -rf .rpm .targz dist build MANIFEST
