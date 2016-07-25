module SCPL2BPF

	imports SCPL-SYNTAX

	configuration <T color="yellow">
		<k color="green"> $PGM:Pgm </k>
		<state color="red">
			ld[0];
		</state>
	</T>

	rule <k> rules = [ R:RulesList ] => R:RulesList ...</k> [structural]

	rule <k> { action = A:ActionCode ; syscall = S:SysCode } => . </k>
		<state>...
		Nb:Int jeq #S:SysCode (Nb +Int 1) (Nb +Int 2);
		(Nb +Int 1) ret A:ActionCode;
		...
		</state> [anywhere]

	rule <k> default_action = A:ActionCode ; => . ... </k>
		<state> ...
		ret #A:ActionCode;
		</state>