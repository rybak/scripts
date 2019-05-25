#!/bin/bash

# filesystem/typing-friendly variations of datetime output
date_minutes () {
	date +%y-%m-%dT%H-%M
}

date_seconds () {
	date +%y-%m-%dT%H-%M-%S
}

date_unix () {
	date +%s
}
