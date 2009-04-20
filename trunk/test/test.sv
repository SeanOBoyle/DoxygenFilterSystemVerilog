// $Id_deleteme$
//----------------------------------------------------------------------------
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//----------------------------------------------------------------------------
// NOTE: 'deleteme' comments added to prevent SVN from changing text (where the sv and golden would result in a mismatch)
/**
 * Test.
 * This file is a test of the doxygen filter script.<br>
 * This contains a semi-complete set of the SystemVerilog constructs
 * that the filter script can handle<br>
 * <br>
 * <br>
 * @par Download the most recent version here:
 * http://intelligentdv.com/downloads/
 * <br>
 * @par File Bugs Here:
 * http://bugs.intelligentdv.com/ <br>
 * Project:  DoxygenFilter
 *
 * @file test.sv
 * @author Sean O'Boyle
 * @par Contact:
 * http://intelligentdv.com/contact/
 * @par Company:
 * <a href="http://intelligentdv.com">Intelligent Design Verification</a>
 *
 * @version
 * $LastChangedRevision_deleteme$
 * @par Last Change Date:
 * $LastChangedDate_deleteme$
 * @par Last Change By:
 * $LastChangedBy_deleteme$
 *
 */

`ifndef TEST__SV
`define TEST__SV

timeunit 1 ns;
timeprecision 1 ps;


`define PUTINQUOTES(x) `"x`"

