#!/bin/tcsh

# Create Upload Folder
rm -rf upload
mkdir upload

# Make UVM Docs
cd ../../../UVMdocs/tags/1.0.0/
echo ""
echo "Making UVM 1.0.ea Docs"
sleep 5
make clean PROJ_NUM=1.0.ea DOXY_VER=2.6.2
make docs PROJ_NUM=1.0.ea DOXY_VER=2.6.2
echo ""
echo "Moving UVM Docs"
cd -
mv ../../../UVMdocs/tags/1.0.0/uvm-* upload/.

# Make OVM Docs
cd ../../../OVMdocs/tags/1.8.1/
echo ""
echo "Making OVM 1.0.0 Docs"
sleep 5
make clean PROJ_NUM=1.0.0 DOXY_VER=2.6.2
make docs PROJ_NUM=1.0.0 DOXY_VER=2.6.2
echo ""
echo "Making OVM 1.0.1 Docs"
sleep 5
make clean PROJ_NUM=1.0.1 DOXY_VER=2.6.2
make docs PROJ_NUM=1.0.1 DOXY_VER=2.6.2
echo ""
echo "Making OVM 1.1.0 Docs"
sleep 5
make clean PROJ_NUM=1.1.0 DOXY_VER=2.6.2
make docs PROJ_NUM=1.1.0 DOXY_VER=2.6.2
echo ""
echo "Making OVM 2.0.0 Docs"
sleep 5
make clean PROJ_NUM=2.0.0 DOXY_VER=2.6.2
make docs PROJ_NUM=2.0.0 DOXY_VER=2.6.2
echo ""
echo "Making OVM 2.0.1 Docs"
sleep 5
make clean PROJ_NUM=2.0.1 DOXY_VER=2.6.2
make docs PROJ_NUM=2.0.1 DOXY_VER=2.6.2
echo ""
echo "Making OVM 2.0.2 Docs"
sleep 5
make clean PROJ_NUM=2.0.2 DOXY_VER=2.6.2
make docs PROJ_NUM=2.0.2 DOXY_VER=2.6.2
echo ""
echo "Making OVM 2.0.3 Docs"
sleep 5
make clean PROJ_NUM=2.0.3 DOXY_VER=2.6.2
make docs PROJ_NUM=2.0.3 DOXY_VER=2.6.2
echo ""
echo "Making OVM 2.1.0 Docs"
sleep 5
make clean PROJ_NUM=2.1.0 DOXY_VER=2.6.2
make docs PROJ_NUM=2.1.0 DOXY_VER=2.6.2
echo ""
echo "Making OVM 2.1.1 Docs"
sleep 5
make clean PROJ_NUM=2.1.1 DOXY_VER=2.6.2
make docs PROJ_NUM=2.1.1 DOXY_VER=2.6.2
echo ""
echo "Moving OVM Docs"
cd -
mv ../../../OVMdocs/tags/1.8.1/ovm-* upload/.

# Make VMM Docs
cd ../../../VMMdocs/tags/1.6.2/
echo ""
echo "Making VMM 1.0.0 Docs"
sleep 5
make clean PROJ_NUM=1.0.0 DOXY_VER=2.6.2
make docs PROJ_NUM=1.0.0 DOXY_VER=2.6.2
echo ""
echo "Making VMM 1.0.1 Docs"
sleep 5
make clean PROJ_NUM=1.0.1 DOXY_VER=2.6.2
make docs PROJ_NUM=1.0.1 DOXY_VER=2.6.2
echo ""
echo "Making VMM 1.1.0 Docs"
sleep 5
make clean PROJ_NUM=1.1.0 DOXY_VER=2.6.2
make docs PROJ_NUM=1.1.0 DOXY_VER=2.6.2
echo ""
echo "Making VMM 1.1.1 Docs"
sleep 5
make clean PROJ_NUM=1.1.1 DOXY_VER=2.6.2
make docs PROJ_NUM=1.1.1 DOXY_VER=2.6.2
echo ""
echo "Making VMM 1.2.0 Docs"
sleep 5
make clean PROJ_NUM=1.2.0 DOXY_VER=2.6.2
make docs PROJ_NUM=1.2.0 DOXY_VER=2.6.2
echo ""
echo "Moving VMM Docs"
cd -
mv ../../../VMMdocs/tags/1.6.2/vmm-* upload/.

# Make Teal Trus Docs
cd ../../../TealTrussDocs/tags/1.6.0/
echo ""
echo "Making Teal Truss 1.62c Docs"
sleep 5
make clean PROJ_NUM=1.62c DOXY_VER=2.6.2
make docs PROJ_NUM=1.62c DOXY_VER=2.6.2
echo ""
echo "Moving Teal Truss Docs"
cd -
mv ../../../TealTrussDocs/tags/1.6.0/teal_truss-* upload/.

# Make SV Timers Docs
cd ../../../SVtimersDocs/tags/1.7.0/
echo ""
echo "Making Timers 1.3.1 Docs"
sleep 5
make clean PROJ_NUM=1.3.1 DOXY_VER=2.6.2
make docs PROJ_NUM=1.3.1 DOXY_VER=2.6.2
echo ""
echo "Making Timers 1.2.0 Docs"
sleep 5
make clean PROJ_NUM=1.2.0 DOXY_VER=2.6.2
make docs PROJ_NUM=1.2.0 DOXY_VER=2.6.2
echo ""
echo "Making Timers 1.1.1 Docs"
sleep 5
make clean PROJ_NUM=1.1.1 DOXY_VER=2.6.2
make docs PROJ_NUM=1.1.1 DOXY_VER=2.6.2
echo ""
echo "Making Timers 1.0.0 Docs"
sleep 5
make clean PROJ_NUM=1.0.0 DOXY_VER=2.6.2
make docs PROJ_NUM=1.0.0 DOXY_VER=2.6.2
echo ""
echo "Moving Timers Docs"
cd -
mv ../../../SVtimersDocs/tags/1.7.0/timers-* upload/.

# Make SV Timers Docs
cd ../../../SVresetDocs/tags/1.0.1/
echo ""
echo "Making Reset 1.0.0 Docs"
sleep 5
make clean PROJ_NUM=1.0.0 DOXY_VER=2.6.2
make docs PROJ_NUM=1.0.0 DOXY_VER=2.6.2
echo ""
echo "Moving Reset Docs"
cd -
mv ../../../SVresetDocs/tags/1.0.1/SVreset-* upload/.

# Make Doxygen Test Docs
echo ""
echo "Making Doxygen Test Docs"
sleep 5
cd ../test
make clean
make docs
echo ""
echo "Moving Test Docs"
cd -
mv ../test/test_doc upload/.




