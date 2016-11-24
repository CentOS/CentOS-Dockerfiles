# Python script used for ease of json parsing and installation of packages such as jq and unzip for single run through the lifetime of the container.
from os import remove, path, mkdir
from json import load
from urllib2 import urlopen
from subprocess import check_call, CalledProcessError
from zipfile import ZipFile


def execute_command(cmd):
    """Execute a specified command"""
    try:
        check_call(cmd)
        return True
    except CalledProcessError:
        return False


def _request_url(url):

    try:
        req = urlopen(url)
    except Exception:
        req = None

    return req

# This is the url of the github api endpoint to query for release information of pgweb 
pgweb_info_url = "https://api.github.com/repos/sosedoff/pgweb/releases/latest"
# The location the save the pgweb zip file once we have it
pgweb_downloc = "./pgweb.zip"
# This is the location where the app will reside
app_loc = "/app"

# Request the github api for information related to latest release of pgweb.
pgweb_req = _request_url(pgweb_info_url)
if pgweb_req is None:
    exit(1)

# Extract the assets from the JSON returned by the api. Primary use of python here to parse the JSON. Avoids need to install packages such as jq to parse the json.
assets = load(pgweb_req)["assets"]
found = False

# Search the asset for of the appropriate platform for the assets
for asset in assets:
    if "linux" in asset["name"] and "amd64" in asset["name"]:
        # Once found, get the download url of zip from the asset JSON
        found = True
        print "Getting pgweb, please wait..."
        tarball = urlopen(str(asset["browser_download_url"]))
        if tarball is None:
            print "Failed to get pgweb binaries"
            exit(1)

        # Save the downloaded zip file to download location.
        with open(pgweb_downloc, "w+") as tarball_file:
            tarball_file.write(tarball.read())

        # Extract the zipfile (using inbuilt python library Zipfile - avoids unzip package)
        print "Installing pgweb, please wait..."
        if not path.exists(app_loc):
            mkdir(app_loc)
        with ZipFile(pgweb_downloc) as zip_file:
            zip_file.extractall(app_loc)
        remove(pgweb_downloc)

        # Create the appropriate user to make use of the service
        print "Creating user..."
        if not execute_command(["useradd", "-ms", "/bin/bash", "pgweb"]):
            print "Failed to create pgweb user."
            exit(1)
        print "Done"
        break
if not found:
    print "Could not find the pgweb release information from github."
    exit(1)
