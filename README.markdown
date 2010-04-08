#CocoaLinear

CocoaLinear is a small linear algebra library aimed at Mac OS X and iPhone applications.  It is written in C and is mostly independent of Cocoa, but does include functions for converting to and from Core Graphics and Core Animation types.

#Installation

Just add the files in the `CocoaLinear` directory to your XCode project.  

The other files included are for unit testing only.  To run those tests, navigate to the root directory and run `make test`.  You'll need to have iPhone SDK 3.0 or later installed.

#Notes

This project includes source from [GHUnit](http://github.com/gabriel/gh-unit), a delightful test framework.