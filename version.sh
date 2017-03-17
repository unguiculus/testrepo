#!/usr/bin/env bash

echo $1
mvn versions:set -DnewVersion=$1
