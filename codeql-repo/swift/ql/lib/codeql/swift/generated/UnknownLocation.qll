// generated by codegen/codegen.py
/**
 * This module provides the generated definition of `UnknownLocation`.
 * INTERNAL: Do not import directly.
 */

private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.Location

module Generated {
  /**
   * INTERNAL: Do not reference the `Generated::UnknownLocation` class directly.
   * Use the subclass `UnknownLocation`, where the following predicates are available.
   */
  class UnknownLocation extends Synth::TUnknownLocation, Location {
    override string getAPrimaryQlClass() { result = "UnknownLocation" }
  }
}