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
# Title:        Doxygen Filter for the SystemVerilog Language
# Description:  This script converts SystemVerilog code to C++ "like" code
#               for the purpose of documenting in Doxygen.  (This script
#               is not a language transalation script.)
#               The script traverses the input SV file line-by-line and outputs
#               a C++ like file. Specifics are noted in-line.
#               This script was generated heuristically - so there will likely
#               be new issues discovered.
#
# NOTE:         Search for TODO and HACK notations in-line
# NOTE:         HACK items are typically due to either:
#                   1) preprocessor macro used to define an SV keyword
#                        (keywords need to be present in order for the filter to work)
#                   2) strange (and arguably illegal) SV coding
# NOTE:         Preprocessor Macros are a PITA! Doxygen does the replace for me - 
#               and there are a number of instances where an SV pattern to CPP pattern
#               would work fine IF the preprocessor ran *before* the filter. Sooo...
#               TODO: integrate SV preprocessor that does the `DEFINE replaces in 
#                     this filter.
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
# File: idv_doxyfilter_sv.pl
# $LastChangedBy$
# $LastChangedDate$
# $LastChangedRevision$
#
#-----------------------------------------------------------------------------

use strict;

my $blockcomment = 0;
my $doxyblockcomment = 0;
my $multiline_macro = 0;
my $inline_comment = "";
my $covergroup = 0;
my $covergroup_name = "";
my $constraint = 0;
my $program_start = 0;
my $module_start = 0;
my $interface_start = 0;
my $stringconcat = 0;
my $onelinestringconcat = "";
my $class = 0;
my $classname = "";
my $class_start = 0;
my $derived_class = 0;
my $template_class = 0;
my $template = 0;
my $access_specifier = "";
my $function = 0;
my $function_start = 0;
my $ispure = 0;
my $isextern = 0;

