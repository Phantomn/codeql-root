// Code generated by depstubber. DO NOT EDIT.
// This is a simple stub for gopkg.in/ldap.v2, strictly for use in testing.

// See the LICENSE file for information about the licensing of the original library.
// Source: gopkg.in/ldap.v2 (exports: ; functions: ScopeWholeSubtree,NeverDerefAliases,NewSearchRequest,EscapeFilter)

// Package ldap is a stub of gopkg.in/ldap.v2, generated by depstubber.
package ldap

type Control interface {
	Encode() interface{}
	GetControlType() string
	String() string
}

func EscapeFilter(_ string) string {
	return ""
}

var NeverDerefAliases int = 0

func NewSearchRequest(_ string, _ int, _ int, _ int, _ int, _ bool, _ string, _ []string, _ []Control) *SearchRequest {
	return nil
}

var ScopeWholeSubtree int = 0

type SearchRequest struct {
	BaseDN       string
	Scope        int
	DerefAliases int
	SizeLimit    int
	TimeLimit    int
	TypesOnly    bool
	Filter       string
	Attributes   []string
	Controls     []Control
}