import cpp
from FunctionCall readCall, VariableAccess buffer, int size, int bufferSize
where
  readCall.getTarget().hasGlobalName("read") and
  buffer = readCall.getArgument(1).(VariableAccess) and
  size = readCall.getArgument(2).getValue().toInt() and
  (
    exists(ArrayType arrayType |
      arrayType = buffer.getTarget().getType().(ArrayType) and
      bufferSize = arrayType.getSize() and
      bufferSize < size
    )
  )
select readCall, "Potential buffer overflow. Buffer size is " + bufferSize.toString() + " bytes, but trying to read " + size.toString() + " bytes."