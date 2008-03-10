#!/usr/bin/perl -w
# $Id$
#-----------------------------------------------------------------------------
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#-----------------------------------------------------------------------------
# Title:        Doxygen Doxyfile Configuration file Template / Delta to Output
# Description:  This script converts an input Doxyfile template file and a
#               delta file and outputs a Doxyfile. The template Doxyfile is
#               a complete Doxyfile - usually generated from doxygen with a
#               'doxygen -g' command.  The delta Doxyfile is a set of changes
#               from the template doxyfile in a key = value format. Keys are 
#               the keywords defined in the template Doxyfile. The script 
#               grabs the key/value combinations from the delta file, searches
#               the template file for matching keys and replaces the values with
#               a new value from the delta file.
#               This script allows the generation of a single reference Doxyfile
#               (template) than can be altered slightly with project (delta).
#
# Usage:
#               idv_doxyfile_tmplconv.pl --path_doxyscr "../../../Doxygen" \
#                                        --path_prj "../../../project" \
#                                        --template Doxyfile.template \
#                                        --delta Doxyfile.delta \
#                                        --output Doxyfile.output
#
# NOTE:         Search for TODO and HACK notations in-line
# NOTE:         Script does not support multiline value definitions in either the
#               template or delta file.  (multiline == line with escaped \linefeed)
# NOTE:         No error / warning is generated when a match is not found
# TODO:         Add support for skipping commented (#) lines
# TODO:         Add support for multiline value definition in either template or delta
#
# Original Author: Sean O'Boyle
# Contact:         seanoboyle@intelligentdv.com)
# Company:         Intelligent Design Verification
# Company URL:     http://intelligentdv.com
#
# Download the most recent version here:
#                  http://intelligentdv.com/downloads
#
# File Bugs Here:  http://bugs.intelligentdv.com
#        Project:  DoxygenFilterSV
#
# File: idv_doxyfile_tmplconv.pl
# $LastChangedBy$
# $LastChangedDate$
# $LastChangedRevision$
#
#-----------------------------------------------------------------------------
use strict;
use Getopt::Long;

# Get command line options
my $path_doxyscr = '';
my $path_prj = '';
my $template_file = '';
my $delta_file = '';
my $output_file = '';
GetOptions ('path_doxyscr=s' => \$path_doxyscr,
            'path_prj=s' => \$path_prj,
            'template=s' => \$template_file,
            'delta=s' => \$delta_file,
            'output=s' => \$output_file);

open(TEMPLATE, '<', $template_file) or die "Can't open template file $!";
my @output_file_arr = <TEMPLATE>; # Slurp template file into output file array
close(TEMPLATE);

open(DELTA, '<', $delta_file) or die "Can't open delta file $!";
my @delta_file_arr = <DELTA>; # Slurp delta file into delta file array
close(DELTA);

# Create a Hash of Keys with values for everything that matches the ^KEY = VALUE \n pattern
my %delta_hash = ();
foreach (@delta_file_arr) {
   # Replace <PATH_*> with $path_* string
   s/<PATH_PRJ>/$path_prj/g;
   s/<PATH_DOXYSCR>/$path_doxyscr/g;
   # Search for key=value pattern; capture key/value into hash
   if (/^(\w+)(\s*)=(\s*)(.*)$/) {
      #print "got one! $1 = $4\n";
      $delta_hash{$1} = $4;
   }
}

# For Each key - find a match in the doxyfile output - if a match is found replace the line with the key = value from the delta file
my $replace_count = 0;
foreach my $key_delta (keys %delta_hash) {
   #print "key=".$key_delta."\n";
   foreach (@output_file_arr) {
      if (/(\w+)(\s*)=(\s*)(.*)$/) {
         my $key_template = $1;
         if ($key_template eq $key_delta) {
            print "replaced: \"".$1." = ".$4."\" with \"".$key_delta." = ".$delta_hash{$key_delta}."\"\n";
            $replace_count++;
            s/(\w+)(\s*)=(\s*)(.*)$/$key_delta$2= $delta_hash{$key_delta}\n/;
         }
      }
   }
}
print "replaced $replace_count key value combinations\n";
open (OUTPUT, '>', $output_file) or die "Can't open output file $!";
print OUTPUT @output_file_arr;


