private import cpp
private import semmle.code.cpp.ir.internal.IRUtilities
private import semmle.code.cpp.ir.implementation.internal.OperandTag
private import semmle.code.cpp.ir.internal.CppType
private import semmle.code.cpp.ir.internal.TempVariableTag
private import InstructionTag
private import TranslatedCondition
private import TranslatedDeclarationEntry
private import TranslatedElement
private import TranslatedExpr
private import TranslatedFunction
private import TranslatedInitialization

TranslatedStmt getTranslatedStmt(Stmt stmt) { result.getAst() = stmt }

TranslatedMicrosoftTryExceptHandler getTranslatedMicrosoftTryExceptHandler(
  MicrosoftTryExceptStmt tryExcept
) {
  result.getAst() = tryExcept.getExcept()
}

class TranslatedMicrosoftTryExceptHandler extends TranslatedElement,
  TTranslatedMicrosoftTryExceptHandler
{
  MicrosoftTryExceptStmt tryExcept;

  TranslatedMicrosoftTryExceptHandler() { this = TTranslatedMicrosoftTryExceptHandler(tryExcept) }

  final override string toString() { result = tryExcept.toString() }

  final override Locatable getAst() { result = tryExcept.getExcept() }

  override Instruction getFirstInstruction() { result = this.getChild(0).getFirstInstruction() }

  override predicate hasInstruction(Opcode opcode, InstructionTag tag, CppType resultType) {
    // t1 = -1
    tag = TryExceptGenerateNegativeOne() and
    opcode instanceof Opcode::Constant and
    resultType = getIntType()
    or
    // t2 = cmp t1, condition
    tag = TryExceptCompareNegativeOne() and
    opcode instanceof Opcode::CompareEQ and
    resultType = getBoolType()
    or
    // if t2 goto ... else goto ...
    tag = TryExceptCompareNegativeOneBranch() and
    opcode instanceof Opcode::ConditionalBranch and
    resultType = getVoidType()
    or
    // t1 = 0
    tag = TryExceptGenerateZero() and
    opcode instanceof Opcode::Constant and
    resultType = getIntType()
    or
    // t2 = cmp t1, condition
    tag = TryExceptCompareZero() and
    opcode instanceof Opcode::CompareEQ and
    resultType = getBoolType()
    or
    // if t2 goto ... else goto ...
    tag = TryExceptCompareZeroBranch() and
    opcode instanceof Opcode::ConditionalBranch and
    resultType = getVoidType()
    or
    // t1 = 1
    tag = TryExceptGenerateOne() and
    opcode instanceof Opcode::Constant and
    resultType = getIntType()
    or
    // t2 = cmp t1, condition
    tag = TryExceptCompareOne() and
    opcode instanceof Opcode::CompareEQ and
    resultType = getBoolType()
    or
    // if t2 goto ... else goto ...
    tag = TryExceptCompareOneBranch() and
    opcode instanceof Opcode::ConditionalBranch and
    resultType = getVoidType()
    or
    // unwind stack
    tag = UnwindTag() and
    opcode instanceof Opcode::Unwind and
    resultType = getVoidType()
  }

  final override Instruction getInstructionRegisterOperand(InstructionTag tag, OperandTag operandTag) {
    tag = TryExceptCompareNegativeOne() and
    (
      operandTag instanceof LeftOperandTag and
      result = this.getTranslatedCondition().getResult()
      or
      operandTag instanceof RightOperandTag and
      result = this.getInstruction(TryExceptGenerateNegativeOne())
    )
    or
    tag = TryExceptCompareNegativeOneBranch() and
    operandTag instanceof ConditionOperandTag and
    result = this.getInstruction(TryExceptCompareNegativeOne())
    or
    tag = TryExceptCompareZero() and
    (
      operandTag instanceof LeftOperandTag and
      result = this.getTranslatedCondition().getResult()
      or
      operandTag instanceof RightOperandTag and
      result = this.getInstruction(TryExceptGenerateZero())
    )
    or
    tag = TryExceptCompareZeroBranch() and
    operandTag instanceof ConditionOperandTag and
    result = this.getInstruction(TryExceptCompareZero())
    or
    tag = TryExceptCompareOne() and
    (
      operandTag instanceof LeftOperandTag and
      result = this.getTranslatedCondition().getResult()
      or
      operandTag instanceof RightOperandTag and
      result = this.getInstruction(TryExceptGenerateOne())
    )
    or
    tag = TryExceptCompareOneBranch() and
    operandTag instanceof ConditionOperandTag and
    result = this.getInstruction(TryExceptCompareOne())
  }

  override string getInstructionConstantValue(InstructionTag tag) {
    tag = TryExceptGenerateNegativeOne() and
    result = "-1"
    or
    tag = TryExceptGenerateZero() and
    result = "0"
    or
    tag = TryExceptGenerateOne() and
    result = "1"
  }

  override Instruction getInstructionSuccessor(InstructionTag tag, EdgeKind kind) {
    // Generate -1 -> Compare condition
    tag = TryExceptGenerateNegativeOne() and
    kind instanceof GotoEdge and
    result = this.getInstruction(TryExceptCompareNegativeOne())
    or
    // Compare condition -> Branch
    tag = TryExceptCompareNegativeOne() and
    kind instanceof GotoEdge and
    result = this.getInstruction(TryExceptCompareNegativeOneBranch())
    or
    // Branch -> Unwind or Generate 0
    tag = TryExceptCompareNegativeOneBranch() and
    (
      kind instanceof TrueEdge and
      // TODO: This is not really correct. The semantics of `EXCEPTION_CONTINUE_EXECUTION` is that
      // we should continue execution at the point where the exception occurred. But we don't have
      // any instruction to model this behavior.
      result = this.getInstruction(UnwindTag())
      or
      kind instanceof FalseEdge and
      result = this.getInstruction(TryExceptGenerateZero())
    )
    or
    // Generate 0 -> Compare condition
    tag = TryExceptGenerateZero() and
    kind instanceof GotoEdge and
    result = this.getInstruction(TryExceptCompareZero())
    or
    // Compare condition -> Branch
    tag = TryExceptCompareZero() and
    kind instanceof GotoEdge and
    result = this.getInstruction(TryExceptCompareZeroBranch())
    or
    // Branch -> Unwind or Generate 1
    tag = TryExceptCompareZeroBranch() and
    (
      kind instanceof TrueEdge and
      result = this.getInstruction(UnwindTag())
      or
      kind instanceof FalseEdge and
      result = this.getInstruction(TryExceptGenerateOne())
    )
    or
    // Generate 1 -> Compare condition
    tag = TryExceptGenerateOne() and
    kind instanceof GotoEdge and
    result = this.getInstruction(TryExceptCompareOne())
    or
    // Compare condition -> Branch
    tag = TryExceptCompareOne() and
    kind instanceof GotoEdge and
    result = this.getInstruction(TryExceptCompareOneBranch())
    or
    // Branch -> Handler (the condition value is always 0, -1 or 1, and we've checked for 0 or -1 already.)
    tag = TryExceptCompareOneBranch() and
    (
      kind instanceof TrueEdge and
      result = this.getTranslatedHandler().getFirstInstruction()
    )
    or
    // Unwind -> Parent
    tag = UnwindTag() and
    kind instanceof GotoEdge and
    result = this.getParent().getChildSuccessor(this)
  }

  override Instruction getChildSuccessor(TranslatedElement child) {
    child = this.getTranslatedCondition() and
    result = this.getInstruction(TryExceptGenerateNegativeOne())
    or
    child = this.getTranslatedHandler() and
    result = this.getParent().getChildSuccessor(this)
  }

  private TranslatedExpr getTranslatedCondition() {
    result = getTranslatedExpr(tryExcept.getCondition())
  }

  private TranslatedStmt getTranslatedHandler() {
    result = getTranslatedStmt(tryExcept.getExcept())
  }

  override TranslatedElement getChild(int id) {
    id = 0 and
    result = this.getTranslatedCondition()
    or
    id = 1 and
    result = this.getTranslatedHandler()
  }

  final override Function getFunction() { result = tryExcept.getEnclosingFunction() }
}

