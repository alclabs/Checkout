Purpose
=======

Checkout is a very simple WebCTRL Add-On used during some checkout testing where we need simple add-ons to exercise
some of the infrastructure around deploying, starting, stopping, upgrading, and generally dealing with add-ons.

It provides:

* A text area, button and simple script which can be included in a view file to provide a simple comment field.
  The comments are saved in a datastore associated with the current location.
* Example protected and unprotected (privilege wise) sample pages
* Links from these pages back into WebCTRL

A sample view file is located in views/checkout.view
