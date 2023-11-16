// Code generated by depstubber. DO NOT EDIT.
// This is a simple stub for k8s.io/api/core/v1, strictly for use in testing.

// See the LICENSE file for information about the licensing of the original library.
// Source: k8s.io/api/core/v1 (exports: SecretList; functions: )

// Package core is a stub of k8s.io/api/core/v1, generated by depstubber.
package core

import ()

type Secret struct {
	TypeMeta   interface{}
	ObjectMeta interface{}
	Immutable  *bool
	Data       map[string][]byte
	StringData map[string]string
	Type       SecretType
}

func (_ Secret) SwaggerDoc() map[string]string {
	return nil
}

func (_ *Secret) DeepCopy() *Secret {
	return nil
}

func (_ *Secret) DeepCopyInto(_ *Secret) {}

func (_ *Secret) DeepCopyObject() interface{} {
	return nil
}

func (_ *Secret) Descriptor() ([]byte, []int) {
	return nil, nil
}

func (_ *Secret) GetAnnotations() map[string]string {
	return nil
}

func (_ *Secret) GetClusterName() string {
	return ""
}

func (_ *Secret) GetCreationTimestamp() interface{} {
	return nil
}

func (_ *Secret) GetDeletionGracePeriodSeconds() *int64 {
	return nil
}

func (_ *Secret) GetDeletionTimestamp() interface{} {
	return nil
}

func (_ *Secret) GetFinalizers() []string {
	return nil
}

func (_ *Secret) GetGenerateName() string {
	return ""
}

func (_ *Secret) GetGeneration() int64 {
	return 0
}

func (_ *Secret) GetLabels() map[string]string {
	return nil
}

func (_ *Secret) GetManagedFields() []interface{} {
	return nil
}

func (_ *Secret) GetName() string {
	return ""
}

func (_ *Secret) GetNamespace() string {
	return ""
}

func (_ *Secret) GetObjectKind() interface{} {
	return nil
}

func (_ *Secret) GetObjectMeta() interface{} {
	return nil
}

func (_ *Secret) GetOwnerReferences() []interface{} {
	return nil
}

func (_ *Secret) GetResourceVersion() string {
	return ""
}

func (_ *Secret) GetSelfLink() string {
	return ""
}

func (_ *Secret) GetUID() interface{} {
	return nil
}

func (_ *Secret) GroupVersionKind() interface{} {
	return nil
}

func (_ *Secret) Marshal() ([]byte, error) {
	return nil, nil
}

func (_ *Secret) MarshalTo(_ []byte) (int, error) {
	return 0, nil
}

func (_ *Secret) MarshalToSizedBuffer(_ []byte) (int, error) {
	return 0, nil
}

func (_ *Secret) ProtoMessage() {}

func (_ *Secret) Reset() {}

func (_ *Secret) SetAnnotations(_ map[string]string) {}

func (_ *Secret) SetClusterName(_ string) {}

func (_ *Secret) SetCreationTimestamp(_ interface{}) {}

func (_ *Secret) SetDeletionGracePeriodSeconds(_ *int64) {}

func (_ *Secret) SetDeletionTimestamp(_ interface{}) {}

func (_ *Secret) SetFinalizers(_ []string) {}

func (_ *Secret) SetGenerateName(_ string) {}

func (_ *Secret) SetGeneration(_ int64) {}

func (_ *Secret) SetGroupVersionKind(_ interface{}) {}

func (_ *Secret) SetLabels(_ map[string]string) {}

func (_ *Secret) SetManagedFields(_ []interface{}) {}

func (_ *Secret) SetName(_ string) {}

func (_ *Secret) SetNamespace(_ string) {}

func (_ *Secret) SetOwnerReferences(_ []interface{}) {}

func (_ *Secret) SetResourceVersion(_ string) {}

func (_ *Secret) SetSelfLink(_ string) {}

func (_ *Secret) SetUID(_ interface{}) {}

func (_ *Secret) Size() int {
	return 0
}

func (_ *Secret) String() string {
	return ""
}

func (_ *Secret) Unmarshal(_ []byte) error {
	return nil
}

func (_ *Secret) XXX_DiscardUnknown() {}

func (_ *Secret) XXX_Marshal(_ []byte, _ bool) ([]byte, error) {
	return nil, nil
}

func (_ *Secret) XXX_Merge(_ interface{}) {}

func (_ *Secret) XXX_Size() int {
	return 0
}

func (_ *Secret) XXX_Unmarshal(_ []byte) error {
	return nil
}

type SecretList struct {
	TypeMeta interface{}
	ListMeta interface{}
	Items    []Secret
}

func (_ SecretList) SwaggerDoc() map[string]string {
	return nil
}

func (_ *SecretList) DeepCopy() *SecretList {
	return nil
}

func (_ *SecretList) DeepCopyInto(_ *SecretList) {}

func (_ *SecretList) DeepCopyObject() interface{} {
	return nil
}

func (_ *SecretList) Descriptor() ([]byte, []int) {
	return nil, nil
}

func (_ *SecretList) GetContinue() string {
	return ""
}

func (_ *SecretList) GetListMeta() interface{} {
	return nil
}

func (_ *SecretList) GetObjectKind() interface{} {
	return nil
}

func (_ *SecretList) GetRemainingItemCount() *int64 {
	return nil
}

func (_ *SecretList) GetResourceVersion() string {
	return ""
}

func (_ *SecretList) GetSelfLink() string {
	return ""
}

func (_ *SecretList) GroupVersionKind() interface{} {
	return nil
}

func (_ *SecretList) Marshal() ([]byte, error) {
	return nil, nil
}

func (_ *SecretList) MarshalTo(_ []byte) (int, error) {
	return 0, nil
}

func (_ *SecretList) MarshalToSizedBuffer(_ []byte) (int, error) {
	return 0, nil
}

func (_ *SecretList) ProtoMessage() {}

func (_ *SecretList) Reset() {}

func (_ *SecretList) SetContinue(_ string) {}

func (_ *SecretList) SetGroupVersionKind(_ interface{}) {}

func (_ *SecretList) SetRemainingItemCount(_ *int64) {}

func (_ *SecretList) SetResourceVersion(_ string) {}

func (_ *SecretList) SetSelfLink(_ string) {}

func (_ *SecretList) Size() int {
	return 0
}

func (_ *SecretList) String() string {
	return ""
}

func (_ *SecretList) Unmarshal(_ []byte) error {
	return nil
}

func (_ *SecretList) XXX_DiscardUnknown() {}

func (_ *SecretList) XXX_Marshal(_ []byte, _ bool) ([]byte, error) {
	return nil, nil
}

func (_ *SecretList) XXX_Merge(_ interface{}) {}

func (_ *SecretList) XXX_Size() int {
	return 0
}

func (_ *SecretList) XXX_Unmarshal(_ []byte) error {
	return nil
}

type SecretType string
