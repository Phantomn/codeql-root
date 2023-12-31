.. _specifying-additional-remote-flow-sources-for-javascript:

Specifying additional remote flow sources for JavaScript
========================================================

.. pull-quote::

   Deprecation Notice

   Specifying remote flow sources with the JSON format described here is soon to be deprecated
   and will be removed in the future.

You can model potential sources of untrusted user input in your code without making changes to the CodeQL standard library by specifying extra remote flow sources in an external file.

As mentioned in the :ref:`Data flow cheat sheet for JavaScript <data-flow-cheat-sheet-for-javascript--untrusted-data>`, the CodeQL libraries for JavaScript
provide a class `RemoteFlowSource <https://codeql.github.com/codeql-standard-libraries/javascript/semmle/javascript/security/dataflow/RemoteFlowSources.qll/type.RemoteFlowSources$Cached$RemoteFlowSource.html>`__ to represent sources of untrusted user input, sometimes also referred to as remote flow
sources.

To model a new source of untrusted input, such as a previously unmodelled library API, you can
define a subclass of ``RemoteFlowSource`` that covers all uses of that API. All standard analyses
will then automatically pick up this new source of remote flow.

However, this approach requires writing QL code and adding it to the standard library, which is not
always easy to do. Instead, you can also add a JSON file describing custom sources of untrusted
input to your code base and have it picked up without needing to modify the standard library. This
JSON file can be hand-written or generated by another tool. The custom remote flow sources are only available to the code base containing the JSON file. This means that you need to copy the JSON file into each code base that requires the customizations.

Specification format
--------------------

The JSON file must be called ``codeql-javascript-remote-flow-sources.json`` and
can be located anywhere in your code base. It should consist of a single JSON object. The property
names of this object are interpreted as `source types`. The values they map to should be arrays of
strings. Each string should be of the form ``window.props``, where ``props`` is a sequence of one
or more property names separated by dots. This notation specifies that any value reachable from the global window
object by this sequence of property names should be considered as untrusted user input of the
associated source type.

Example
-------

Consider the following specification:

.. code-block:: json

  {
    "user input": [ "window.user.name", "window.user.address", "window.dob" ]
  }

It declares that the contents of global variable ``dob``, as well as the contents of properties
``name`` and ``address`` of global variable ``user``, should be considered as remote flow sources,
with source type "user input".
