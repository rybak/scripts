#!/bin/bash

# filesystem/typing-friendly variations of datetime output
date_minutes () {
	date +%Y-%m-%dT%H-%M
}

date_seconds () {
	date +%Y-%m-%dT%H-%M-%S
}

date_unix () {
	date +%s
}
