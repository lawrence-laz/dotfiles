# null object design pattern

A default object to have instead of `null` values.
The context must be suitable not to fail and cause unwanted side effects from using some default values like `"Unknown"`.
This is compatible with C# nullable projects, because the more you use this pattern the less nullable references `?` you have and less checks to be done.

 - Null object can either share a common interface or inherit from the target class.

