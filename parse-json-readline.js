#!/usr/bin/env node
"strict";
// See: http://stackoverflow.com/a/32599033
require('readline').createInterface({ input: process.stdin })
    .on('line', function (line) {
        JSON.parse(line);
    });
