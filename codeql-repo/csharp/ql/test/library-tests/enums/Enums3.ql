/**
 * @name Test for enums
 */

import csharp
import semmle.code.csharp.commons.QualifiedName

from EnumConstant c, string namespace, string name
where
  c.getName() = "Green" and
  c.getDeclaringType().hasFullyQualifiedName("Enums", "LongColor") and
  c.getType() = c.getDeclaringType() and
  c.getValue() = "1" and
  c.getDeclaringType().getBaseClass().hasFullyQualifiedName(namespace, name)
select c, getQualifiedName(namespace, name)
