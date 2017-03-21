#!/usr/bin/env bash

set -x
mvn deploy -Dmaven.test.failure.ignore=true
