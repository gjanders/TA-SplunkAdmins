rm -R ~/TA-SplunkAdminsPackage/TA-SplunkAdmins
mkdir -p ~/TA-SplunkAdminsPackage/TA-SplunkAdmins
cp -R ~/TA-SplunkAdmins/default ~/TA-SplunkAdminsPackage/TA-SplunkAdmins/
cp -R ~/TA-SplunkAdmins/LICENSE ~/TA-SplunkAdminsPackage/TA-SplunkAdmins/
cp -R ~/TA-SplunkAdmins/metadata ~/TA-SplunkAdminsPackage/TA-SplunkAdmins/
cp -R ~/TA-SplunkAdmins/NOTICE ~/TA-SplunkAdminsPackage/TA-SplunkAdmins/
cp -R ~/TA-SplunkAdmins/README.md ~/TA-SplunkAdminsPackage/TA-SplunkAdmins/
cp -R ~/TA-SplunkAdmins/bin ~/TA-SplunkAdminsPackage/TA-SplunkAdmins/
#cp -R ~/TA-SplunkAdmins/lib ~/TA-SplunkAdminsPackage/TA-SplunkAdmins/
cp -R ~/TA-SplunkAdmins/README ~/TA-SplunkAdminsPackage/TA-SplunkAdmins/
cp -R ~/TA-SplunkAdmins/static ~/TA-SplunkAdminsPackage/TA-SplunkAdmins/
cp -R ~/TA-SplunkAdmins/app.manifest ~/TA-SplunkAdminsPackage/TA-SplunkAdmins/
cd ~/TA-SplunkAdminsPackage/
tar -czf TA-SplunkAdmins.tgz TA-SplunkAdmins
cd -
cp ~/TA-SplunkAdminsPackage/TA-SplunkAdmins.tgz ~/TA-SplunkAdmins/