abstract class TranslatedStmt extends TranslatedElement, TTranslatedStmt {
  Stmt stmt;

  TranslatedStmt() { this = TTranslatedStmt(stmt) }

  final override string toString() { result = stmt.toString() }

  final override Locatable getAst() { result = stmt }

  /** DEPRECATED: Alias for getAst */
  deprecated override Locatable getAST() { result = this.getAst() }

  final override Function getFunction() { result = stmt.getEnclosingFunction() }
}

class TranslatedEmptyStmt extends TranslatedStmt {
  TranslatedEmptyStmt() {
    stmt instanceof EmptyStmt or
    stmt instanceof LabelStmt or
    stmt instanceof SwitchCase
  }

  override TranslatedElement getChild(int id) { none() }

  override Instruction getFirstInstruction() { result = this.getInstruction(OnlyInstructionTag()) }

  override predicate hasInstruction(Opcode opcode, InstructionTag tag, CppType resultType) {
    tag = OnlyInstructionTag() and
    opcode instanceof Opcode::NoOp and
    resultType = getVoidType()
  }

  override Instruction getInstructionSuccessor(InstructionTag tag, EdgeKind kind) {
    tag = OnlyInstructionTag() and
    result = this.getParent().getChildSuccessor(this) and
    kind instanceof GotoEdge
  }

  override Instruction getChildSuccessor(TranslatedElement child) { none() }
}

/**
 * The IR translation of a declaration statement. This consists of the IR for each of the individual
 * local variables declared by the statement. Declarations for extern variables and functions
 * do not generate any instructions.
 */
class TranslatedDeclStmt extends TranslatedStmt {
  override DeclStmt stmt;

  override TranslatedElement getChild(int id) { result = this.getDeclarationEntry(id) }

  override predicate hasInstruction(Opcode opcode, InstructionTag tag, CppType resultType) {
    none()
  }

