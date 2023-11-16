// generated by codegen/codegen.py
/**
 * This module provides the generated definition of `ObjCSelectorExpr`.
 * INTERNAL: Do not import directly.
 */

private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.Expr
import codeql.swift.elements.decl.Function

module Generated {
  /**
   * INTERNAL: Do not reference the `Generated::ObjCSelectorExpr` class directly.
   * Use the subclass `ObjCSelectorExpr`, where the following predicates are available.
   */
  class ObjCSelectorExpr extends Synth::TObjCSelectorExpr, Expr {
    override string getAPrimaryQlClass() { result = "ObjCSelectorExpr" }

    /**
     * Gets the sub expression of this obj c selector expression.
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behavior of both the `Immediate` and non-`Immediate` versions.
     */
    Expr getImmediateSubExpr() {
      result =
        Synth::convertExprFromRaw(Synth::convertObjCSelectorExprToRaw(this)
              .(Raw::ObjCSelectorExpr)
              .getSubExpr())
    }

    /**
     * Gets the sub expression of this obj c selector expression.
     */
    final Expr getSubExpr() {
      exists(Expr immediate |
        immediate = this.getImmediateSubExpr() and
        if exists(this.getResolveStep()) then result = immediate else result = immediate.resolve()
      )
    }

    /**
     * Gets the method of this obj c selector expression.
     */
    Function getMethod() {
      result =
        Synth::convertFunctionFromRaw(Synth::convertObjCSelectorExprToRaw(this)
              .(Raw::ObjCSelectorExpr)
              .getMethod())
    }
  }
}