#!/bin/csh
# Stupid wrapper script required because doxyfile FILTER_PATTERN doesn't allow passing an option
# Package Mode is an experimental option and isn't recommended at this point
../filter/idv_doxyfilter_sv.pl --package_mode $1

