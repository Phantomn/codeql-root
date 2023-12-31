/**
 * @name Test for fields
 */

import csharp

from Field f
where
  f.getName() = "Y" and
  f.getDeclaringType().hasFullyQualifiedName("Fields", "B") and
  f.getType() instanceof IntType and
  not exists(f.getInitializer()) and
  f.isPublic() and
  f.isStatic()
select f, f.getType().toString()
