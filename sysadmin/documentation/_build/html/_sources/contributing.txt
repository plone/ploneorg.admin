Contributing to this documentation 
==================================

Contributing to this documentation is easy, just follow these steps*:

1. Install Sphinx_.

.. _Sphinx: http://pypi.python.org/pypi/Sphinx

2. Check out the documentation::

    $ svn co https://svn.plone.org/svn/plone/sysadmin/trunk plone-admin

3. Change directories to the documentation directory::

    $ cd plone-admin/documentation

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
    $ cd /srv/admin.plone.org/http/root
    $ svn up

(*) You will need core contributor access, you can read about that here
    http://plone.org/documentation/manual/plone-core-developer-reference/overview/contributing.

(**) If you don't have access to deus.plone.org, please send email to admins@lists.plone.org.
