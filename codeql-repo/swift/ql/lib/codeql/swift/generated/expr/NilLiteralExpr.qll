// generated by codegen/codegen.py
/**
 * This module provides the generated definition of `NilLiteralExpr`.
 * INTERNAL: Do not import directly.
 */

private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.LiteralExpr

module Generated {
  /**
   * INTERNAL: Do not reference the `Generated::NilLiteralExpr` class directly.
   * Use the subclass `NilLiteralExpr`, where the following predicates are available.
   */
  class NilLiteralExpr extends Synth::TNilLiteralExpr, LiteralExpr {
    override string getAPrimaryQlClass() { result = "NilLiteralExpr" }
  }
}