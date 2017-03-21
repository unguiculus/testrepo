#!/usr/bin/env bash

set -x
mvn deploy -fae -Dmaven.test.failure.ignore=false
