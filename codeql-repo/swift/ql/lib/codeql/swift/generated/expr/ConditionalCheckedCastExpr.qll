// generated by codegen/codegen.py
/**
 * This module provides the generated definition of `ConditionalCheckedCastExpr`.
 * INTERNAL: Do not import directly.
 */

private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.CheckedCastExpr

module Generated {
  /**
   * INTERNAL: Do not reference the `Generated::ConditionalCheckedCastExpr` class directly.
   * Use the subclass `ConditionalCheckedCastExpr`, where the following predicates are available.
   */
  class ConditionalCheckedCastExpr extends Synth::TConditionalCheckedCastExpr, CheckedCastExpr {
    override string getAPrimaryQlClass() { result = "ConditionalCheckedCastExpr" }
  }
}