  override Instruction getFirstInstruction() {
    result = this.getDeclarationEntry(0).getFirstInstruction()
    or
    not exists(this.getDeclarationEntry(0)) and result = this.getParent().getChildSuccessor(this)
  }

  private int getChildCount() { result = count(this.getDeclarationEntry(_)) }

  IRDeclarationEntry getIRDeclarationEntry(int index) {
    result.hasIndex(index) and
    result.getStmt() = stmt
  }

  IRDeclarationEntry getAnIRDeclarationEntry() { result = this.getIRDeclarationEntry(_) }

  /**
   * Gets the `TranslatedDeclarationEntry` child at zero-based index `index`. Since not all
   * `DeclarationEntry` objects have a `TranslatedDeclarationEntry` (e.g. extern functions), we map
   * the original children into a contiguous range containing only those with an actual
   * `TranslatedDeclarationEntry`.
   */
  private TranslatedDeclarationEntry getDeclarationEntry(int index) {
    result =
      rank[index + 1](TranslatedDeclarationEntry entry, int originalIndex |
        entry = getTranslatedDeclarationEntry(this.getIRDeclarationEntry(originalIndex))
      |
        entry order by originalIndex
      )
  }

  override Instruction getInstructionSuccessor(InstructionTag tag, EdgeKind kind) { none() }

  override Instruction getChildSuccessor(TranslatedElement child) {
    exists(int index |
      child = this.getDeclarationEntry(index) and
      if index = (this.getChildCount() - 1)
      then result = this.getParent().getChildSuccessor(this)
      else result = this.getDeclarationEntry(index + 1).getFirstInstruction()
    )
  }
}

class TranslatedExprStmt extends TranslatedStmt {
  override ExprStmt stmt;

  TranslatedExpr getExpr() { result = getTranslatedExpr(stmt.getExpr().getFullyConverted()) }

  override TranslatedElement getChild(int id) { id = 0 and result = this.getExpr() }

  override predicate hasInstruction(Opcode opcode, InstructionTag tag, CppType resultType) {
    none()
  }

  override Instruction getFirstInstruction() { result = this.getExpr().getFirstInstruction() }

  override Instruction getInstructionSuccessor(InstructionTag tag, EdgeKind kind) { none() }

  override Instruction getChildSuccessor(TranslatedElement child) {
    child = this.getExpr() and
    result = this.getParent().getChildSuccessor(this)
  }
}

abstract class TranslatedReturnStmt extends TranslatedStmt {
  override ReturnStmt stmt;

  final TranslatedFunction getEnclosingFunction() {
    result = getTranslatedFunction(stmt.getEnclosingFunction())
  }
}

/**
 * The IR translation of a `return` statement that returns a value.
 */
class TranslatedReturnValueStmt extends TranslatedReturnStmt, TranslatedVariableInitialization {
  TranslatedReturnValueStmt() { stmt.hasExpr() and hasReturnValue(stmt.getEnclosingFunction()) }

  final override Instruction getInitializationSuccessor() {
    result = this.getEnclosingFunction().getReturnSuccessorInstruction()
  }

  final override Type getTargetType() { result = this.getEnclosingFunction().getReturnType() }

  final override TranslatedInitialization getInitialization() {
    result = getTranslatedInitialization(stmt.getExpr().getFullyConverted())
  }

  final override IRVariable getIRVariable() {
    result = this.getEnclosingFunction().getReturnVariable()
  }
}

/**
 * The IR translation of a `return` statement that returns an expression of `void` type.
 */
class TranslatedReturnVoidExpressionStmt extends TranslatedReturnStmt {
  TranslatedReturnVoidExpressionStmt() {
    stmt.hasExpr() and not hasReturnValue(stmt.getEnclosingFunction())
  }

  override TranslatedElement getChild(int id) {
    id = 0 and
    result = this.getExpr()
  }

  override Instruction getFirstInstruction() { result = this.getExpr().getFirstInstruction() }

  override predicate hasInstruction(Opcode opcode, InstructionTag tag, CppType resultType) {
    tag = OnlyInstructionTag() and
    opcode instanceof Opcode::NoOp and
    resultType = getVoidType()
  }

  override Instruction getInstructionSuccessor(InstructionTag tag, EdgeKind kind) {
    tag = OnlyInstructionTag() and
    result = this.getEnclosingFunction().getReturnSuccessorInstruction() and
    kind instanceof GotoEdge
  }

  override Instruction getChildSuccessor(TranslatedElement child) {
    child = this.getExpr() and
    result = this.getInstruction(OnlyInstructionTag())
  }

  private TranslatedExpr getExpr() { result = getTranslatedExpr(stmt.getExpr()) }
}

/**
 * The IR translation of a `return` statement that does not return a value. This includes implicit
 * return statements at the end of `void`-returning functions.
 */
class TranslatedReturnVoidStmt extends TranslatedReturnStmt {
  TranslatedReturnVoidStmt() {
    not stmt.hasExpr() and not hasReturnValue(stmt.getEnclosingFunction())
  }

