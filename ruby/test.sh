#!/bin/bash

master="regression/master.txt"
current="regression/current.txt"

if [ -f $master ]; then
  echo "Running regression tests against $master"
else
  echo "$master not found"
  exit 1
fi

ruby texttest_fixture.rb 30 > $current

# FIXME this line fails with a permission error
result=diff $master $current

if [ -z $result ]; then
  echo "Pass"
else
  echo "Fail"
  echo $result
fi
