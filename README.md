
## Description

A Leksah project containing the code from the following article:

* [An introduction to QuickCheck testing](https://www.fpcomplete.com/user/pbv/an-introduction-to-quickcheck-testing)

## Source code files

* StringSplitting.hs
  * a module containing the code to be tested - functions called <code>split</code> and <code>myjoin</code>
* Main.hs
  * main program to exercise <code>split</code>
* UnitTests.hs
  * unit tests to test <code>split</code> using HUnit
* PropertyTests.hs
  * property tests to test the relationship between <code>split</code> and <code>myjoin</code> using QuickCheck

## Point of Interest

The property <code>prop_join_split'</code> causes exceptions because the generated string, <code>xs</code>, may be an empty string. <code>elements</code> requires the list of elements to be non-empty.

```Haskell
prop_join_split' xs =
    forAll (elements xs) $ \c -> 
    join c (split c xs) == xs
```

The exception(s) can be seen when running the property verbosely:

```
Exception thrown by generator: 'QuickCheck.elements used with empty list'
```

We can add a condition to skip empty strings:

```Haskell
prop_join_split' xs =
	not (null xs) ==>
    forAll (elements xs) $ \c -> 
    join c (split c xs) == xs
```

## FsCheck

FsCheck is an open source port of QuickCheck to F#. It can be used to write property tests to test code written in any .NET language. Also, the property tests themselves can be written in
any .NET language. Here is a link to FsCheck:

* [FsCheck](https://github.com/fsharp/FsCheck)

I have ported the code from the above article to .NET and FsCheck. I have ported the property tests to both F# and C#. Here is a link to the repo:

* [AnIntroductionToFsCheckTesting](https://github.com/taylorjg/AnIntroductionToFsCheckTesting)