  override TranslatedElement getChild(int id) { none() }

  override Instruction getFirstInstruction() { result = this.getInstruction(OnlyInstructionTag()) }

  override predicate hasInstruction(Opcode opcode, InstructionTag tag, CppType resultType) {
    tag = OnlyInstructionTag() and
    opcode instanceof Opcode::NoOp and
    resultType = getVoidType()
  }

  override Instruction getInstructionSuccessor(InstructionTag tag, EdgeKind kind) {
    tag = OnlyInstructionTag() and
    result = this.getEnclosingFunction().getReturnSuccessorInstruction() and
    kind instanceof GotoEdge
  }

  override Instruction getChildSuccessor(TranslatedElement child) { none() }
}

/**
 * The IR translation of an implicit `return` statement generated by the extractor to handle control
 * flow that reaches the end of a non-`void`-returning function body. Such control flow
 * produces undefined behavior in C++ but not in C. However even in C using the return value is
 * undefined behaviour. We make it return uninitialized memory to get as much flow as possible.
 */
class TranslatedNoValueReturnStmt extends TranslatedReturnStmt, TranslatedVariableInitialization {
  TranslatedNoValueReturnStmt() {
    not stmt.hasExpr() and hasReturnValue(stmt.getEnclosingFunction())
  }

  final override Instruction getInitializationSuccessor() {
    result = this.getEnclosingFunction().getReturnSuccessorInstruction()
  }

  final override Type getTargetType() { result = this.getEnclosingFunction().getReturnType() }

  final override TranslatedInitialization getInitialization() { none() }

  final override IRVariable getIRVariable() {
    result = this.getEnclosingFunction().getReturnVariable()
  }
}

/**
 * A C/C++ `try` statement, or a `__try __except` or `__try __finally` statement.
 */
private class TryOrMicrosoftTryStmt extends Stmt {
  TryOrMicrosoftTryStmt() {
    this instanceof TryStmt or
    this instanceof MicrosoftTryStmt
  }

  /** Gets the number of `catch block`s of this statement. */
  int getNumberOfCatchClauses() {
    result = this.(TryStmt).getNumberOfCatchClauses()
    or
    this instanceof MicrosoftTryExceptStmt and
    result = 1
    or
    this instanceof MicrosoftTryFinallyStmt and
    result = 0
  }

  /** Gets the `body` statement of this statement. */
  Stmt getStmt() {
    result = this.(TryStmt).getStmt()
    or
    result = this.(MicrosoftTryStmt).getStmt()
  }

  /** Gets the `i`th translated handler of this statement. */
  TranslatedElement getTranslatedHandler(int index) {
    result = getTranslatedStmt(this.(TryStmt).getChild(index + 1))
    or
    index = 0 and
    result = getTranslatedMicrosoftTryExceptHandler(this)
  }

  /** Gets the `finally` statement (usually a BlockStmt), if any. */
  Stmt getFinally() { result = this.(MicrosoftTryFinallyStmt).getFinally() }
}

/**
 * The IR translation of a C++ `try` (or a `__try __except` or `__try __finally`) statement.
 */
class TranslatedTryStmt extends TranslatedStmt {
  override TryOrMicrosoftTryStmt stmt;

  override TranslatedElement getChild(int id) {
    id = 0 and result = this.getBody()
    or
    result = this.getHandler(id - 1)
    or
    id = stmt.getNumberOfCatchClauses() + 1 and
    result = this.getFinally()
  }

  override predicate hasInstruction(Opcode opcode, InstructionTag tag, CppType resultType) {
    none()
  }

  override Instruction getInstructionSuccessor(InstructionTag tag, EdgeKind kind) { none() }

  override Instruction getFirstInstruction() { result = this.getBody().getFirstInstruction() }

  override Instruction getChildSuccessor(TranslatedElement child) {
    // All non-finally children go to the successor of the `try` if
    // there is no finally block, but if there is a finally block
    // then we go to that one.
    child = [this.getBody(), this.getHandler(_)] and
    (
      not exists(this.getFinally()) and
      result = this.getParent().getChildSuccessor(this)
      or
      result = this.getFinally().getFirstInstruction()
    )
    or
    // And after the finally block we go to the successor of the `try`.
    child = this.getFinally() and
    result = this.getParent().getChildSuccessor(this)
  }

  final Instruction getNextHandler(TranslatedHandler handler) {
    exists(int index |
      handler = this.getHandler(index) and
      result = this.getHandler(index + 1).getFirstInstruction()
    )
    or
    // The last catch clause flows to the exception successor of the parent
    // of the `try`, because the exception successor of the `try` itself is
    // the first catch clause.
    handler = this.getHandler(stmt.getNumberOfCatchClauses() - 1) and
    result = this.getParent().getExceptionSuccessorInstruction()
  }

  final override Instruction getExceptionSuccessorInstruction() {
    result = this.getHandler(0).getFirstInstruction()
  }

  private TranslatedElement getHandler(int index) { result = stmt.getTranslatedHandler(index) }

  private TranslatedStmt getFinally() { result = getTranslatedStmt(stmt.getFinally()) }