my @infile = <>;  # slurp from STDIN
my $infile_line = 0;
# Process the SV File Line-by-Line
foreach (@infile) {
   $inline_comment = "";
   $infile_line++;

   #-----------------------------------------------------------------------------
   #
   # Deal with Comments
   #
   #-----------------------------------------------------------------------------
   # Detect Single Line Comments
   #  Looking for:
   #   ... // comment
   #   or
   #   ... /// doxygen comment
   #   or
   #   ... /* comment */
   # Current Strategy:
   #   - skip all commented lines
   #   - Don't want to filter the comment so we remove the comment
   #   - BUT - we want to save the comment if it was a doxygen comment
   #           so we'll put back the comment at the end
   if (!$blockcomment) {
      if (/(\/\/.*)/) {
         $inline_comment = $1;
         s/\/\/.*//;  # strip comment off of the line
      }
      elsif (/(\/\*.*\*\/)/) {
         $inline_comment = $1;
         s/\/\*.*\*\///;  # strip comment off of the line
      }
   }

   # Block Comment Start
   #  Looking for:
   #   /*
   # Current Strategy:
   #   - skip all commented lines
   if (/\/\*/) {
      $blockcomment = 1;
   }

   # Detect Doxygen Block Comment
   #  Looking for:
   #   /**
   # Current Strategy:
   #   - skip all commented lines
   if (/\/\*\*/) {
      $doxyblockcomment = 1;
   }

   # Detect Doxygen Block Comment
   #  Looking for:
   #   /*!
   # Current Strategy:
   #   - skip all commented lines
   if (/\/\*\!/) {
      $doxyblockcomment = 1;
   }

   # Skip Block Commented Code
   #  We don't try to filter SV code that is commented
   # Current Strategy:
   #   - skip all commented lines
   if ($blockcomment) {
      if ($doxyblockcomment) {
         # Inside a doxygen block commente
         # we can look for @ or \ markup in here
         # if we want to do something special
      }
      if (/\*\//) { # found the end of a block comment
         $blockcomment = 0;
         $doxyblockcomment = 0;
      }
      print;
      next;  # skip to next line of file
   }

   # Detect and Skip Full Line Single-Line Comments
   #  Looking for:
   #   // comment
   # Current Strategy:
   #   - skip all commented lines
   #   - entire line is commented so skip to next line of file
   if (/^\s*\/\//) {
      # Doxygen Line Comments
      #  Looking for:
      #    ///
      # We can do doxygen preprocessing if needed here
      if (/^\s*\/\/\//) {
         # Nothing to do here right now
      }
      print; # print the comment as is
      next;  # skip to next line of file
   }

   #-----------------------------------------------------------------------------
   #
   # Deal with Symbols that Break Doxygen Parsing
   #   -- tickmarks need to be closed in doxygen - so get rid of all SV unclosed tickmarks
   #
   #-----------------------------------------------------------------------------
   # Literals with X or Z
   # Looking for:
   # ... 5'h.X..
   # ... 5'b.Z..
   # ... 5'd.z..
   # Current Strategy:
   #   - no strategy
   #   - TODO: if we encounter an issue - put the fix here

   # Sized Literals
   # Looking for:
   # ... 5'h...
   # ... 5'b...
   # ... 5'd...
   # Current Strategy:
   #   - change to 0x, 0b, 0d
   s/\d+\s*'[h|H]/0x/;
   s/\d+\s*'[d|D]/0d/;
   s/\d+\s*'[b|B]/0b/;
   s/\d+\s*'[o|O]/0o/;

   # UnSized Literals
   # Looking for:
   # ... 'h...
   # ... 'b...
   # ... 'd...
   # Current Strategy:
   #   - change to 0x, 0b, 0d
   s/'[h|H]/0x/;
   s/'[d|D]/0d/;
   s/'[b|B]/0b/;
   s/'[o|O]/0o/;

   # Static Casting
   # SV static cast uses a tick (') where C++ foregoes the tick
   # Looking for:
   # ... typename'(value or equation) ...
   # Current Strategy:
   #   - make it look like a C++ static cast: typename(value or equation) by removing the tick
   s/(.+)\s*'\s*\((.+)\)/$1($2)/;
   s/(.+)\s*'\s*\{(.+)\}/$1($2)/;

   # Remaining Tickmarks
   # Looking for:
   #  ...'...
   # Current Strategy:
   #    - get rid of any tickmarks that remain (after the above more accurate conversions)
   s/'//g;

   #-----------------------------------------------------------------------------
   #
   # Deal with Macros
   #
   #-----------------------------------------------------------------------------
   # Preprocessor Macros
   # Looking for:
   #   Anything that starts with a backtick (`)
   # Current Strategy:
   #   - HACK: hand replace any defines that are used to define SV keywords
   #   - replace the backtick with a pound sign (#) for defined C++ macros
   #   - double tick (``) is replaced with ##
   #   - anything else that starts with a tick (`) is assume to be a #define - so the tick is removed
   #   - print the line as is; don't try to continue filtering the line

   # HACK - in OVM `define for _protected is protected
   s/`_protected/protected/;
   # HACK: teal/truss preprocessor macro: `PURE pure
   s/`PURE/pure/;
   # HACK: vmm preprocessor macro: VMM_HW_RTL_COMPONENT_START   interface
   s/`VMM_HW_RTL_COMPONENT_START\b/interface/;
   # HACK: vmm preprocessor macro: VMM_HW_RTL_COMPONENT_END   endinterface
   s/`VMM_HW_RTL_COMPONENT_END\b/endinterface/; 
   # HACK: vmm preprocessor macro: VMM_CONSENSUS vmm_consensus
   s/`VMM_CONSENSUS\b/vmm_consensus/;
   # HACK: VMM_DATA_BASE_NEW_EXTERN_ARGS; VMM_DATA_NEW_ARGS; etc.
   s/`VMM_.*?_ARGS//;

   if (/^\s*`/) {
   
      s/`(define|error|import|undef|elif|if|include|using|else|ifdef|line|endif|ifndef|pragma)/#$1/;
      s/``/##/g;
      s/`(\w)/$1/g;
      if (/\\\s*$/) {
         $multiline_macro = 1;
      }
      if ($inline_comment ne "") {
         s/$/ $inline_comment/;
         $inline_comment = "";
      }
      print;
      next;  # skip to next line of file
   }
   
   # Remaining BackTickmarks
   # Looking for:
   #  ...`...
   # Current Strategy:
   #    - get rid of any backtickmarks that remain (after the above more accurate conversions)
   s/`//g;

   # Multiline Preprocessor Macros
   # Assuming that the only use of line continuation marker is for multiline preprocessor macros
   # Looking for:
   #   Line Continuation (\) LF
   # Current Strategy:
   #   - print the line as is; don't try to continue filtering the line
   #   - the last line of the macro doesn't have an escape - so we keep track of this
   if ($multiline_macro) {
      if (/\\\s*$/) {
         $multiline_macro = 1;
      }
      else {
         $multiline_macro = 0;
      }
      print;
      next;  # skip to next line of file
   }

   #-----------------------------------------------------------------------------
   #
   # Deal with Stuff that C++ Doesn't Have
   #
   #-----------------------------------------------------------------------------
   # Coverage Groups
   # Looking for:
   #  covergroup covergroup_name;
   #    ...
   #  endgroup
   # Current Strategy:
   #   - Print the first line: it will be documented like a variable of type covergroup
   #   - replace the remaining lines with empty lines (so that the code reference lines match)
   # Dealing with the contents of a covergroup is tough b/c of all of the curly braces
   # TODO: if covergroup is defined as extern then we're hosed here
   # TODO: if covergroup is defined and implemented in one line then we're hosed here
   # TODO: if the covergroup has a trigger (@) then this may break
   # TODO: since a covergroup can take parameters we may want to make these look like methods that return type 'covergroup' instead of variables
   if (/\bcovergroup\b/) {
      print;  # print covergroup line
      $covergroup = 1;
      next;  # skip to next line of file
   }
   # replace covergroup lines with empty lines
   if ($covergroup) {
      if (/\bendgroup\b/) {
        $covergroup = 0;
      }
      print "\n";  # print empty line
      next;  # skip to next line of file
   }

   # Constraints
   # Looking for:
   #  constraint constraint_name {
   #    ...
   #  }
   # Current Strategy:
   #   - Print the first line: it will be documented like a variable of type constraint
   #   - replace the remaining lines with empty lines (so that the code reference lines match)
   if (/\bconstraint\b/) {
      if (/\{/) {
         s/\{/;/; # replace } with ; -- document like member variable
         $constraint = 1;
      }
      print; # print constraint to look like member variable
      next;  # skip to next line of file
   }
   # replace covergroup lines with empty lines
   if ($constraint) {
      if (/\{/) {
         $constraint++;
      }
      if (/\}/) {
         $constraint--;
      }
      if ($constraint < 0) {
         $constraint = 0;
      }
      print "\n";  # print empty line
      next;  # skip to next line of file
   }

   # Program Block
   #   SV Program Block
   # Looking for:
   # ... program foo;
   # ... program foo(...);
   # Current Strategy:
   #   - make look like C++ function that returns type program
   if (/\bprogram\s+(\w)\s*/) {
      $program_start = 1;
      if (s/\bprogram\s+(\w+)\s*\((.*?)\)/program $1($2)/) {}
      else {s/\bprogram\s+(\w+)/program $1(/;}
   }
   if ($program_start) {
      if (s/\)\s*;/) {/) {
         $program_start = 0;
      }
      elsif (s/;/) {/) {
         $program_start = 0;
      }
   }

   # Module Block
   #   SV Module Block
   # Looking for:
   # ... module foo;
   # ... module foo(...);
   # Current Strategy:
   #   - make look like C++ function that returns type module
   if (/\bmodule\s+(\w)\s*/) {
      $module_start = 1;
      if (s/\bmodule\s+(\w+)\s*\((.*?)\)/module $1($2)/) {}
      else {s/\bmodule\s+(\w+)/module $1(/;}
   }
   if ($module_start) {
      if (s/\)\s*;/) {/) {
         $module_start = 0;
      }
      elsif (s/;/) {/) {
         $module_start = 0;
      }
   }

   
   # Initial Block, Final Block
   # Looking for:
   # ... initial ...
   # ... final ...
   # Current Strategy:
   # - remove keyword (initial is always followed by begin - begin is transformed to '{' so contents of initial block just look like new scope
   s/\binitial\b//;
   s/\bfinal\b//;
   
   # Virtual Interface Declaration
   # Looking for:
   # ... virtual interface foo ...
   # Current Strategy:
   #   - make look like C++ variable of type foo (remove string 'virtual interface'
   s/\bvirtual\s+?interface//;

   # Interface Block
   #   SV Interface Block
   # Looking for:
   # ... interface foo;
   # ... program foo(...);
   # Current Strategy:
   #   - make look like C++ function that returns type interface
#   s/\binterface\s+(\w+)\s*\((.*?)\)\s*;/interface $1($2) {/;
#   s/\binterface\s+(\w+)\s*;/interface $1() {/;
   if (/\binterface\s+(\w+)\s*/) {
      $interface_start = 1;
      if (s/\binterface\s+(\w+)\s*?\((.*?)\)/interface $1($2)/) {}
      elsif (/\binterface\s+?(\w+?)\s*\(/) {
         $interface_start = 1;
      }
      else {s/\binterface\s+(\w+)/interface $1()/;}
   }
   if ($interface_start) {
      if (s/\)\s*;/) {/) {
         $interface_start = 0;
      }
      elsif (s/;/) {/) {
         $interface_start = 0;
      }
   }


   # Logic Types with defined widths
   # Looking for:
   #  logic [10:4] foo ...
   #  bit[1:0]     wee ...
   #
   # Current Strategy:
   #   - Convert to a C++ template class instance
   s/\b(logic|bit|wire|reg)\s*?\[(.+?):(.+?)\]\s*?/$1 <$2:$3> /g;

   # Static Sized Arrays defined with ranges
   # Looking for:
   #  ... foo [1:54]...
   #  ... goo [54:1]...
   #
   # Current Strategy:
   #   - Convert to a C++ style array (do the math)
   if (/\[(\d):(\d)\]/) {
      my $num1 = $1;
      my $num2 = $2;
      my $size = 0;
      if ($num1 < $num2) {
         $size = $num2 - $num1 + 1;
      }
      else {
         $size = $num1 - $num2 + 1;
      }
      s/\[(\d):(\d)\]/[$size]/
   }

   # Timeunit / TimePrecision:
   # Have no meaning to C++ and are typically on their own line in SV
   # Current Strategy:
   #   - get rid of the entire line
   #
   if (/\btimeunit\b/) {
      print "\n";
      next;  # skip to next line of file
   }
   if (/\btimeprecision\b/) {
      print "\n";
      next;  # skip to next line of file
   }

   # DPI Exports
   # A DPI Import is just another method available at the scope where the import occured
   # Looking for:
   #   - export ...
   # Current Strategy:
   #   - get rid of the entire line
   if (/\bexport\b/) {
      print "\n";
      next;  # skip to next line of file
   }

   # Logic / Bit Vectors
   # Seems like doxygen prefers a no space between logic and width
   # Looking for:
   #   - logic[
   # Current Strategy:
   #   - remove space between logic and [
   s/logic\s+\[/logic\[/;

   #-----------------------------------------------------------------------------
   #
   # Deal with Stuff that C++ Does Have -- convert the syntax from SV to C++
   #
   #-----------------------------------------------------------------------------
   # DPI Imports
   # A DPI Import is just another method available at the scope where the import occured
   # Looking for:
   #   - import "DPI.." function
   # Current Strategy:
   #   - make it look like a C++ function; remove the import "DPI.."
   if (/\bimport\s+"DPI/) {
      s/import\s+"DPI.*"\s+function(.*);/$1 {}/;
      s/import\s+"DPI.*"\s+task(.*);/$1 {}/;
      print;
      next;  # skip to next line of file
   }
   
   # Pass by Reference
   # 
   # Looking for: ... ref foo ...
   # Current Strategy:
   #   - make it look like a C++ reference
   # NOTE: this isn't really required -- doxygen can still parse with 'ref'
   #s/\bref\s+(\w+)/$1&/;

   # Packages
   # An SV package is very similar to a C++ namespace; let's see if I can get this to work...
   # Looking for:
   #   - package mypackage;
   # Current Strategy:
   #   - make it look like a C++ namespace
   # TODO: uncomment this section once I can figure out how to get it working properly
   #       for now having everything in the global space looks better
#    if (/\bpackage\b/) {
#       s/\bpackage\b(.*?);/namespace $1 {/;
#    }
#    s/\bendpackage\s*:\s*\S+/}/;
#    s/\bendpackage\b/}/;
#    s/\bimport\s+(\w+)::(.*)?;/using namespace $1;/;
   # HACK: since I'm ignoring packages everything is in the global namespace; so can't extend from a specific package
   s/extends (\w+)::/extends /;
   

   # Case Statement
   # SV case looks exactly like C++ case except that C++ case opens with {
   # SV also has special types of case not in C++ (casez, casex)
   # Current Strategy:
   #   - change casex and casez to case
   #   - open case like C++
   s/\bcasez\b/case/;
   s/\bcasex\b/case/;
   if (/\bcase\b/) {
      s/case(.*)\)/case $1) { /;
   }

   # Enumerated Type
   # SV Enumerated Type looks exactly like C++ enum
   # Except that C++ enums are always of type int
   #   SV: [optional type with optional bit width] enum {...} enumname
   #  C++: enum {...} enumname
   # Current Strategy:
   #   - get rid of any optional type information
   if (/typedef enum/) {
   s/enum.*?{/enum {/;
   }
   else {
      s/enum.*?{/typedef enum {/;
   }

   # Class
   # A C++ class looks exactly like an SV class with these exceptions:
   #   - derived class different keyword (taken care of above)
   #   - C++ class opens with { while SV class opens with ;
   #      SV: class myderivedclass extends mybaseclass; ...
   #     C++: class myderivedclass : public mybaseclass { ...
   #   - A forward declared class in SV is the SAME as one in C++
   #   - SV parameterized class looks different from a C++ template:
   #     o class C #(int size = 1); ...            // base class
   #     o class C #(type T = bit); ...            // base class
   #     o class D1 #(type P = real) extends C;            // T is bit (the default)
   #     o class D2 #(type P = real) extends C #(integer);          // T is integer
   #     o class D3 #(type P = real) extends C #(P);                // T is P
   #    becomes:
   #     o template <int size = 1> class C { ... // base class
   #     o template <class T = bit> class C  {  ... }                  // base class
   #     o template <class P = real> class D1  : public C {            // T is bit (the default)
   #     o template <class P = real> class D2  : public C <integer> {  // T is integer
   #     o template <class P = real> class D3  : public C <P>          // T is P
   # Current Strategy:
   #   - convert SV class to C++ Class
   #   - convert SV Parameterized class to C++ template class
   #
   if (/\bclass(\s+)(\w+)/) {
      $class_start = 1;
      $classname = $2;
      # C++ does not declare abstract classes (C++ abstract class just has pure methods declared)
      if (/\bvirtual\b/) {
         s/virtual\s+class/class/;
      }
      # forward reference
      # in SV a forward reference looks like: typedef class myclass;
      # in C++ it looks like: class myclass;
      if (/typedef/) {
         s/typedef\s+class(.*;)/class $1/;
         $class_start = 0;
      }
   }
   if ($class_start) {
      s/\btype REQ=int,RSP=int/typename REQ=int, typename RSP=int/; # HACK: support for OVM weirdness
      s/\btype /typename /g;
      if (s/;/ { public: /) { # SV defaults to public; C++ defaults to private
         $class = 1; # we're in a class body
         $class_start = 0;
         $access_specifier = "public";
      }
      if (/\#\(/) {
         $template_class = 1;
         s/class(\s+)(\w+)/template /;
      }
      elsif ($infile[$infile_line] =~ /^(\s*?)\#\(/) {
         $template_class = 1;
         s/class(\s+)(\w+)/template /;
      }

      if (/\bextends\b/) {
         $derived_class = 1;
         if ($template_class) {
            s/\bextends\b/class $classname extends/;
         }
      }
      if ($template_class == 1 && $derived_class == 0) {
         s/ { public: / $classname { public: /;
      }
   }

   if (/\bendclass\b/) {
      $class_start = 0;
      $derived_class = 0;
      $template_class = 0;
      $class = 0; # we're not in a class body
   }

   # Parameterized Class Usage
   #
   # Current Strategy:
   #   - keep track of opening and closing #( )
   #   - convert to C++ template instances < >
   while (s/\#\(/</g) {
      $template++;
      #print STDERR "Template Count = $template at line $infile_line\n";
   }
   if ($template) {
      while (s/\)/>/g) {
         if ($template == 0) {
            next; #break
         }
         $template--;
      }
   }

   # Class Access Specifier
   #   In C++ the access specifier defaults to private
   #   In SV the access specifier defaults to public
   #   In C++ the access specifier is sticky
   #   In SV the access specifier is per member
   # Looking for:
   #   local protected public
   # Current Strategy:
   #   - if we're in a class body restick the public marker after SV changes to local or protected
   #   - to keep the line number references correct we need to put the public on the same line
   #   - if we're not in the body of a method then we can mark public
   if ($class == 1 && $function_start == 0) {
      if (/\blocal\s+\b/) {
         s/\blocal\b//;
         if ($access_specifier ne "private") {
            print "private: ";
            $access_specifier = "private";
         }
      }
      elsif (/\bprotected\s+\b/) {
         s/\bprotected\b//;
         if ($access_specifier ne "protected") {
            print "protected: ";
            $access_specifier = "protected";
         }
      }
      elsif (/\bpublic\s+\b/) {
         s/\bpublic\b//;
         if ($access_specifier ne "public") {
            print "public: ";
            $access_specifier = "public";
         }
      }
      elsif ($function == 0) {
         if ($access_specifier ne "public") {
            print "public: ";
            $access_specifier = "public";
         }
      }
   }

   #-----------------------------------------------------------------------------
   #
   # Change Begin / End markers to { / } braces
   #  NOTE: we don't do this earlier b/c the SV begin / end markers are much
   #        easier to parse (search for) than trying to keep track of nested
   #        braces.
   #
   #-----------------------------------------------------------------------------

   # Tasks and Functions
   #   SV Tasks and Functions declaration opens with ;
   #   C++ functions open with { (unless functions are extern or pure)
   #   SV Methods do not have to have parens function foo; is same as function foo();
   # Looking for:
   # ... function or task
   # Current Strategy:
   #   - if extern do nothing
   #   - if pure virtual remove pure keyword and change semicolon to '= 0;'
   #   - change semicolon to open curly
   if ($class && (/pure\s+virtual/)) {
      s/pure\s+//;
      $ispure = 1;
   }
   elsif ($class && (/\bextern\b/)) {
      s/extern\s+//;
      $isextern = 1;
   }

   if (/\b(task|function)\b/) {
      $function_start = 1;
      $function = 0;
   }

   if ($function_start == 1) {
      # put in the parens if they're missing
      if (!/\)\s*;/) {
         s/;/();/
      }
      if ($ispure) {
         if(s/;\s*$/ = 0;\n/) {
            $ispure = 0;
            $function_start = 0;
         }
      }
      elsif ($isextern) {
         if (/;\s*$/) {
            $isextern = 0;
            $function_start = 0;
         }
      }
      elsif (s/;/ {/) {
         $function = 1; # in a method body
         $function_start = 0;
      }
   }
   if (/end(task|function)/) {
      $function = 0;
   }

   # Named Begin Block
   # Looking for:
   # ... begin : name ...
   # Current Strategy:
   #   - change begin to open curly and remove the name
   s/\bbegin\s*:\s*\S+/{/;

   # UnNamed Begin Block
   # Looking for:
   # ... begin ...
   # Current Strategy:
   #   - change begin to open curly
   s/\bbegin\b/{/;

   # Named End Blocks
   # Looking for:
   # ... end* : name ...
   # Current Strategy:
   #   - change end to close curly and remove the name
   s/\bendclass\s*:\s*\S+/};/;
   s/\bendprogram\s*:\s*\S+/}/;
   s/\bendmodule\s*:\s*\S+/}/;
   s/\bendinterface\s*:\s*\S+/}/;
   s/\bendcase\s*:\s*\S+/}/;
   s/\bendfunction\s*:\s*\S+/}/;
   s/\bendtask\s*:\s*\S+/}/;
   s/\bendclocking\s*:\s*\S+/}/;
   s/\bendgroup\s*:\s*\S+/}/;
   s/\bend\s*:\s*\S+/}/;

   # UnNamed End Blocks
   # Looking for:
   # ... end* ...
   # Current Strategy:
   #   - change end to close curly
   s/\bendclass\b/};/;
   s/\bendprogram\b/}/;
   s/\bendmodule\b/}/;
   s/\bendinterface\b/}/;
   s/\bendcase\b/}/;
   s/\bendfunction\b/}/;
   s/\bendtask\b/}/;
   s/\bendclocking\b/}/;
   s/\bendgroup\b/}/;
   s/\bend\b/}/;

   # Function
   # C++ function looks exactly like SV function except C++ doesn't have the word "function"
   # Looking for:
   #   - function functionscope::functionname ( ...
   # Current Strategy:
   #   - remove word function from the line
   s/\bfunction\b//;

   # Task
   # C++ function looks exactly like SV task except C++ doesn't have the word "task"
   # AND an SV task doesn't have a return type
   # Looking for:
   #   - task taskscope::taskname ( ...
   # Current Strategy:
   #   - remove word task from the line
   #   - add return type of void
   s/\btask\b/void/;

   # Derived Class (and the access specifier)
   # SV Derived Class inherits base class members without affecting the access permissions
   # to a user of the class
   #   SV: class myderivedclass extends mybaseclass; ...
   #  C++: class myderivedclass : public mybaseclass { ...
   # Current Strategy:
   #   - change extends keyword to public access specifier
   s/\bextends\b/: public/;

   # Return the Inline Comment to the End of the Line
   if ($inline_comment ne "") {
      s/$/ $inline_comment/;
      $inline_comment = "";
   }
   print;
}