`include "myfile.sv"
`define MYOTHERFILE myotherfile.sv
`include `PUTINQUOTES(`MYOTHERFILE)


// DPI Import
import "DPI-C" function int dpi_method1(input string str1, input string regex);
import "DPI-C" function string dpi_method2();
import "DPI-C" function string dpi_method3();
import "DPI-C" function string dpi_method4(int n);
import "DPI-C" function void myInit();
// from standard math library
import "DPI-C" pure function real sin(real);
// from standard C library: memory management
import "DPI-C" function chandle malloc(int size); // standard C function
import "DPI-C" function void free(chandle ptr); // standard C function
// abstract data structure: queue
import "DPI-C" function chandle newQueue(input string name_of_queue);
// Note the following import uses the same foreign function for
// implementation as the prior import, but has different SystemVerilog name
// and provides a default value for the argument.
import "DPI-C" newQueue=function chandle newAnonQueue(input string s=null);
import "DPI-C" function chandle newElem(bit [15:0]);
import "DPI-C" function void enqueue(chandle queue, chandle elem);
import "DPI-C" function chandle dequeue(chandle queue);
// miscellanea
import "DPI-C" function bit [15:0] getStimulus();
import "DPI-C" context function void processTransaction(chandle elem,
                                       output logic [64:1] arr [0:63]);
import "DPI-C" task checkResults(input string s, bit [511:0] packet);


// DPI Export
export "DPI-C" function int dpi_export_method();

// Macros
`define MYDEFINE mydefine
`ifdef MYDEFINE
`define MYDEFINE2 mydefine2
`else
`undef MYDEFINE2
`endif

// More Macros
`define foo(f) f``_suffix
`define msg(x,y) `"x: `\`"y`\`"`"

// Multiline Macros (from VMM)
`ifndef __FILE__
`define __FILE__ `"`"
`endif
`ifndef __LINE__
`define __LINE__ -1
`endif

`define vmm_warning(log, msg)  \
do \
   /* synopsys translate_off */ \
   if (log.start_msg(vmm_log::FAILURE_TYP, vmm_log::WARNING_SEV, `__FILE__, `__LINE__)) begin \
      void'(log.text(msg)); \
      log.end_msg(); // a comment in a macro \
      something("with some quotes and a keyword end") \
   end \
   /* synopsys translate_on */ \
while(0)

`define vmm_error(log, msg)  \
do \
   /* synopsys translate_off */ \
   if (log.start_msg(vmm_log::FAILURE_TYP, vmm_log::ERROR_SEV, `__FILE__, `__LINE__)) begin \
      void'(log.text(msg)); \
      log.end_msg(); \
   end \
   /* synopsys translate_on */ \
while (0)

`define vmm_fatal(log, msg)  \
do \
   /* synopsys translate_off */ \
   if (log.start_msg(vmm_log::FAILURE_TYP, vmm_log::FATAL_SEV, `__FILE__, `__LINE__)) begin \
      void'(log.text(msg)); \
      log.end_msg(); \
   end \
   /* synopsys translate_on */ \
while (0)

// Another Mulitline Macro (from VMM)
`define vmm_channel(T) \
class `vmm_channel_(T) extends vmm_channel; \
 \
   function new(string name, \
                string inst, \
                int    full = 1, \
                int    empty = 0, \
                bit    fill_as_bytes = 0); \
      super.new(name, inst, full, empty, fill_as_bytes); \
   endfunction: new \
 \
   function T unput(int offset = -1); \
      $cast(unput, super.unput(offset)); \
   endfunction: unput \
 \
   constraint myconstraint { \
      depth == 3; \
      foo == 5; \
   } \
   \
   task get(output T obj, input int offset = 0); \
      vmm_data o; \
      super.get(o, offset); \
      $cast(obj, o); \
   endtask: get \
   \
   covergroup mycov; \
      coverpoint m_depth; \
      coverpoint m_full; \
   endgroup: cov2 \
 \
   task peek(output T obj, input int offset = 0); \
      vmm_data o; \
      super.peek(o, offset); \
      $cast(obj, o); \
   endtask: peek \
 \
   task activate(output T obj, input int offset = 0); \
      vmm_data o; \
      super.activate(o, offset); \
      $cast(obj, o); \
   endtask: activate \
 \
   function T active_slot(); \
      $cast(active_slot, super.active_slot()); \
   endfunction: active_slot \
 \
   function T start(); \
      $cast(start, super.start()); \
   endfunction: start \
 \
   function T complete(vmm_data status = null); \
      $cast(complete, super.complete(status)); \
   endfunction: complete \
 \
   function T remove(); \
      $cast(remove, super.remove()); \
   endfunction: remove \
 \
   task tee(output T obj); \
      vmm_data o; \
      super.tee(o); \
      $cast(obj, o); \
   endtask: tee \
 \
   function T for_each(bit reset = 0); \
      $cast(for_each, super.for_each(reset)); \
   endfunction: for_each \
 \
endclass

`define TLM_FIFO_TASK_ERROR "fifo channel task not implemented"
`define TLM_FIFO_FUNCTION_ERROR "fifo channel function not implemented"
`define TLM_FIFO_FUNCTION_ERROR2 "fifo channel \
                             function not implemented \
                             yes we have no bananas \
                             today function" things

`define TLM_FIFO_FUNCTION_ERROR3 "fifo channel \
\
                             function not implemented \
                             yes we have no bananas \
                             today function" things



/**
 *  Test Class - Basic.
 *  Just a basic class declaration.<br>
 *  "String in Quotes in a comment"
 *
 *  @class test_class_basic
 *
 */
class test_class_basic;

   // Test Member Access Specifiers
   local rand int     m_local_int;      ///< Private Int
   protected rand int m_protected_int;  ///< Protected Int
   protected rand bit m_protected_bit;  ///< Protected Bit
         event   m_public_event;   ///< Public Event
   local event   m_local_event;    ///< Private Event
         int     m_int_array [1:32];
   // Test bitvector brace conversion
         rand bit [31:0] m_public_bitvector; ///< Public Bit Vector
   // Test enum typedef
   typedef enum  {A, ///< A State
                  B, ///< B State
                  C, ///< C State
                  D  ///< D State
                 } alpha_enum_t;  ///< Alpha State Enum Type

   typedef enum bit [7:0] { M, ///< M State
                            N  ///< N State
                            } mn_enum_t; ///< Bit State Enum Type

   alpha_enum_t m_alpha; ///< Alpha State
	`ifdef FOO
   local mn_enum_t    m_mn;    ///< MN State
	`endif
	bit    m_public_var; ///< A public variable

   /**
    * Small Int Constraint.
    * Constrain m_local_int to a small value.
    *
    */
   constraint small_int {m_local_int <= 'd6;}

   /**
    * Word Align Constraint.
    * Constrain m_public_bitvector to word align
    *
    */
   constraint word_align {
      // This is a comment
      m_public_bitvector[1:0] == 2'd0;
   }

   /**
    * Extern Constraint.
    * Constraint body defined extern.
    *
    */
   constraint extern_constraint;

   /**
    * Cov1 Coverage Group.
    * Covers m_alpha and m_mn
    *
    */
   covergroup cov1;
      coverpoint m_alpha;
      coverpoint m_mn;
   endgroup: cov1

   /**
    * Cov2 Coverage Group.
    * Covers m_protected_bit and m_protected_int on m_protected_bit event.
    *
    */
   covergroup cov2 @ m_protected_bit;
      coverpoint m_protected_bit;
      coverpoint m_protected_int;
   endgroup: cov2

   /**
    * Cov3 Coverage Group with args.
    * Covers m_protected_bit and m_protected_int on m_protected_bit event.
    *
    */
   covergroup cov3 (int arg1, int arg2);
      coverpoint m_protected_bit;
      coverpoint m_protected_int;
   endgroup: cov3

   /**
    * Cov4 Coverage Group with args on 2 lines.
    * Covers m_protected_bit and m_protected_int on m_protected_bit event.
    *
    */
   covergroup cov4 (int arg1,
                    int arg2);
      coverpoint m_protected_bit;
      coverpoint m_protected_int;
   endgroup: cov4

   /**
    * Cov5 Coverage Group with args on with sampling.
    * Covers m_protected_bit and m_protected_int on m_protected_bit event.
    *
    */
   covergroup cov5 (int arg1,
                    int arg2) @ m_protected_bit;
      coverpoint m_protected_bit;
      coverpoint m_protected_int;
   endgroup: cov5

   /**
    *  Constructor.
    *  Class Constructor<br>
    *
    *  @param myint int - My Integer Parameter
    *  @param mybit bit - My Bit Parameter (defaults to 0)
    */
   function new(time myint, bit mybit = 0);
      m_local_int = myint;
      m_protected_bit = mybit;
      cov1 = new;
      cov2 = new;
   endfunction: new

   /**
    *  Protected Extern Function.
    *  Test extern function<br>
    *  Test method access specifier
    *
    *  @return void
    *
    */
   protected extern function void myprotectedexternfunction();

   /**
    *  Extern Function.
    *  Test extern function<br>
    *  Test method access specifier
    *
    *  @return void
    *
    */
   local extern function void myexternfunction();

   /**
    *  Public Task.
    *  Test method access specifier.<br>
    *  Test virtual method specifier.
    *
    *  @return void
    *
    */
   virtual task mypublicvirtualfunction();
      $display("This is public");
   endtask

   /**
    *  Pure Virtual Task.
    *  Test pure virtual specifier
    *
    *  @return void
    *
    */
   pure virtual task mypurevirtualtask();

   /**
    *  Protected Task.
    *  Test method access specifier
    *
    *  @return void
    *
    */
   protected task myprotectedfunction();
      $display("This is protected");
   endtask

   /**
    *  Protected Task.
    *  Test method access specifier
    *
    *  @return void
    *
    */
   protected task myprotectedfunction();
      $display("This is protected");
   endtask

   /**
    *  Pure Virtual Function.
    *  Test pure virtual specifier
    *
    *  @return void
    *
    */
   pure virtual function int mypurevirtualfunction(int A,
                                                   int B);


   /**
    *  local function.
    *  Test method access specifier
    *
    *  @return void
    *
    */
   local function void myprivatefunction();
      $display("This is private");
   endtask

   /**
    *  Virtual Function.
    *  Test Virtual Function<br>
    *  Test bit vector braces<br>
    *  Test literals with tickmark (')<br>
    */
    virtual function void myvirtualfunction;
       int myint = 5'd3;
       bit [7:0]  mybitvector = 8'hX;
       bit [15:0] mybitvector2 = 'hBEEF;
       bit [31:0] mybitvector3 = 32'o3355;
       begin: mybeginblock
          bit [1:0]  mybitvector4 = 'b01;
          bit [1:0]  mybitvecotr5 = 2'b10;
       end: mybeginblock
    endfunction: myvirtualfunction

endclass:test_class_basic

constraint test_class_basic::extern_constraint {
   m_local_int == m_protected_int;
}

// Extern Function show()
// Test string in quotes
function void test_class_basic::myexternfunction();
   $display("test::show()");
   $display("m_local_int %0d", m_local_int);
   begin
      $display("m_protected_int %0d", m_protected_int);
      $display("m_protected_bit %0b", m_protected_bit);
   end
   $display("");
endfunction: myexternfunction

function void test_class_basic::myprotectedexternfunction();
   // Cast from bit to int
   int myint;
   bit [7:0] mybitvector;

   myint = int'(m_mn);
   mybitvector = bit[7:0]'(m_alpha);

endfunction: myprotectedexternfunction

/**
 * MyProgram1 Program Block.
 * Just a program block with no inputs/outputs
 */
program myprogram1;
  initial begin
     int myint = 5;
     int myint2 = 6;
     $display("Hello World");
     case (myint)
        0: myint2 = 1;
        1: myint2 = 0;
        default: myint2 = 2;
     endcase
  end
endprogram: myprogram1

/**
 * MyProgram2 Program Block.
 * A program block with inputs/outputs declared over multiple lines
 */
program myprogram2(int myint,
                   bit mybit);
  initial begin
     $display("Hello World");
  end
  final begin
     $display("Goodbye World");
  end
endprogram: myprogram2

/**
 * MyModule1 Module Block.
 * Just a module block with no inputs/outputs
 */
module mymodule1;
   initial begin
      $display("Hello World");
   end
endmodule: mymodule1

/**
 * MyModule2 Module Block.
 * A module block with inputs/outputs declared over multiple lines
 */
module mymodule2(int myint,
                bit mybit);
   virtual interface bus_A mybus;
   initial begin
      $display("Hello World");
   end
endmodule: mymodule2

/**
 * MyModule3 Module Block.
 * A module block with inputs/outputs declared over multiple lines - starting on the next line
 */
module mymodule3
(
int myint,
bit mybit
);
   initial begin
      $display("Hello World");
   end
endmodule

/**
 * Bus interface Block.
 * An interface with no ports.
 */
interface bus;
      logic [15:0] data;
      logic write;
      modport test (input data, output write);
      modport dut (output data, input write);
endinterface

/**
 * BusA interface Block.
 * An interface with single clock input.
 */
interface bus_A (input clk);
      logic [15:0] data;
      logic write;
      modport test (input data, output write);
      modport dut (output data, input write);
endinterface

/**
 * BusB interface Block.
 * An interface with two lines of I/O
 */
interface bus_B (input clk,
                 output foo);
      logic [8:1] cmd;
      logic enable;
      logic foo;
      modport test (input enable);
      modport dut (output enable);
endinterface

/**
 * BusC interface Block.
 * A parameterized interface in one line
 */
interface bus_C #(WIDTH=8) (input clk, output foo);
      logic [WDTH-1:0] cmd;
      logic enable;
      modport test (input enable);
      modport dut (output enable);
endinterface

/**
 * BusD interface Block.
 * A parameterized interface with two lines of IO
 */
interface bus_D #(WIDTH=8) (input clk,
                            output foo);
      logic [WDTH-1:0] cmd;
      logic enable;
      modport test (input enable);
      modport dut (output enable);
endinterface

/**
 * BusE interface Block.
 * A parameterized interface with two lines of parameters and one lines of IO
 */
interface bus_E #(WIDTH=8,
                  DEPTH=20) (input clk, output foo);
      logic [WDTH-1:0] cmd;
      logic enable;
      logic arr [DEPTH];
      modport test (input enable);
      modport dut (output enable);
endinterface

/**
 * BusF interface Block.
 * A parameterized interface with two lines of parameters and two lines of IO
 */
interface bus_F #(WIDTH=8,
                  DEPTH=20) (input clk,
                             output foo);
      logic [WDTH-1:0] cmd;
      logic enable;
      logic arr [DEPTH];
      modport test (input enable);
      modport dut (output enable);
endinterface

/**
 * My Derived Class.
 * Extends test_class_basic
 */
class myderivedclass extends test_class_basic;
   int m_myint;
   bit m_mybit;
endclass

/**
 * My Derived Class Package.
 * Extends foo::test_class_basic -- foo:: will be removed
 */
class myderivedclass_package extends foo::test_class_basic;
   int m_myint;
   bit m_mybit;
endclass

/**
 * My Template Class.
 * type T=int
 * extends test_class_basic
 */
class mytemplateclass #(type T=int) extends test_class_basic;
   int m_myint;
   bit m_mybit;
endclass

/**
 * My Template Class2.
 * type T=custom
 * extends mytemplateclass#(bit)
 */
class mytemplateclass2 #(type T=custom) extends mytemplateclass#(bit);
   int m_myint;
   bit m_mybit;
endclass

/**
 * My Template Class3.
 * type T=int, type B=bit
 * extends mytemplateclass#(bit)
 */
class mytemplateclass3 #(type T=int, type B=bit) extends mytemplateclass#(bit);
   int m_myint;
   bit m_mybit;
endclass

/**
 * My Template Class4.
 * type T=int
 * extends nothing...
 */
class mytemplateclass4 #(type T=int);
   int m_myint;
   bit m_mybit;
endclass

/**
 * My Template Class5.
 * int B=3
 * extends nothing...
 */
class mytemplateclass5 #(int B=3);
   int m_myint;
   bit m_mybit;
endclass

/**
 * My Template Class6.
 * type T=int, int B=3
 * extends nothing...
 */
class mytemplateclass6 #(type T=int, int B=3);
   int m_myint;
   bit m_mybit;
endclass

/**
 * My Template Class7.
 * type T=int, int B=3
 * extends mytemplateclass#(bit)
 */
class mytemplateclass7 #(type T=int, int B=3) extends mytemplateclass #(bit);
   int m_myint;
   bit m_mybit;
endclass

/**
 * My Template Class8.
 * type T=int, int B=3, type C=mine
 * extends mytemplateclass6#(bit, 5)
 */
class mytemplateclass8#(type T=int,
                        int B=3,
                        type C=mine)
                       extends mytemplateclass6#(bit,
                                                   5);
   int m_myint;
   bit m_mybit;
endclass

/**
 * My Template Class9.
 * type T=int, int B=3, type C=mine
 * extends mytemplateclass4#(bit, 5)
 */
class mytemplateclass9 #(type T=int,
                         int B=3,
                         type C=mine)
                         extends mytemplateclass6#(bit,5);
   int m_myint;
   bit m_mybit;
endclass

/**
 * My Template Class10.
 * type T=int, int B=3, type C=mine
 * extends nothing...
 */
class mytemplateclass10 #(type T=int,
                         int B=3,
                         type C=mine);
   int m_myint;
   bit m_mybit;
endclass

/**
 * My Class11.
 * extends template class...
 */
class myclass11 extends mytemplateclass10 #(foo, 5, boo);
   int m_myint;
endclass

/**
 * My Template Class12.
 * type T=int, int B=3, type C=mine
 * extends mytemplateclass6#(bit, 5)
 */
class mytemplateclass12
   #(type T=int,
     int B=3,
     type C=mine)
   extends mytemplateclass6#(bit,
                             5);
   int m_myint;
   bit m_mybit;
endclass

class mytemplateselectclass #(type ABC=data, type DEF=data2)
`ifdef DEFBASE
  extends `DEFBASE
`endif
;
   int m_myint;
endclass

class myselectclass
`ifdef DEFBASE
  extends `DEFBASE
`endif
;
   int m_myint;
endclass

class abc #(type f = null, type g = z, type h = x) extends def #(f);
   int m_myint;
endclass

`endif


