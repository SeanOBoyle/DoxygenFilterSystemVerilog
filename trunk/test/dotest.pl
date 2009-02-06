#!/usr/bin/perl -w
use strict;

# Simple Script to diff filter output against golden expected output
my $status = system("../filter/idv_doxyfilter_sv.pl < test.sv > test.cpp");

$status = system("diff test.cpp test.cpp.golden");
  
if ($status !=0) {
   print "Fail";
}
else {
   print "Pass";
}

system ("rm -f test.cpp");

