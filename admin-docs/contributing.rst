Contributing to this documentation 
==================================

The source for this documentation is here:

* https://github.com/plone/admin-docs

Contributing is easy. Just follow these steps:

* Install Sphinx_.

* Check out the documentation::

    $ git clone git@github.com:plone/admin-docs.git

* Change directories:: 

    $ cd admin-docs

* Make your changes. (You may need to read the `Sphinx docs`_ or
  `reStructuredText docs`_.)

* Build the html::

    $ make html

* Commit your changes::

    $ git commit -a -m 'Added documentation to make the world a better place'

* Push the change to github::

    $ git push

* The change should be automatically deployed to
  http://plone-admin-docs.readthedocs.org/en/latest/index.html

To follow the above steps, you will need core contributor access, which you
can read about at http://plone.org/foundation/contributors-agreement/contributors-agreement-explained/.

If you don't have commit access, you can also fork the repository and
make a pull request.

.. _Sphinx: http://pypi.python.org/pypi/Sphinx
.. _`Sphinx docs`: http://sphinx.pocoo.org/
.. _`reStructuredText docs`: http://docutils.sourceforge.net/rst.html
