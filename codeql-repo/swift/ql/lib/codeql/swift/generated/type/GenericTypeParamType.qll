// generated by codegen/codegen.py
/**
 * This module provides the generated definition of `GenericTypeParamType`.
 * INTERNAL: Do not import directly.
 */

private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.type.SubstitutableType

module Generated {
  /**
   * INTERNAL: Do not reference the `Generated::GenericTypeParamType` class directly.
   * Use the subclass `GenericTypeParamType`, where the following predicates are available.
   */
  class GenericTypeParamType extends Synth::TGenericTypeParamType, SubstitutableType {
    override string getAPrimaryQlClass() { result = "GenericTypeParamType" }
  }
}