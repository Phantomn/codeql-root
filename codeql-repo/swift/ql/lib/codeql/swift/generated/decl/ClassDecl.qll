// generated by codegen/codegen.py
/**
 * This module provides the generated definition of `ClassDecl`.
 * INTERNAL: Do not import directly.
 */

private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.decl.NominalTypeDecl

module Generated {
  /**
   * INTERNAL: Do not reference the `Generated::ClassDecl` class directly.
   * Use the subclass `ClassDecl`, where the following predicates are available.
   */
  class ClassDecl extends Synth::TClassDecl, NominalTypeDecl {
    override string getAPrimaryQlClass() { result = "ClassDecl" }
  }
}