  private TranslatedStmt getBody() { result = getTranslatedStmt(stmt.getStmt()) }
}

class TranslatedBlock extends TranslatedStmt {
  override BlockStmt stmt;

  override TranslatedElement getChild(int id) { result = this.getStmt(id) }

  override predicate hasInstruction(Opcode opcode, InstructionTag tag, CppType resultType) {
    this.isEmpty() and
    opcode instanceof Opcode::NoOp and
    tag = OnlyInstructionTag() and
    resultType = getVoidType()
  }

  override Instruction getFirstInstruction() {
    if this.isEmpty()
    then result = this.getInstruction(OnlyInstructionTag())
    else result = this.getStmt(0).getFirstInstruction()
  }

  private predicate isEmpty() { not exists(stmt.getStmt(0)) }

  private TranslatedStmt getStmt(int index) { result = getTranslatedStmt(stmt.getStmt(index)) }

  private int getStmtCount() { result = stmt.getNumStmt() }

  override Instruction getInstructionSuccessor(InstructionTag tag, EdgeKind kind) {
    tag = OnlyInstructionTag() and
    result = this.getParent().getChildSuccessor(this) and
    kind instanceof GotoEdge
  }

  override Instruction getChildSuccessor(TranslatedElement child) {
    exists(int index |
      child = this.getStmt(index) and
      if index = (this.getStmtCount() - 1)
      then result = this.getParent().getChildSuccessor(this)
      else result = this.getStmt(index + 1).getFirstInstruction()
    )
  }
}

/**
 * The IR translation of a C++ `catch` handler.
 */
abstract class TranslatedHandler extends TranslatedStmt {
  override Handler stmt;

  override TranslatedElement getChild(int id) { id = 1 and result = this.getBlock() }

  override Instruction getFirstInstruction() { result = this.getInstruction(CatchTag()) }

  override Instruction getChildSuccessor(TranslatedElement child) {
    child = this.getBlock() and result = this.getParent().getChildSuccessor(this)
  }

  override Instruction getExceptionSuccessorInstruction() {
    // A throw from within a `catch` block flows to the handler for the parent of
    // the `try`.
    result = this.getParent().getParent().getExceptionSuccessorInstruction()
  }

  TranslatedStmt getBlock() { result = getTranslatedStmt(stmt.getBlock()) }
}

/**
 * The IR translation of a C++ `catch` block that catches an exception with a
 * specific type (e.g. `catch (const std::exception&)`).
 */
class TranslatedCatchByTypeHandler extends TranslatedHandler {
  TranslatedCatchByTypeHandler() { exists(stmt.getParameter()) }

  override predicate hasInstruction(Opcode opcode, InstructionTag tag, CppType resultType) {
    tag = CatchTag() and
    opcode instanceof Opcode::CatchByType and
    resultType = getVoidType()
  }

  override TranslatedElement getChild(int id) {
    result = super.getChild(id)
    or
    id = 0 and result = this.getParameter()
  }

  override Instruction getChildSuccessor(TranslatedElement child) {
    result = super.getChildSuccessor(child)
    or
    child = this.getParameter() and result = this.getBlock().getFirstInstruction()
  }

  override Instruction getInstructionSuccessor(InstructionTag tag, EdgeKind kind) {
    tag = CatchTag() and
    (
      kind instanceof GotoEdge and
      result = this.getParameter().getFirstInstruction()
      or
      kind instanceof ExceptionEdge and
      result = this.getParent().(TranslatedTryStmt).getNextHandler(this)
    )
  }

  override CppType getInstructionExceptionType(InstructionTag tag) {
    tag = CatchTag() and
    result = getTypeForPRValue(stmt.getParameter().getType())
  }

  private TranslatedParameter getParameter() {
    result = getTranslatedParameter(stmt.getParameter())
  }
}

/**
 * The IR translation of a C++ `catch (...)` block.
 */
class TranslatedCatchAnyHandler extends TranslatedHandler {
  TranslatedCatchAnyHandler() { not exists(stmt.getParameter()) }

  override predicate hasInstruction(Opcode opcode, InstructionTag tag, CppType resultType) {
    tag = CatchTag() and
    opcode instanceof Opcode::CatchAny and
    resultType = getVoidType()
  }

  override Instruction getInstructionSuccessor(InstructionTag tag, EdgeKind kind) {
    tag = CatchTag() and
    kind instanceof GotoEdge and
    result = this.getBlock().getFirstInstruction()
  }
}

class TranslatedIfStmt extends TranslatedStmt, ConditionContext {
  override IfStmt stmt;

  override Instruction getFirstInstruction() {
    if this.hasInitialization()
    then result = this.getInitialization().getFirstInstruction()
    else result = this.getFirstConditionInstruction()
  }

  override TranslatedElement getChild(int id) {
    id = 0 and result = this.getInitialization()
    or
    id = 1 and result = this.getCondition()
    or
    id = 2 and result = this.getThen()
    or
    id = 3 and result = this.getElse()
  }

