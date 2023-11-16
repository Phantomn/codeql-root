import cpp

from FunctionCall scanfCall, Expr formatString, AddressOfExpr addrOf, VariableAccess va
where
  scanfCall.getTarget().hasGlobalName("scanf") and
  formatString = scanfCall.getArgument(0) and
  formatString.getValue().matches("%d") and
  addrOf = scanfCall.getArgument(1).(AddressOfExpr) and
  va = addrOf.getOperand().(VariableAccess) and
  formatString.getValue().matches("%d") and
  va.getTarget().getType().(IntegralType).getSize() = 4
select scanfCall, formatString, va, va.getTarget().getType(),
    "Non-Vulnerable pattern : %d format string with non-int type variable."