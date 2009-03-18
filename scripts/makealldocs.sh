#!/bin/tcsh
cd ../../../OVMdocs/tags/1.7.1/
make docs PROJ_NUM=1.0.0 DOXY_VER=2.2.1
make docs PROJ_NUM=1.0.1 DOXY_VER=2.2.1
make docs PROJ_NUM=1.1.0 DOXY_VER=2.2.1
cd -
cd ../../../VMMdocs/1.5.1/
make docs PROJ_NUM=1.0.0 DOXY_VER=2.2.1
make docs PROJ_NUM=1.0.1 DOXY_VER=2.2.1
make docs PROJ_NUM=1.1.0 DOXY_VER=2.2.1
make docs PROJ_NUM=2.0.0 DOXY_VER=2.2.1
make docs PROJ_NUM=2.0.1 DOXY_VER=2.2.1
cd -
cd ../../../TealTrussDocs/tags/1.5.1/
make docs PROJ_NUM=1.62c DOXY_VER=2.2.1
cd -
cd ../../../SVtimersDocs/tags/1.3.1/
make docs PROJ_NUM=1.0.0 DOXY_VER=2.2.1
cd -
# Move to Upload Folder
rm -rf upload
mkdir upload
mv ../../OVMdocs/tags/1.7.1/ovm-* .
mv ../../../VVMdocs/tags/1.5.1/vmm-* .
mv ../../../TealTrussDocs/tags/1.5.1/teal_truss-*
mv ../../../SVtimersDocs/tags/1.3.1/timers-* .

