// generated by codegen/codegen.py
/**
 * This module provides the generated definition of `UnresolvedSpecializeExpr`.
 * INTERNAL: Do not import directly.
 */

private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.ErrorElement
import codeql.swift.elements.expr.Expr

module Generated {
  /**
   * INTERNAL: Do not reference the `Generated::UnresolvedSpecializeExpr` class directly.
   * Use the subclass `UnresolvedSpecializeExpr`, where the following predicates are available.
   */
  class UnresolvedSpecializeExpr extends Synth::TUnresolvedSpecializeExpr, Expr, ErrorElement {
    override string getAPrimaryQlClass() { result = "UnresolvedSpecializeExpr" }

    /**
     * Gets the sub expression of this unresolved specialize expression.
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behavior of both the `Immediate` and non-`Immediate` versions.
     */
    Expr getImmediateSubExpr() {
      result =
        Synth::convertExprFromRaw(Synth::convertUnresolvedSpecializeExprToRaw(this)
              .(Raw::UnresolvedSpecializeExpr)
              .getSubExpr())
    }

    /**
     * Gets the sub expression of this unresolved specialize expression.
     */
    final Expr getSubExpr() {
      exists(Expr immediate |
        immediate = this.getImmediateSubExpr() and
        if exists(this.getResolveStep()) then result = immediate else result = immediate.resolve()
      )
    }
  }
}