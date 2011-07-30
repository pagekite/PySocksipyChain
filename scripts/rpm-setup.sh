#!/bin/bash
cat <<tac >setup.cfg
[install]
prefix=/usr
install-lib=$2

[bdist_rpm]
release=$1
tac
