import default
import semmle.code.java.dataflow.DefUse

from VarRead u1, VarRead u2, Variable v
where useUsePair(u1, u2) and u1.getVariable() = v
select v, u1.getLocation().getStartLine(), u2.getLocation().getStartLine()
