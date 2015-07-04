#!/usr/bin/python3
from glob import glob
from os import remove

teamspeak_path = '/var/local/teamspeak-server/files/*/channel_*/*'
for filebrowser_file in glob(teamspeak_path):
    remove(filebrowser_file)
