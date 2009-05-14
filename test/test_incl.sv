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
 * Test Include File.
 * This file is a test of the doxygen filter script.<br>
 * This contains a couple of classes to be included in a package with a `include<br>
 * <br>
 * <br>
 * @par Download the most recent version here:
 * http://intelligentdv.com/downloads/
 * <br>
 * @par File Bugs Here:
 * http://bugs.intelligentdv.com/ <br>
 * Project:  DoxygenFilter
 *
 * @file test_incl.sv
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

`ifndef TEST_INCL__SV
`define TEST_INCL__SV

/**
 *  Test Class Incl 1
 *  Just a basic class declaration in a class.<br>
 *
 *  @class incl_test_class
 *
 */
class incl_test_class;
   int m_anint;
endclass: incl_test_class
/**
 *  Test Class Incl 2 in foo package.
 *  Just a basic class declaration in a class.<br>
 *
 *  @class incl_test_class2
 *
 */
class incl_test_class2;
   int m_anint;
endclass: incl_test_class2

`endif