  private predicate hasInitialization() { exists(stmt.getInitialization()) }

  private TranslatedStmt getInitialization() {
    result = getTranslatedStmt(stmt.getInitialization())
  }

  private TranslatedCondition getCondition() {
    result = getTranslatedCondition(stmt.getCondition().getFullyConverted())
  }

  private Instruction getFirstConditionInstruction() {
    result = this.getCondition().getFirstInstruction()
  }

  private TranslatedStmt getThen() { result = getTranslatedStmt(stmt.getThen()) }

  private TranslatedStmt getElse() { result = getTranslatedStmt(stmt.getElse()) }

  private predicate hasElse() { exists(stmt.getElse()) }

  override Instruction getInstructionSuccessor(InstructionTag tag, EdgeKind kind) { none() }

  override Instruction getChildTrueSuccessor(TranslatedCondition child) {
    child = this.getCondition() and
    result = this.getThen().getFirstInstruction()
  }

  override Instruction getChildFalseSuccessor(TranslatedCondition child) {
    child = this.getCondition() and
    if this.hasElse()
    then result = this.getElse().getFirstInstruction()
    else result = this.getParent().getChildSuccessor(this)
  }

  override Instruction getChildSuccessor(TranslatedElement child) {
    child = this.getInitialization() and
    result = this.getFirstConditionInstruction()
    or
    (child = this.getThen() or child = this.getElse()) and
    result = this.getParent().getChildSuccessor(this)
  }

  override predicate hasInstruction(Opcode opcode, InstructionTag tag, CppType resultType) {
    none()
  }
}

abstract class TranslatedLoop extends TranslatedStmt, ConditionContext {
  override Loop stmt;

  final TranslatedCondition getCondition() {
    result = getTranslatedCondition(stmt.getCondition().getFullyConverted())
  }

  final TranslatedStmt getBody() { result = getTranslatedStmt(stmt.getStmt()) }

  final Instruction getFirstConditionInstruction() {
    if this.hasCondition()
    then result = this.getCondition().getFirstInstruction()
    else result = this.getBody().getFirstInstruction()
  }

  final predicate hasCondition() { exists(stmt.getCondition()) }

  override TranslatedElement getChild(int id) {
    id = 0 and result = this.getCondition()
    or
    id = 1 and result = this.getBody()
  }

  override predicate hasInstruction(Opcode opcode, InstructionTag tag, CppType resultType) {
    none()
  }

  final override Instruction getInstructionSuccessor(InstructionTag tag, EdgeKind kind) { none() }

  final override Instruction getChildTrueSuccessor(TranslatedCondition child) {
    child = this.getCondition() and result = this.getBody().getFirstInstruction()
  }

  final override Instruction getChildFalseSuccessor(TranslatedCondition child) {
    child = this.getCondition() and result = this.getParent().getChildSuccessor(this)
  }
}

class TranslatedWhileStmt extends TranslatedLoop {
  TranslatedWhileStmt() { stmt instanceof WhileStmt }

  override Instruction getFirstInstruction() { result = this.getFirstConditionInstruction() }

  override Instruction getChildSuccessor(TranslatedElement child) {
    child = this.getBody() and result = this.getFirstConditionInstruction()
  }
}

class TranslatedDoStmt extends TranslatedLoop {
  TranslatedDoStmt() { stmt instanceof DoStmt }

  override Instruction getFirstInstruction() { result = this.getBody().getFirstInstruction() }

  override Instruction getChildSuccessor(TranslatedElement child) {
    child = this.getBody() and result = this.getFirstConditionInstruction()
  }
}

class TranslatedForStmt extends TranslatedLoop {
  override ForStmt stmt;

  override TranslatedElement getChild(int id) {
    id = 0 and result = this.getInitialization()
    or
    id = 1 and result = this.getCondition()
    or
    id = 2 and result = this.getUpdate()
    or
    id = 3 and result = this.getBody()
  }

  private TranslatedStmt getInitialization() {
    result = getTranslatedStmt(stmt.getInitialization())
  }

  private predicate hasInitialization() { exists(stmt.getInitialization()) }

  TranslatedExpr getUpdate() { result = getTranslatedExpr(stmt.getUpdate().getFullyConverted()) }

  private predicate hasUpdate() { exists(stmt.getUpdate()) }

  override Instruction getFirstInstruction() {
    if this.hasInitialization()
    then result = this.getInitialization().getFirstInstruction()
    else result = this.getFirstConditionInstruction()
  }

  override Instruction getChildSuccessor(TranslatedElement child) {
    child = this.getInitialization() and
    result = this.getFirstConditionInstruction()
    or
    (
      child = this.getBody() and
      if this.hasUpdate()
      then result = this.getUpdate().getFirstInstruction()
      else result = this.getFirstConditionInstruction()
    )
    or
    child = this.getUpdate() and result = this.getFirstConditionInstruction()
  }
}

/**
 * The IR translation of a range-based `for` loop.
 * Note that this class does not extend `TranslatedLoop`. This is because the "body" of the
 * range-based `for` loop consists of the per-iteration variable declaration followed by the
 * user-written body statement. It is easier to handle the control flow of the loop separately,
 * rather than synthesizing a single body or complicating the interface of `TranslatedLoop`.
 */
