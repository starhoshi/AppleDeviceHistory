#!/bin/sh -x

bundle exec pod update && bundle exec carthage_acknowledgements generate -o=./AppleDeviceHistory/Resources/Settings.bundle/Acknowledgements.plist -p=AppleDeviceHistory

