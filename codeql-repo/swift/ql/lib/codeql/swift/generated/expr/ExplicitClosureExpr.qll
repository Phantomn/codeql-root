// generated by codegen/codegen.py
/**
 * This module provides the generated definition of `ExplicitClosureExpr`.
 * INTERNAL: Do not import directly.
 */

private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.ClosureExpr

module Generated {
  /**
   * INTERNAL: Do not reference the `Generated::ExplicitClosureExpr` class directly.
   * Use the subclass `ExplicitClosureExpr`, where the following predicates are available.
   */
  class ExplicitClosureExpr extends Synth::TExplicitClosureExpr, ClosureExpr {
    override string getAPrimaryQlClass() { result = "ExplicitClosureExpr" }
  }
}