# flyweight design pattern

 - intrinsic state is unchanging and can be shared between objects.
 - extrinsic state is object specific states


:question: Intrinsic and extrinsic data could have levels that would form either tree or graphh like structure. Ex. Country data is instrinsic for city, city data is intrinsic for streets, etc.

:information_source: Having properties for intrinsic state and method parameters for extrinsic state allows you to reuse same object for multiple uses. Objects can be pooled.

:question: Alternative would be to reuse intrinsic data using composition.
