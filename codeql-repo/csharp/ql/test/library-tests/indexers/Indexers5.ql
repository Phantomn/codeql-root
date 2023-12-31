/**
 * @name Test for indexers
 */

import csharp

from Indexer i
where
  i.getDeclaringType().hasFullyQualifiedName("Indexers", "BitArray") and
  i.getType() instanceof BoolType and
  i.isPublic() and
  i.isReadWrite()
select i
