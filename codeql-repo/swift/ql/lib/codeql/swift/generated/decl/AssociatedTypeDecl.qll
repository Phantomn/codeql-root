// generated by codegen/codegen.py
/**
 * This module provides the generated definition of `AssociatedTypeDecl`.
 * INTERNAL: Do not import directly.
 */

private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.decl.AbstractTypeParamDecl

module Generated {
  /**
   * INTERNAL: Do not reference the `Generated::AssociatedTypeDecl` class directly.
   * Use the subclass `AssociatedTypeDecl`, where the following predicates are available.
   */
  class AssociatedTypeDecl extends Synth::TAssociatedTypeDecl, AbstractTypeParamDecl {
    override string getAPrimaryQlClass() { result = "AssociatedTypeDecl" }
  }
}