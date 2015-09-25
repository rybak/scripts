#!/bin/bash

look . | grep -E "^[a-z]{4,6}$" | shuf | head -4 | xargs 
