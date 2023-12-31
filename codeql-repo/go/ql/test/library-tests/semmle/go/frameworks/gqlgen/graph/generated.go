// Code generated by github.com/99designs/gqlgen, DO NOT EDIT.

package graph

import (
	"context"
	"pwntester/gqlgen-todos/graph/model"

	"github.com/99designs/gqlgen/graphql"
)

type ResolverRoot interface {
	Mutation() MutationResolver
	Query() QueryResolver
}

type MutationResolver interface {
	CreateTodo(ctx context.Context, input model.NewTodo) (*model.Todo, error)
}
type QueryResolver interface {
	Todos(ctx context.Context) ([]*model.Todo, error)
}

func stub(dg graphql.CollectedField) {
	dg.GetPosition()
}

// endregion ***************************** type.gotpl *****************************
