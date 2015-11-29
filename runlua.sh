#!/bin/bash
PORT=$1
luatool.py --port ${PORT} --src httppost_bluejelly.lua --dest httppost.lua
luatool.py --port ${PORT} --src tmp102.lua
luatool.py --port ${PORT} --src init.lua --dest init.lua -r
