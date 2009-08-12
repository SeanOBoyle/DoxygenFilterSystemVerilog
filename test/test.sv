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
 * Test - brief comment.
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
 * @author Author O'Author
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

/**
 * Put in Quotes Macro.
 * A paremeterized macro that puts X in quotes
 */
`define PUTINQUOTES(x) `"x`"

`include "myfile.sv"
/**
 * My Other File Define.
 * My other file is C++!
 */
`define MYOTHERFILE myotherfile.sv
`include `PUTINQUOTES(`MYOTHERFILE)


// DPI Import
/**
 *  DPI Method1.
 *  A DPI-C import of method dpi_method1<br>
 *
 *  @param str1 string - description of parameter str1
 *  @param regex string - description of parameter regex
 *  @return int
 */
import "DPI-C" function int dpi_method1(input string str1, input string regex);
/**
 *  DPI Method2.
 *  A DPI-C import of method dpi_method2<br>
 *
 *  @return string
 */
import "DPI-C" function string dpi_method2();
/**
 *  DPI Method3.
 *  A DPI-C import of method dpi_method3<br>
 *
 *  @return string
 */
import "DPI-C" function string dpi_method3();
/**
 *  DPI Method4.
 *  A DPI-C import of method dpi_method4<br>
 *
 *  @param n int - description of parameter n
 *  @return string
 */
import "DPI-C" function string dpi_method4(int n);
/**
 *  DPI My Init.
 *  A DPI-C import of method myInit<br>
 *
 *  @return void
 */
import "DPI-C" function void myInit();
/**
 *  DPI Sin.
 *  A DPI-C import of method sin<br>
 *  From standard math library
 *
 *  @param n real - description of parameter n
 *  @return real
 */
import "DPI-C" pure function real sin(real n);
/**
 *  DPI malloc.
 *  A DPI-C import of method malloc<br>
 *  From standard C library: memory management
 *
 *  @param size chandle - description of parameter size
 *  @return chandle
 */
import "DPI-C" function chandle malloc(int size); // standard C function
/**
 *  DPI free.
 *  A DPI-C import of method free<br>
 *  From standard C library: memory management
 *
 *  @param ptr chandle - description of parameter ptr
 *  @return void
 */
import "DPI-C" function void free(chandle ptr); // standard C function
/**
 *  DPI New Queue.
 *  A DPI-C import of method newQueue<br>
 *  abstract data structure: queue
 *
 *  @param name_of_queue chandle - description of parameter name_of_queue
 *  @return chandle
 */
import "DPI-C" function chandle newQueue(input string name_of_queue);
/**
 *  DPI New (Anon) Queue.
 *  A DPI-C import of method newAnonQueue - renamed to newQueue2<br>
 *  abstract data structure: queue
 *
 *  @note Note the following import uses the same foreign function for
 *        implementation as the prior import, but has different SystemVerilog name
 *        and provides a default value for the argument.
 *
 *  @param s string - description of parameter s (defaults to null)
 *  @return chandle
 */
import "DPI-C" newQueue2=function chandle newAnonQueue(input string s=null);
/**
 *  DPI New Element.
 *  A DPI-C import of method newElem<br>
 *
 *  @param mybitvector bit[15:0] - description of parameter s (defaults to null)
 *  @return chandle
 */
import "DPI-C" function chandle newElem(bit [15:0] mybitvector);
/**
 *  DPI Enqueue.
 *  A DPI-C import of method enqueue<br>
 *
 *  @param queue chandle - description of parameter queue
 *  @param elem chandle - description of parameter elem
 *  @return void
 */
import "DPI-C" function void enqueue(chandle queue, chandle elem);
/**
 *  DPI Dequeue.
 *  A DPI-C import of method dequeue<br>
 *
 *  @param queue chandle - description of parameter queue
 *  @return chandle
 */
import "DPI-C" function chandle dequeue(chandle queue);
/**
 *  DPI Get Stimulus.
 *  A DPI-C import of method getStimulus<br>
 *
 *  @return bit [15:0]
 */
import "DPI-C" function bit [15:0] getStimulus();
/**
 *  DPI Process Transaction.
 *  A DPI-C import of method processTransaction<br>
 *
 *  @param elem chandle - description of parameter elem
 *  @param arr [64:1] logic [0:63] - description of parameter arr
 *  @return void
 */
import "DPI-C" context function void processTransaction(chandle elem,
                                                        output logic [64:1] arr [0:63]);
/**
 *  DPI Check Results.
 *  A DPI-C import of method checkResults<br>
 *
 *  @param s string - description of parameter s
 *  @param packet bit [511:0] - description of parameter packet
 */
import "DPI-C" task checkResults(input string s, bit [511:0] packet);

// DPI Export -- exported methods are not documented; since they are replicated
export "DPI-C" function int dpi_export_method();

// Macros
/**
 *  My Define.
 *  A define for fun<br>
 */
`define MYDEFINE mydefine
`ifdef MYDEFINE
/**
 *  My Define2.
 *  Another define and also fun<br>
 */
`define MYDEFINE2 mydefine2
`else
`undef MYDEFINE2
`endif

// More Macros
/**
 *  foo define.
 *  define with concatenation<br>
 */
`define foo(f) f``_suffix
/**
 *  msg define.
 *  define with concatenation<br>
 */
`define msg(x,y) `"x: `\`"y`\`"`"

// Multiline Macros (from VMM)
`ifndef __FILE__
/**
 *  FILE define.
 *  define with doublequotes<br>
 */
`define __FILE__ `"`"
`endif
`ifndef __LINE__
/**
 *  Line define.
 *  incase __LINE__ isn't defined<br>
 */
`define __LINE__ -1
`endif

/**
 *  Test of Stringizer # in macro.
 *
 */
`define testofquotes(passedstring) \
  string astring = `"passedstring`";

/**
 *  A better Test of Stringizer # in macro.
 *  Uses an ovm macro.
 */
`define ovm_get_type_name_func(T) \
   const static string type_name = `"T`"; \
   virtual function string get_type_name (); \
     return type_name; \
   endfunction

ovm_get_type_name_func(foo);


/**
 *  Parameterized Macro VMM Warning.
 *  A parameterized macro - taken from VMM<br>
 */
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

/**
 *  Parameterized Macro VMM Error.
 *  A parameterized macro - taken from VMM<br>
 */
`define vmm_error(log, msg)  \
do \
   /* synopsys translate_off */ \
   if (log.start_msg(vmm_log::FAILURE_TYP, vmm_log::ERROR_SEV, `__FILE__, `__LINE__)) begin \
      void'(log.text(msg)); \
      log.end_msg(); \
   end \
   /* synopsys translate_on */ \
while (0)

/**
 *  Parameterized Macro VMM Fatal.
 *  A parameterized macro - taken from VMM<br>
 */
`define vmm_fatal(log, msg)  \
do \
   /* synopsys translate_off */ \
   if (log.start_msg(vmm_log::FAILURE_TYP, vmm_log::FATAL_SEV, `__FILE__, `__LINE__)) begin \
      void'(log.text(msg)); \
      log.end_msg(); \
   end \
   /* synopsys translate_on */ \
while (0)

/**
 *  Parameterized Macro VMM Channel.
 *  A parameterized macro - taken from VMM<br>
 *  @note there's an inline comment in this one
 */
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

/**
 *  Define TLM FIFO Task Error Message.
 *  A macro - with a SV keyword embedded<br>
 */
`define TLM_FIFO_TASK_ERROR "fifo channel task not implemented"
/**
 *  Define TLM FIFO Function Error Message.
 *  A macro - with a SV keyword embedded<br>
 */
`define TLM_FIFO_FUNCTION_ERROR "fifo channel function not implemented"
/**
 *  Define TLM FIFO Function Error2 Message.
 *  A multiline macro - with a SV keyword embedded<br>
 */
`define TLM_FIFO_FUNCTION_ERROR2 "fifo channel \
                             function not implemented \
                             yes we have no bananas \
                             today function" things

/**
 *  Define TLM FIFO Function Error3 Message.
 *  A multiline macro - with a SV keyword embedded and an empty line with a trailing word<br>
 */
`define TLM_FIFO_FUNCTION_ERROR3 "fifo channel \
\
                             function not implemented \
                             yes we have no bananas \
                             today function" things


/**
 * Include Package - collection of classes.
 * This is my package - it has a collection of classes that are included with file inclusion
 *
 */
package inclpack;

   `include "test_incl.sv"

endpackage: inclpack


/**
 * Foo Package - collection of classes.
 * This is my package - it has a collection of classes
 *
 */
package foopack;
   /**
    *  Test Class in foo package.
    *  Just a basic class declaration in a class.<br>
    *
    *  @class foo_test_class
    *
    */
   class foo_test_class;
      int m_anint; ///< An Int
   endclass: foo_test_class
   /**
    *  Test Class2 in foo package.
    *  Just a basic class declaration in a class.<br>
    *
    *  @class foo_test_class2
    *
    */
   class foo_test_class2;
      int m_anint; ///< An Int
   endclass: foo_test_class2

endpackage: foopack

/**
 * Goo Package - collection of classes.
 * This is my goo package - it has a collection of classes
 * and it uses another package - foopack::*
 *
 */
package goopack;
   import foopack::*;
   /**
    *  Test Class in a Package.
    *  Just a basic class declaration in a class.<br>
    *
    *  @class goo_test_class
    *
    */
   class goo_test_class extends foo_test_class;
      int m_anint;  ///< An Int
      foo_test_class2 m_ftc;  ///< Foo Test Class
   endclass: goo_test_class

endpackage: goopack

/**
 * Moo Package - collection of classes.
 * This is my moo package - it has a collection of classes
 * and it uses another package's class directly: goopack::goo_test_class
 *
 */
package moopack;
   import goopack::goo_test_class;
   /**
    *  Test Class in a Package.
    *  Just a basic class declaration in a class.<br>
    *
    *  @class moo_test_class
    *
    */
   class moo_test_class extends goo_test_class;
      int m_anint; ///< An Int
   endclass: moo_test_class

endpackage: moopack

/**
 * Doo Package - collection of classes.
 * This is my doo package - it has a collection of classes
 * and it uses another package: moopack
 *
 */
package doopack;
   import moopack;
   /**
    *  Test Class in a Package.
    *  Just a basic class declaration in a class.<br>
    *
    *  @class doo_test_class
    *
    */
   class doo_test_class extends moo_test_class;
      int m_anint; ///< An Int
   endclass: doo_test_class

endpackage: doopack

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
         int     m_int_array [1:32];  ///< Fixed Size Array of Int
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

   protected enum bit {Z,Y} m_zy; ///< ZY Enumeration

   int m_another_int; ///< Another Public Int

   protected enum int {THIS,
                       IS,
                       THE,
                       ONE
                      } m_theone; ///< Tough one

   int m_yetanotherint; ///< Yet Another Public Int

   protected typedef enum {RTL_REG_ENABLE    = 32'h0002, ///< Register Enable
                           RTL_REG_INTERRUPT = 32'h0014  ///< Register Interrupt
                           } rtl_reg_enum_t; ///< Protected Enum Type Register
   typedef enum {RTL_FIELD_DATA,  ///< Field Data
                 RTL_FIELD_HOST   ///< Field Host
                 } rtl_field_enum_t; ///< Public Enum Type Field
   protected int unsigned m_field_map_lsb [rtl_field_enum_t]
       =  '{RTL_FIELD_DATA :  0,
            RTL_FIELD_HOST :  1
           }; ///< Protected Array with Initialization

   int m_andyetanotherint; ///< Yet Another Public Int

   local int unsigned m_field_map_lsb_b [rtl_field_enum_t]  =  '{RTL_FIELD_DATA  :  0,
                                                                 RTL_FIELD_HOST  :  1
                                                                }; ///< Local Array with Initialization

   int m_andandyetanotherint; ///< Yet Another Public Int

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
    *  @param myint int - description of parameter myint
    *  @param mybit bit - description of parameter mybit (defaults to 0)
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
    */
   virtual task mypublicvirtualfunction();
      $display("This is public");
   endtask

   /**
    *  Pure Virtual Task.
    *  Test pure virtual specifier
    *
    */
   pure virtual task mypurevirtualtask();

   /**
    *  Protected Task.
    *  Test method access specifier
    *
    */
   protected task myprotectedfunction();
      $display("This is protected");
   endtask

   /**
    *  Protected Task.
    *  Test method access specifier
    *
    */
   protected task myprotectedfunction();
      $display("This is protected");
   endtask

   /**
    *  Pure Virtual Function.
    *  Test pure virtual specifier
    *
    *  @param A int - description of parameter A
    *  @param B int - description of parameter B
    *  @return int
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
    *
    *  @return void
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

//----------------------------------------------------------------------------
// Extern Constraint
//----------------------------------------------------------------------------
constraint test_class_basic::extern_constraint {
   m_local_int == m_protected_int;
}

//----------------------------------------------------------------------------
// My Extern Function
//----------------------------------------------------------------------------
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


//----------------------------------------------------------------------------
// My Protected Extern Function
//----------------------------------------------------------------------------
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
 *
 *  @param myint int - description of parameter myint
 *  @param mybit int - description of parameter mybit
 *
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
 *
 *  @param myint int - description of parameter myint
 *  @param mybit int - description of parameter mybit
 *
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
 *
 *  @param myint int - description of parameter myint
 *  @param mybit int - description of parameter mybit
 *
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
 *
 *  @param clk bit - description of parameter clk
 *
 */
interface bus_A (input bit clk);
      logic [15:0] data;
      logic write;
      modport test (input data, output write);
      modport dut (output data, input write);
endinterface

/**
 * BusB interface Block.
 * An interface with two lines of I/O
 *
 *  @param clk bit - description of parameter clk
 *  @param foo logic - description of parameter foo
 *
 */
interface bus_B (input bit clk,
                 output logic foo);
      logic [8:1] cmd;
      logic enable;
      logic foo;
      modport test (input enable);
      modport dut (output enable);
endinterface

/**
 * BusC interface Block.
 * A parameterized interface in one line
 *
 *  @param clk bit - description of parameter clk
 *  @param foo logic - description of parameter foo
 *
 */
interface bus_C #(WIDTH=8) (input bit clk, output logic foo);
      logic [WDTH-1:0] cmd;
      logic enable;
      modport test (input enable);
      modport dut (output enable);
endinterface

/**
 * BusD interface Block.
 * A parameterized interface with two lines of IO
 *
 *  @param clk bit - description of parameter clk
 *  @param foo logic - description of parameter foo
 *
 */
interface bus_D #(WIDTH=8) (input bit clk,
                            output logic foo);
      logic [WDTH-1:0] cmd;
      logic enable;
      modport test (input enable);
      modport dut (output enable);
endinterface

/**
 * BusE interface Block.
 * A parameterized interface with two lines of parameters and one lines of IO
 *
 *  @param clk bit - description of parameter clk
 *  @param foo logic - description of parameter foo
 *
 */
interface bus_E #(WIDTH=8,
                  DEPTH=20) (input bit clk, output logic foo);
      logic [WDTH-1:0] cmd;
      logic enable;
      logic arr [DEPTH];
      modport test (input enable);
      modport dut (output enable);
endinterface

/**
 * BusF interface Block.
 * A parameterized interface with two lines of parameters and two lines of IO
 *
 *  @param clk bit - description of parameter clk
 *  @param foo logic - description of parameter foo
 *
 */
interface bus_F #(WIDTH=8,
                  DEPTH=20) (input bit clk,
                             output logic foo);
      logic [WDTH-1:0] cmd;
      logic enable;
      logic arr [DEPTH];
      modport test (input enable);
      modport dut (output enable);
endinterface

/**
 * My Derived Class.
 * Extends test_class_basic
 *
 * @class myderivedclass
 *
 */
class myderivedclass extends test_class_basic;
   int m_myint; ///< Description of My Int
   bit m_mybit; ///< Description of My Bit
endclass

/**
 * My Derived Class Package.
 * Extends foopack::foo_test_class
 *
 * @class myderivedclass_package
 *
 */
class myderivedclass_package extends foopack::foo_test_class;
   int m_myint; ///< Description of My Int
   bit m_mybit; ///< Description of My Bit
endclass

/**
 * My Template Class.
 * type T=int
 * extends test_class_basic
 *
 * @class mytemplateclass
 *
 */
class mytemplateclass #(type T=int) extends test_class_basic;
   int m_myint; ///< Description of My Int
   bit m_mybit; ///< Description of My Bit
endclass

/**
 * My Template Class2.
 * type T=custom
 * extends mytemplateclass#(bit)
 *
 * @class mytemplateclass2
 *
 */
class mytemplateclass2 #(type T=custom) extends mytemplateclass#(bit);
   int m_myint; ///< Description of My Int
   bit m_mybit; ///< Description of My Bit
endclass

/**
 * My Template Class3.
 * type T=int, type B=bit
 * extends mytemplateclass#(bit)
 *
 * @class mytemplateclass3
 *
 */
class mytemplateclass3 #(type T=int, type B=bit) extends mytemplateclass#(bit);
   int m_myint;
   bit m_mybit;
endclass

/**
 * My Template Class4.
 * type T=int
 * extends nothing...
 *
 * @class mytemplateclass4
 *
 */
class mytemplateclass4 #(type T=int);
   int m_myint;
   bit m_mybit;
endclass

/**
 * My Template Class5.
 * int B=3
 * extends nothing...
 *
 * @class mytemplateclass5
 *
 */
class mytemplateclass5 #(int B=3);
   int m_myint;
   bit m_mybit;
endclass

/**
 * My Template Class6.
 * type T=int, int B=3
 * extends nothing...
 *
 * @class mytemplateclass6
 *
 */
class mytemplateclass6 #(type T=int, int B=3);
   int m_myint;
   bit m_mybit;
endclass

/**
 * My Template Class7.
 * type T=int, int B=3
 * extends mytemplateclass#(bit)
 *
 * @class mytemplateclass7
 *
 */
class mytemplateclass7 #(type T=int, int B=3) extends mytemplateclass #(bit);
   int m_myint;
   bit m_mybit;
endclass

/**
 * My Template Class8.
 * type T=int, int B=3, type C=mine
 * extends mytemplateclass6#(bit, 5)
 *
 * @class mytemplateclass8
 *
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
 *
 * @class mytemplateclass9
 *
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
 *
 * @class mytemplateclass10
 *
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
 *
 * @class myclass11
 *
 */
class myclass11 extends mytemplateclass10 #(foo, 5, boo);
   int m_myint;
endclass

/**
 * My Template Class12.
 * type T=int, int B=3, type C=mine
 * extends mytemplateclass6#(bit, 5)
 *
 * @class mytemplateclass12
 *
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

/**
 * My Template Select Class.
 * Template class that is an ifdef extension of a `defined base class
 *
 * @class mytemplateselectclass
 *
 */
class mytemplateselectclass #(type ABC=data, type DEF=data2)
`ifdef DEFBASE
  extends `DEFBASE
`endif
;
   int m_myint;
endclass

/**
 * My Select Class.
 * Class that is an ifdef extension of a `defined base class
 *
 * @class myselectclass
 *
 */
class myselectclass
`ifdef DEFBASE
  extends `DEFBASE
`endif
;
   int m_myint;
endclass

/**
 * abc Class.
 * Template Class with 3 template types extending a template class "def"
 *
 * @class abc
 *
 */
class abc #(type f = null, type g = z, type h = x) extends def #(f);
   int m_myint;
endclass

`endif


