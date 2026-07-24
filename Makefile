# Makefile for myside related tasks
# User configurable variables below

# Fill this in from `security find-identity -v -p codesigning` once you've
# created a Developer ID Application certificate (Xcode > Settings > Accounts
# > Manage Certificates).
DEV_ID_APP_IDENTITY="Developer ID Application: XXX XXX (ABCDF12345)"

#################################################

##Help - Show this help menu
help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

##  build - Create the `mysides` executable using swift build
build: clean
	swift build -c release --scratch-path build

##  clean - Clean up temporary working directories
clean:
	rm -rf build

##  sign - Code sign the release binary
sign: build
	codesign --force --options runtime --timestamp --sign "${DEV_ID_APP_IDENTITY}" build/release/mysides
	codesign --verify --verbose build/release/mysides
