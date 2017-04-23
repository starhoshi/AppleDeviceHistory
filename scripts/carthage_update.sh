#!/bin/sh -x

carthage update --platform iOS --no-use-binaries && bundle exec carthage_acknowledgements generate -o=./AppleDeviceHistory/Resources/Settings.bundle/Acknowledgements.plist -p=AppleDeviceHistory

