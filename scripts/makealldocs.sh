#!/bin/tcsh

# Create Upload Folder
rm -rf upload
mkdir upload

# Make OVM Docs
cd ../../../OVMdocs/tags/1.8.0/
echo ""
echo "Making OVM 1.0.0 Docs"
sleep 5
make clean PROJ_NUM=1.0.0 DOXY_VER=2.5.1
make docs PROJ_NUM=1.0.0 DOXY_VER=2.5.1
echo ""
echo "Making OVM 1.0.1 Docs"
sleep 5
make clean PROJ_NUM=1.0.1 DOXY_VER=2.5.1
make docs PROJ_NUM=1.0.1 DOXY_VER=2.5.1
echo ""
echo "Making OVM 1.1.0 Docs"
sleep 5
make clean PROJ_NUM=1.1.0 DOXY_VER=2.5.1
make docs PROJ_NUM=1.1.0 DOXY_VER=2.5.1
echo ""
echo "Making OVM 2.0.0 Docs"
sleep 5
make clean PROJ_NUM=2.0.0 DOXY_VER=2.5.1
make docs PROJ_NUM=2.0.0 DOXY_VER=2.5.1
echo ""
echo "Making OVM 2.0.1 Docs"
sleep 5
make clean PROJ_NUM=2.0.1 DOXY_VER=2.5.1
make docs PROJ_NUM=2.0.1 DOXY_VER=2.5.1
echo ""
echo "Making OVM 2.0.2 Docs"
sleep 5
make clean PROJ_NUM=2.0.2 DOXY_VER=2.5.1
make docs PROJ_NUM=2.0.2 DOXY_VER=2.5.1
cd -
mv ../../../OVMdocs/tags/1.8.0/ovm-* upload/.

# Make VMM Docs
cd ../../../VMMdocs/tags/1.6.0/
echo ""
echo "Making VMM 1.0.0 Docs"
sleep 5
make clean PROJ_NUM=1.0.0 DOXY_VER=2.5.1
make docs PROJ_NUM=1.0.0 DOXY_VER=2.5.1
echo ""
echo "Making VMM 1.0.1 Docs"
sleep 5
make clean PROJ_NUM=1.0.1 DOXY_VER=2.5.1
make docs PROJ_NUM=1.0.1 DOXY_VER=2.5.1
echo ""
echo "Making VMM 1.1.0 Docs"
sleep 5
make clean PROJ_NUM=1.1.0 DOXY_VER=2.5.1
make docs PROJ_NUM=1.1.0 DOXY_VER=2.5.1
cd -
mv ../../../VMMdocs/tags/1.6.0/vmm-* upload/.

# Make Teal Trus Docs
cd ../../../TealTrussDocs/tags/1.6.0/
echo ""
echo "Making Teal Truss 1.62c Docs"
sleep 5
make clean PROJ_NUM=1.62c DOXY_VER=2.5.1
make docs PROJ_NUM=1.62c DOXY_VER=2.5.1
cd -
mv ../../../TealTrussDocs/tags/1.6.0/teal_truss-* upload/.

# Make SV Timers Docs
cd ../../../SVtimersDocs/tags/1.7.0/
echo ""
echo "Making Timers 1.3.1 Docs"
sleep 5
make clean PROJ_NUM=1.3.1 DOXY_VER=2.5.1
make docs PROJ_NUM=1.3.1 DOXY_VER=2.5.1
echo ""
echo "Making Timers 1.2.0 Docs"
sleep 5
make clean PROJ_NUM=1.2.0 DOXY_VER=2.5.1
make docs PROJ_NUM=1.2.0 DOXY_VER=2.5.1
echo ""
echo "Making Timers 1.1.1 Docs"
sleep 5
make clean PROJ_NUM=1.1.1 DOXY_VER=2.5.1
make docs PROJ_NUM=1.1.1 DOXY_VER=2.5.1
echo ""
echo "Making Timers 1.0.0 Docs"
sleep 5
make clean PROJ_NUM=1.0.0 DOXY_VER=2.5.1
make docs PROJ_NUM=1.0.0 DOXY_VER=2.5.1
cd -
mv ../../../SVtimersDocs/tags/1.7.0/timers-* upload/.

# Make SV Timers Docs
cd ../../../SVresetDocs/tags/1.0.0/
echo ""
echo "Making Reset 1.0.0 Docs"
sleep 5
make clean PROJ_NUM=1.0.0 DOXY_VER=2.5.1
make docs PROJ_NUM=1.0.0 DOXY_VER=2.5.1
cd -
mv ../../../SVresetDocs/tags/1.0.0/SVreset-* upload/.

# Make Doxygen Test Docs
echo ""
echo "Making Doxygen Test Docs"
sleep 5
cd ../test
make clean
make docs
cd -
mv ../test/test_doc upload/.




