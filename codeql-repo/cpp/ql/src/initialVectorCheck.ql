import cpp

from FunctionCall encryptInitCall, Expr ivArg
where
  encryptInitCall.getTarget().hasName("EVP_EncryptInit_ex") and
  ivArg = encryptInitCall.getArgument(4) and
  (
    ivArg.(VariableAccess).getTarget().getType() instanceof ArrayType or
    ivArg instanceof StringLiteral
  )
select encryptInitCall, ivArg, "This call to EVP_EncryptInit_ex may use a constant IV."