class TranslatedRangeBasedForStmt extends TranslatedStmt, ConditionContext {
  override RangeBasedForStmt stmt;

  override TranslatedElement getChild(int id) {
    id = 0 and result = this.getRangeVariableDeclStmt()
    or
    // Note: `__begin` and `__end` are declared by the same `DeclStmt`
    id = 1 and result = this.getBeginEndVariableDeclStmt()
    or
    id = 2 and result = this.getCondition()
    or
    id = 3 and result = this.getUpdate()
    or
    id = 4 and result = this.getVariableDeclStmt()
    or
    id = 5 and result = this.getBody()
  }

  override Instruction getFirstInstruction() {
    result = this.getRangeVariableDeclStmt().getFirstInstruction()
  }

  override Instruction getChildSuccessor(TranslatedElement child) {
    child = this.getRangeVariableDeclStmt() and
    result = this.getBeginEndVariableDeclStmt().getFirstInstruction()
    or
    child = this.getBeginEndVariableDeclStmt() and
    result = this.getCondition().getFirstInstruction()
    or
    child = this.getVariableDeclStmt() and
    result = this.getBody().getFirstInstruction()
    or
    child = this.getBody() and
    result = this.getUpdate().getFirstInstruction()
    or
    child = this.getUpdate() and
    result = this.getCondition().getFirstInstruction()
  }

  override predicate hasInstruction(Opcode opcode, InstructionTag tag, CppType resultType) {
    none()
  }

  override Instruction getInstructionSuccessor(InstructionTag tag, EdgeKind kind) { none() }

  override Instruction getChildTrueSuccessor(TranslatedCondition child) {
    child = this.getCondition() and result = this.getVariableDeclStmt().getFirstInstruction()
  }

  override Instruction getChildFalseSuccessor(TranslatedCondition child) {
    child = this.getCondition() and result = this.getParent().getChildSuccessor(this)
  }

  private TranslatedDeclStmt getRangeVariableDeclStmt() {
    exists(IRVariableDeclarationEntry entry |
      entry.getDeclaration() = stmt.getRangeVariable() and
      result.getAnIRDeclarationEntry() = entry
    )
  }

  private TranslatedDeclStmt getBeginEndVariableDeclStmt() {
    exists(IRVariableDeclarationEntry entry |
      entry.getStmt() = stmt.getBeginEndDeclaration() and
      result.getAnIRDeclarationEntry() = entry
    )
  }

  // Public for getInstructionBackEdgeSuccessor
  final TranslatedCondition getCondition() {
    result = getTranslatedCondition(stmt.getCondition().getFullyConverted())
  }

  // Public for getInstructionBackEdgeSuccessor
  final TranslatedExpr getUpdate() {
    result = getTranslatedExpr(stmt.getUpdate().getFullyConverted())
  }

  private TranslatedDeclStmt getVariableDeclStmt() {
    exists(IRVariableDeclarationEntry entry |
      entry.getDeclaration() = stmt.getVariable() and
      result.getAnIRDeclarationEntry() = entry
    )
  }

  private TranslatedStmt getBody() { result = getTranslatedStmt(stmt.getStmt()) }
}

class TranslatedJumpStmt extends TranslatedStmt {
  override JumpStmt stmt;

  override Instruction getFirstInstruction() { result = this.getInstruction(OnlyInstructionTag()) }

  override TranslatedElement getChild(int id) { none() }

  override predicate hasInstruction(Opcode opcode, InstructionTag tag, CppType resultType) {
    tag = OnlyInstructionTag() and
    opcode instanceof Opcode::NoOp and
    resultType = getVoidType()
  }

  override Instruction getInstructionSuccessor(InstructionTag tag, EdgeKind kind) {
    tag = OnlyInstructionTag() and
    kind instanceof GotoEdge and
    result = getTranslatedStmt(stmt.getTarget()).getFirstInstruction()
  }

  override Instruction getChildSuccessor(TranslatedElement child) { none() }
}

private EdgeKind getCaseEdge(SwitchCase switchCase) {
  exists(CaseEdge edge |
    result = edge and
    hasCaseEdge(switchCase, edge.getMinValue(), edge.getMaxValue())
  )
  or
  switchCase instanceof DefaultCase and result instanceof DefaultEdge
}

class TranslatedSwitchStmt extends TranslatedStmt {
  override SwitchStmt stmt;

  private TranslatedExpr getExpr() {
    result = getTranslatedExpr(stmt.getExpr().getFullyConverted())
  }

  private Instruction getFirstExprInstruction() { result = this.getExpr().getFirstInstruction() }

  private TranslatedStmt getBody() { result = getTranslatedStmt(stmt.getStmt()) }

  override Instruction getFirstInstruction() {
    if this.hasInitialization()
    then result = this.getInitialization().getFirstInstruction()
    else result = this.getFirstExprInstruction()
  }

