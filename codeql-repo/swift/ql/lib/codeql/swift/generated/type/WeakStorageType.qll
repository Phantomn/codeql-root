// generated by codegen/codegen.py
/**
 * This module provides the generated definition of `WeakStorageType`.
 * INTERNAL: Do not import directly.
 */

private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.type.ReferenceStorageType

module Generated {
  /**
   * INTERNAL: Do not reference the `Generated::WeakStorageType` class directly.
   * Use the subclass `WeakStorageType`, where the following predicates are available.
   */
  class WeakStorageType extends Synth::TWeakStorageType, ReferenceStorageType {
    override string getAPrimaryQlClass() { result = "WeakStorageType" }
  }
}