/*!
	\setlength{\parindent}{1em}
	\title{SCPL Definition: Tree structure}
	\author {Taquyeddine Zegaoui (\texttt{taquyeddine.zegaoui@gmail.com})}
	\organization{...}
*/

/*@
	\section{Abstract}
	This file defines the SCPL language. SCPL is a domain specific language serving the purpose of defining BPF system call policies easier.
	This definition of SCPL is based on a list structure of the statements.
*/

/*@
	\section{Sytax module}
	This part is in charge of defining SCPL2's syntax
*/

module SCPL2

/*@
	\subsection{Syntax elements}
	Following are the different elements which the SCPL2 syntax makes use of.
*/

	syntax ActionCode ::= Id

	syntax SysCode ::= Id

	syntax S13 ::= "}"

	syntax S12 ::= ";" S5
		| "]" S13 

	syntax S11 ::= "}" S12

	syntax S10 ::= SysCode S11

	syntax S9 ::= "syscall =" S10

	syntax S8 ::= ";" S9

	syntax S7 ::= ActionCode S8

	syntax S6 ::= "action =" S7

	syntax S5 ::= "{" S6

	syntax S4 ::= "rules = [" S5
	
	syntax S3 ::= ";" S4

	syntax S2 ::= ActionCode S3

	syntax S1 ::= "default_action =" S2
	
	syntax S ::= "{" S1

	syntax KResult ::= Id

	syntax KVariable ::= Id

endmodule