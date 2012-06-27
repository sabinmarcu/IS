#!/bin/bash
coffee boot -c lib/application.js
coffee boot -c spec/IS
codo -o ./docs --title "IS Framework Documentation" -r README.md ./src
jasmine-node --coffee --noColor spec