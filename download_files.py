# function to work with the google api 
# you will need to enable your api and generate a key
# `GoogleAuth` will look for a "client_secrets.json" in the base directory
# You need to get the google drive file directory ID see analysis script for examples

import pydrive
from pydrive.drive import GoogleDrive
from pydrive.auth import GoogleAuth

gauth = GoogleAuth()
gauth.LocalWebserverAuth()
drive = GoogleDrive(gauth)


def download_files(folder_id = None):
	file_list = drive.ListFile({'q': "'{}' in parents and trashed=false".format(folder_id)}).GetList()
	
	for file1 in sorted(file_list, key = lambda x: x['title']):
		print('Downloading {} from GDrive ({}/{})'.format(file1['title'], file1, len(file_list)))
		file1.GetContentFile(file1['title'])

	for file1 in file_list:
		print('title: %s, id: %s' % (file1['title'], file1['id']))


