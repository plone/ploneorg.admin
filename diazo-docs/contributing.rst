Contributing to this documentation 
==================================

Contributing to this documentation is easy, just follow these steps*:

1. Install Sphinx_.

.. _Sphinx: http://pypi.python.org/pypi/Sphinx

2. Check out the documentation::

    $ svn co https://svn.plone.org/svn/plone/plone.org/diazo-docs/trunk diazo-docs

3. Change directories to the documentation directory::

    $ cd diazo-docs

4. Make your changes. If you don't know Sphinx or reStructuredText, 
   you can read about them respectively here_, `and here`_.

.. _here: http://sphinx.pocoo.org/
.. _`and here`: http://docutils.sourceforge.net/rst.html

5. Build the html::

    $ make html

6. Commit your changes::

    $ svn commit -m 'Added documentation to make the world a better place'

7. Login to deus.plone.org to synchronize your changes**::

    $ ssh deus.plone.org
    $ cd /srv/diazo.org
    $ sudo svn up
    $ sudo make html

(*) You will need core contributor access, you can read about that here:

    - http://dev.plone.org/plone/

(**) If you don't have access to deus.plone.org, please send a request to admins@plone.org.

Contributing to Diazo
=====================

Diazo is maintained by the Plone project. The canonical source code
repository can be found at::

    https://svn.plone.org/svn/plone/diazo/
    
Note that commit rights require a signed Plone contributor agreement. Patches
are received with thanks.

Discussion about the development of Diazo happens mainly on the
``plone-developers`` mailing list.

If you have questions as a user of Diazo, please see http://plone.org/support.

Some important ground rules:

* Please do all new features on a branch and ask for review before
  merging.
* Keep the tests passing and write new tests (simply create a new directory
  in the ``tests/`` directory following the convention of the existing
  tests).