  override TranslatedElement getChild(int id) {
    id = 0 and result = this.getInitialization()
    or
    id = 1 and result = this.getExpr()
    or
    id = 2 and result = this.getBody()
  }

  private predicate hasInitialization() { exists(stmt.getInitialization()) }

  private TranslatedStmt getInitialization() {
    result = getTranslatedStmt(stmt.getInitialization())
  }

  override predicate hasInstruction(Opcode opcode, InstructionTag tag, CppType resultType) {
    tag = SwitchBranchTag() and
    opcode instanceof Opcode::Switch and
    resultType = getVoidType()
  }

  override Instruction getInstructionRegisterOperand(InstructionTag tag, OperandTag operandTag) {
    tag = SwitchBranchTag() and
    operandTag instanceof ConditionOperandTag and
    result = this.getExpr().getResult()
  }

  override Instruction getInstructionSuccessor(InstructionTag tag, EdgeKind kind) {
    tag = SwitchBranchTag() and
    exists(SwitchCase switchCase |
      switchCase = stmt.getASwitchCase() and
      kind = getCaseEdge(switchCase) and
      result = getTranslatedStmt(switchCase).getFirstInstruction()
    )
    or
    not stmt.hasDefaultCase() and
    tag = SwitchBranchTag() and
    kind instanceof DefaultEdge and
    result = this.getParent().getChildSuccessor(this)
  }

  override Instruction getChildSuccessor(TranslatedElement child) {
    child = this.getInitialization() and result = this.getFirstExprInstruction()
    or
    child = this.getExpr() and result = this.getInstruction(SwitchBranchTag())
    or
    child = this.getBody() and result = this.getParent().getChildSuccessor(this)
  }
}

class TranslatedAsmStmt extends TranslatedStmt {
  override AsmStmt stmt;

  override TranslatedExpr getChild(int id) {
    result = getTranslatedExpr(stmt.getChild(id).(Expr).getFullyConverted())
  }

  override Instruction getFirstInstruction() {
    if exists(this.getChild(0))
    then result = this.getChild(0).getFirstInstruction()
    else result = this.getInstruction(AsmTag())
  }

  override predicate hasInstruction(Opcode opcode, InstructionTag tag, CppType resultType) {
    tag = AsmTag() and
    opcode instanceof Opcode::InlineAsm and
    resultType = getUnknownType()
  }

  override Instruction getInstructionRegisterOperand(InstructionTag tag, OperandTag operandTag) {
    exists(int index |
      tag = AsmTag() and
      operandTag = asmOperand(index) and
      result = this.getChild(index).getResult()
    )
  }

  final override CppType getInstructionMemoryOperandType(
    InstructionTag tag, TypedOperandTag operandTag
  ) {
    tag = AsmTag() and
    operandTag instanceof SideEffectOperandTag and
    result = getUnknownType()
  }

  override Instruction getInstructionSuccessor(InstructionTag tag, EdgeKind kind) {
    tag = AsmTag() and
    result = this.getParent().getChildSuccessor(this) and
    kind instanceof GotoEdge
  }

  override Instruction getChildSuccessor(TranslatedElement child) {
    exists(int index |
      child = this.getChild(index) and
      if exists(this.getChild(index + 1))
      then result = this.getChild(index + 1).getFirstInstruction()
      else result = this.getInstruction(AsmTag())
    )
  }
}

class TranslatedVlaDimensionStmt extends TranslatedStmt {
  override VlaDimensionStmt stmt;

  override TranslatedExpr getChild(int id) {
    id = 0 and
    result = getTranslatedExpr(stmt.getDimensionExpr().getFullyConverted())
  }

  override Instruction getFirstInstruction() { result = this.getChild(0).getFirstInstruction() }

  override predicate hasInstruction(Opcode opcode, InstructionTag tag, CppType resultType) {
    none()
  }

  override Instruction getInstructionSuccessor(InstructionTag tag, EdgeKind kind) { none() }

  override Instruction getChildSuccessor(TranslatedElement child) {
    child = this.getChild(0) and
    result = this.getParent().getChildSuccessor(this)
  }
}

class TranslatedVlaDeclarationStmt extends TranslatedStmt {
  override VlaDeclStmt stmt;

  override TranslatedExpr getChild(int id) { none() }

  override Instruction getFirstInstruction() { result = this.getInstruction(OnlyInstructionTag()) }

  override predicate hasInstruction(Opcode opcode, InstructionTag tag, CppType resultType) {
    // TODO: This needs a new kind of instruction that represents initialization of a VLA.
    // For now we just emit a `NoOp` instruction so that the CFG isn't incomplete.
    tag = OnlyInstructionTag() and
    opcode instanceof Opcode::NoOp and
    resultType = getVoidType()
  }

  override Instruction getInstructionSuccessor(InstructionTag tag, EdgeKind kind) {
    tag = OnlyInstructionTag() and
    result = this.getParent().getChildSuccessor(this) and
    kind instanceof GotoEdge
  }

  override Instruction getChildSuccessor(TranslatedElement child) { none() }
}