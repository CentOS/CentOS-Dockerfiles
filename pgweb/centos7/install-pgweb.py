# Python script used for ease of json parsing and installation of packages such as jq and unzip for single run through the lifetime of the container.
from os import remove, path, mkdir, getenv
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

print "Setting up pgweb..."
# This is the url of the github api endpoint to query for release information of pgweb 
pgweb_info_url = "https://api.github.com/repos/sosedoff/pgweb/releases"
# The location the save the pgweb zip file once we have it
pgweb_downloc = "./pgweb.zip"
# This is the location where the app will reside
app_loc = "/app"
version = getenv("VERSION")
assets = None
if not version:
    print "No version specified, going with latest binaries..."
    req_url = pgweb_info_url + "/latest"
    pgweb_req = _request_url(req_url)
    if pgweb_req is None:
        print "Error, could not get binary information..."
        exit(1)
    assets = load(pgweb_req)["assets"]
else:
    print "Version " + version + " specified, finding appropriate binaries.."
    pgweb_req = _request_url(pgweb_info_url)
    if pgweb_req is None:
        print "Error, could not get binary information..."
        exit(1)
    pkgs = load(pgweb_req)
    for pkg in pkgs:
        if version == pkg["name"]:
            assets = pkg["assets"]
            break

# Search the asset for of the appropriate platform for the assets
for asset in assets:
    if "linux" in asset["name"] and "amd64" in asset["name"]:
        # Once found, get the download url of zip from the asset JSON
        found = True
        print "Downloading binaries, please wait..."
        tarball = urlopen(str(asset["browser_download_url"]))
        if tarball is None:
            print "Failed to download pgweb binaries"
            exit(1)

        # Save the downloaded zip file to download location.
        with open(pgweb_downloc, "w+") as tarball_file:
            tarball_file.write(tarball.read())

        # Extract the zipfile (using inbuilt python library Zipfile - avoids unzip package)
        print "Installing, please wait..."
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
