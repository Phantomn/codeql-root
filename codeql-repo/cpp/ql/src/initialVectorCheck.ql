import cpp

from FunctionCall encryptInitCall, Expr ivArg, Variable v
where
  encryptInitCall.getTarget().hasName("EVP_EncryptInit_ex") and
  ivArg = encryptInitCall.getArgument(4) and
  v = ivArg.(VariableAccess).getTarget()
select encryptInitCall, ivArg, v.getAnAssignedValue()