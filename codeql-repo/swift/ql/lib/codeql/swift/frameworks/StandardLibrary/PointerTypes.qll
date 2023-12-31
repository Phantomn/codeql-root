/**
 * Provides models for Swift pointer types including `UnsafePointer`,
 * `UnsafeBufferPointer` and similar types.
 */

import swift
private import codeql.swift.dataflow.ExternalFlow

/**
 * A Swift unsafe typed pointer type such as `UnsafePointer`,
 * `UnsafeMutablePointer` or `UnsafeBufferPointer`.
 */
class UnsafeTypedPointerType extends BoundGenericType {
  UnsafeTypedPointerType() { this.getName().regexpMatch("Unsafe(Mutable|)(Buffer|)Pointer<.*") }
}

/**
 * A Swift unsafe raw pointer type such as `UnsafeRawPointer`,
 * `UnsafeMutableRawPointer` or `UnsafeRawBufferPointer`.
 */
class UnsafeRawPointerType extends NominalType {
  UnsafeRawPointerType() { this.getName().regexpMatch("Unsafe(Mutable|)Raw(Buffer|)Pointer") }
}

/**
 * A Swift `OpaquePointer`.
 */
class OpaquePointerType extends NominalType {
  OpaquePointerType() { this.getName() = "OpaquePointer" }
}

/**
 * A Swift `AutoreleasingUnsafeMutablePointer`.
 */
class AutoreleasingUnsafeMutablePointerType extends BoundGenericType {
  AutoreleasingUnsafeMutablePointerType() {
    this.getName().matches("AutoreleasingUnsafeMutablePointer<%")
  }
}

/**
 * A Swift `Unmanaged` object reference.
 */
class UnmanagedType extends BoundGenericType {
  UnmanagedType() { this.getName().matches("Unmanaged<%") }
}

/**
 * A Swift `CVaListPointer`.
 */
class CVaListPointerType extends NominalType {
  CVaListPointerType() { this.getName() = "CVaListPointer" }
}

/**
 * A Swift `ManagedBufferPointer`.
 */
class ManagedBufferPointerType extends BoundGenericType {
  ManagedBufferPointerType() { this.getName().matches("ManagedBufferPointer<%") }
}

/**
 * A model for `UnsafePointer` and related Swift class members that permit taint flow.
 */
private class PointerSummaries extends SummaryModelCsv {
  override predicate row(string row) {
    row =
      [
        ";UnsafeMutablePointer;true;init(mutating:);;;Argument[0];ReturnValue;taint",
        ";UnsafeMutableBufferPointer;true;update(repeating:);;;Argument[0];Argument[-1].CollectionElement;value",
      ]
  }
}
