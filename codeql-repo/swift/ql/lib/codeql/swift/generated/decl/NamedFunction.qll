// generated by codegen/codegen.py
/**
 * This module provides the generated definition of `NamedFunction`.
 * INTERNAL: Do not import directly.
 */

private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.decl.AccessorOrNamedFunction

module Generated {
  /**
   * INTERNAL: Do not reference the `Generated::NamedFunction` class directly.
   * Use the subclass `NamedFunction`, where the following predicates are available.
   */
  class NamedFunction extends Synth::TNamedFunction, AccessorOrNamedFunction {
    override string getAPrimaryQlClass() { result = "NamedFunction" }
  }
}
