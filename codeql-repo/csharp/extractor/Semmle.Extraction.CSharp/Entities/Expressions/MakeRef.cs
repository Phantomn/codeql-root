﻿using System.IO; // lgtm[cs/similar-file]
using Microsoft.CodeAnalysis.CSharp.Syntax;
using Semmle.Extraction.Kinds;

namespace Semmle.Extraction.CSharp.Entities.Expressions
{
    internal class MakeRef : Expression<MakeRefExpressionSyntax>
    {
        private MakeRef(ExpressionNodeInfo info) : base(info.SetKind(ExprKind.REF)) { }

        public static Expression Create(ExpressionNodeInfo info) => new MakeRef(info).TryPopulate();

        protected override void PopulateExpression(TextWriter trapFile)
        {
            Create(Context, Syntax.Expression, this, 0);
        }
    }
}
