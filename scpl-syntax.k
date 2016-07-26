/*!
	\setlength{\parindent}{1em}
	\title{SCPL Definition: Tree structure}
	\author {Taquyeddine Zegaoui (\texttt{taquyeddine.zegaoui@gmail.com})}
	\organization{...}
*/

/*@
	\section{Abstract}
	This file defines the syntax of the SCPL language. SCPL is a domain specific language serving the purpose of defining BPF system call policies easier.
	This definition of SCPL is based on a tree structure of the statements.
*/

module SCPL-SYNTAX

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
		\subsubsection{RuleCodeString}
		A RuleCodeString serves to describe the statement introducing the behavior enforced for a specific system call.
		It contains an introductory sentence followed by a SysCode.
	*/
	syntax ActionCodeString ::= "action" "="

	/*@
		\subsubsection{RuleAction}
		A RuleAction serves to describe the statement introducing the behavior enforced for a specific system call.
		It contains an introductory sentence followed by an ActionCode.
	*/
	syntax RuleAction ::= ActionCodeString ActionCode	

	/*@
		\subsubsection{RuleCodeString}
		A RuleCodeString serves to describe the statement introducing the behavior enforced for a specific system call.
		It contains an introductory sentence followed by a SysCode.
	*/
	syntax SysCodeString ::= "syscall" "="

	/*@
		\subsubsection{RuleCode}
		A RuleCode serves to describe the statement introducing the behavior enforced for a specific system call.
		It contains an introductory sentence followed by a SysCode.
	*/
	syntax RuleCode ::= SysCodeString SysCode [strict]	

	/*@
		\subsubsection{RuleCase}
		A RuleCase serves to describe the entire policy corresponding to a behavior enforced for a specific system call.
		It contains a single instance of both RuleAction and RuleCode, separated by a comma, and is enclosed between brackets.
	*/
	syntax RuleCase ::= "{" RuleAction ";" RuleCode "}" [strict]
		//| "{" RuleCase "}" [strict, bracket]	

	/*@
		\subsubsection{RulesList}
		The RulesList element describe the list of rules describing the enforced behavior corresponding to each system call.
		It is a list of RuleCase, separated by commas and enclosed between brackets.
	*/
	syntax RulesList ::= List{RuleCase, ";"} [seqstrict] 
		//| RulesList RuleCase
		//| 
		//| RuleCase
		//| RulesList ";" RulesList [left]
		//| RuleCase 	[bracket]
		//| "[" RulesList "]" [bracket]

	/*@
		\subsubsection{RulesString}
		The RulesString element serves to introduce the list of rules with a introductory statement.
		It is presented as a short sentence followed by an instance of RulesList.
	*/
	syntax RulesListString ::= "rules" "="
	/*@
		\subsubsection{Rules}
		The Rules element serves to introduce the list of rules with a introductory statement.
		It is presented as a short sentence followed by an instance of RulesList.
	*/
	syntax Rules ::= RulesListString "[" RulesList "]" //[seqstrict]

	/*@
		\subsubsection{DefaultRule}
		The DefaultRule serves to describe the defined default behavior.
		It is presented as an introductory sentence followed by the corresponding ActionCode.
	*/
	syntax DefaultRuleString ::= "default_action" "="

	/*@
		\subsubsection{DefaultRule}
		The DefaultRule serves to describe the defined default behavior.
		It is presented as an introductory sentence followed by the corresponding ActionCode.
	*/
	syntax DefaultRule ::= DefaultRuleString ActionCode [strict]

	/*@
		\subsubsection{Body}
		The Body element serves to describe the code corresponding to all the policies.
		It contains an instance of both DefaultRule and Rules, separated by a comma.
	*/
	syntax Body ::= DefaultRule ";" Rules [strict(2 1)]

	/*@
		\subsubsection{Block}
		The Block element serves as a container for the whole code.
		It contains a single instance of Body, encased in brackets.
	*/
	syntax Program ::= "{" Body "}" [strict]	

endmodule