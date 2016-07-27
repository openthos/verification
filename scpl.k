/*!
	\setlength{\parindent}{1em}
	\title{SCPL Definition: Tree structure}
	\author {Taquyeddine Zegaoui (\texttt{taquyeddine.zegaoui@gmail.com})}
	\organization{...}
*/

/*@
	\section{Abstract}
	This file defines the SCPL language. SCPL is a domain specific language serving the purpose of defining BPF system call policies easier.
	This definition of SCPL is based on a tree structure of the statements.
*/
require "scpl-syntax.k"

module SCPL
	imports SCPL-SYNTAX

	/*@
		\subsection{Variables}
		The SCPL syntax manipulates Ids, namely ActionCodes and SysCodes. Therefore we declare them as potential results, hence KResult;
		and as potential variables, hence KVariable.
	*/
	syntax KResult ::= Id | Int | String
	syntax KVariable ::= Id | Int | Bool | String

	configuration <T color="yellow">
		<k color="green"> $PGM:Program </k>
		<state color="red">  .Map</state>
		<store color="cyan"> 0 </store>
		<in color="magenta" stream="stdin"> .List </in>
		<out color="Orchid" stream="stdout"> .List </out>
	</T>

	//ActionCodeString
	rule ACS:ActionCodeString => . [structural]
	//SysCodeString
	rule SCS:SysCodeString => . [structural]
	//RuleAction
	//RuleCode
	//RuleCase
	//RulesListString
	//RulesList
	rule R:RuleCase ; Rs:RulesList => R ~> Rs  [structural]
	//Rules

	//DefaultRuleString
	//rule DRS:DefaultRuleString => . [structural]
	//DefaultRule

	syntax Printable ::= Int | String | Id
  	syntax ActionCode ::= Printable
  	context DRS:DefaultRuleString HOLE:ActionCode
  	rule <k>... DRS:DefaultRuleString AC:ActionCode => . ...</k> <out>... .List => ListItem(AC) </out> [print]

	//Body
	rule DR:DefaultRule ; Rss:Rules => Rss ~> DR [structural]
	//Program
	//rule .Program => . [structural]
	rule { B:Body } => B [structural]
	

	//RULES NOT TREATED YET
	//rule <k>... ((R:RuleCase ); Rs => Rs ) ...</k> <store> 0 => 1 </store>//<store> I => I +Int 1 </store> [increment]
	//rule '{' '}' => .   [structural]
	//rule { S:RuleCase } => S  [structural]
	//rule ( S:RulesList ) => S  [structural]
	//rule D:DefaultRuleString => . [structural]
	//rule <k> ( S:RuleCase ) => S  </k>
	//rule <k> ( .RulesList ) => . ...</k>
	//rule <k> .RulesList => . ...</k> [structural]
	//rule <k> ActionCodeString => . ...</k> [structural]

	//rule <k>  A1:RuleAction ; A2:RuleCode ... </k> <store> Nb |-> (Nb +Int 1) </store> 
	//rule <k> { action = A:ActionCode ; syscall = S:SysCode } </k> <store> Nb |-> ( I:Int => I +Int 1) </store> [structural]

	//rule <k> { action = A:ActionCode ; syscall = S:SysCode } => { A ; S } ...</k> <store> Nb |-> ( I:Int => I +Int 1) </store>

	//rule <k> R1:RuleCase ; R2:RuleCase </k> <state> R1 ~> R2 </state>

	//rule <k> { action = A:ActionCode ; syscall = S:SysCode } ; R2:RuleCase </k>
		//<state> if Syscall = S:SysCode then (Result => A:ActionCode) else R2 </state>

	//rule   //Default Rule semantic

endmodule