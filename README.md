zefram0
=======

Tuned down version of Zefram. Go compiler only, mostly C syntax, fixed size integer types.


Goals
-----

 * No undefined behavior.
 * No counterintuitive behavior.
 * No failures that can be avoided.
 * Automatic runtime checks where needed.
 * Similarity to C.
 
Non-goals
---------
 * Performance
   * If you need something to be very fast, you can write it in C.
 * Deep static analysis
   * Original Zefram is being written especially with static analysis in mind;
     this spin-off, however, comes with understanding that proper provability restricts a lot,
     and explores a more runtime approach to safety.

Packages
--------

	

Type syntax
-----------

	

Syntax
------
Statement and expression syntax is almost identical to that of C. The main difference
is in the declaration syntax, introduction of packages, and slightly different semantics.

Differences from C include:
 * Evaluation ordering. The order of evaluation of subexpressions is defined to be
   the same as the order in which the expression appear in program text, except for some obvious exceptions.
 * Newer versions of the C standard include keywords of the form "_Bool". Zefram0 also includes
   the "simple" forms (i.e. "bool") as keywords.
 * "null" is a keyword and means what you think it means (for most practical purposes, anyway).
 * Signed overflows are "toxic".
   They result in a "toxic" value that contaminates any value it touches, but can also be checked
   for. The same is true for integer division by zero and any other operation whose semantics
   cannot be intuitively extended.
 * 
