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

/*@
	\section{Sytax module}
	This part is in charge of defining SCPL's syntax
*/

module SCPL

/*@
	\subsection{Syntax elements}
	Following are the different elements which the SCPL syntax makes use of.
*/

/*@
	\subsubsection{ActionCode}
	An ActionCode serves to describe the code corresponding to a behavior enforced for a specific system call.
	It is presented as an Identifier in the present syntax.
*/
syntax ActionCode ::= Id

/*@
	\subsubsection{SysCode}
	A SysCode serves to describe the code corresponding to a specific system call.
	It is presented as an Identifier in the present syntax.
*/
syntax SysCode ::= Id

/*@
	\subsubsection{RuleAction}
	A RuleAction serves to describe the statement introducing the behavior enforced for a specific system call.
	It contains an introductory sentence followed by an ActionCode.
*/
syntax RuleAction ::= "action =" ActionCode

/*@
	\subsubsection{RuleCode}
	A RuleCode serves to describe the statement introducing the behavior enforced for a specific system call.
	It contains an introductory sentence followed by a SysCode.
*/
syntax RuleCode ::= "syscall =" SysCode

/*@
	\subsubsection{RuleCase}
	A RuleCase serves to describe the entire policy corresponding to a behavior enforced for a specific system call.
	It contains a single instance of both RuleAction and RuleCode, separated by a comma, and is enclosed between brackets.
*/
syntax RuleCase ::= "{" RuleCase "}" [bracket]
	| RuleAction ";" RuleCode [left]

/*@
	\subsubsection{RulesList}
	The RulesList element describe the list of rules describing the enforced behavior corresponding to each system call.
	It is a list of RuleCase, separated by commas and enclosed between brackets.
*/
syntax RulesList ::= "[" RulesList "]" [bracket]
	| RulesList ";" RulesList [left]
	| RuleCase

/*@
	\subsubsection{Rules}
	The Rules element serves to introduce the list of rules with a introductory statement.
	It is presented as a short sentence followed by an instance of RulesList.
*/
syntax Rules ::= "rules =" RulesList

/*@
	\subsubsection{DefaultRule}
	The DefaultRule serves to describe the defined default behavior.
	It is presented as an introductory sentence followed by the corresponding ActionCode.
*/
syntax DefaultRule ::= "default_action =" ActionCode

/*@
	\subsubsection{Body}
	The Body element serves to describe the code corresponding to all the policies.
	It contains an instance of both DefaultRule and Rules, separated by a comma.
*/
syntax Body ::= DefaultRule ";" Rules

/*@
	\subsubsection{Block}
	The Block element serves as a container for the whole code.
	It contains a single instance of Body, encased in brackets.
*/
syntax Block ::= "{" Body "}" [bracket]

/*@
	\subsection{Variables}
	The SCPL syntax manipulates Ids, namely ActionCodes and SysCodes. Therefore we declare them as potential results, hence KResult;
	and as potential variables, hence KVariable.
*/
syntax KResult ::= Id
syntax KVariable ::= Id

endmodule