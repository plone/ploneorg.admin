Contributing to this documentation 
==================================

Contributing to this documentation is easy. Just follow these steps:

* Install Sphinx_.

* Check out the documentation::

    $ svn co https://svn.plone.org/svn/plone/plone.org/admin-docs/trunk admin-docs

* Change directories:: 

    $ cd admin-docs

* Make your changes. If you don't know Sphinx or reStructuredText yet, you can read about them respectively here_, `and here`_.

* Build the html::

    $ make html

* Commit your changes::

    $ svn commit -m 'Added documentation to make the world a better place'

* Login to deus.plone.org to synchronize your changes**::

    $ ssh deus.plone.org
    $ cd /srv/admin.plone.org
    $ sudo svn up
    $ sudo make html

You will need core contributor access, you can read about that here: http://dev.plone.org/plone/. If you don't have access to deus.plone.org, please send a request to admins@plone.org.

.. _Sphinx: http://pypi.python.org/pypi/Sphinx
.. _here: http://sphinx.pocoo.org/
.. _`and here`: http://docutils.sourceforge.net/rst.html
