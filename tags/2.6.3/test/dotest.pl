#!/usr/bin/perl -w
use strict;
use Getopt::Long;

# Get command line options
my $package_mode = '';
GetOptions ('package_mode' => \$package_mode # experimental feature - add support for SV packages -- make look like C++ namespace
           );

my $status;
if ($package_mode) {
   # Simple Script to diff filter output against golden expected output
   $status = system("../filter/idv_doxyfilter_sv.pl --package_mode < test.sv > test.cpp ");
   $status = system("diff test_namespace.cpp.golden test.cpp");

}
else {
   # Simple Script to diff filter output against golden expected output
   $status = system("../filter/idv_doxyfilter_sv.pl < test.sv > test.cpp");
   $status = system("diff test.cpp.golden test.cpp");
}

if ($status !=0) {
   print "Fail";
}
else {
   print "Pass";
}

system ("rm -f test.cpp");

