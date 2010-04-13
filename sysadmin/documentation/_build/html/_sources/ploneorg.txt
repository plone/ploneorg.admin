The plone.org website
=====================

One of the main responsibilities of the Plone.org admins team is to keep the plone.org
website running smoothly. This includes the deployment of frequent "dot releases",
major upgrades (e.g. Plone 3 → Plone 4), and monitoring system performance.

The buildout
------------

To get started, you should familiarize yourself with the combined buildout and policy 
product here:

    https://dev.plone.org/plone/browser/Products.PloneOrg/trunk

E.g.::

    $ svn co http://svn.plone.org/svn/plone/Products.PloneOrg/trunk/
    $ python2.4 bootstrap.py
    $ bin/buildout
    $ bin/instance fg

The issues
----------

You can find a list of things that need to be fixed here:
https://dev.plone.org/plone.org/report/1

Deployment
----------

You will need core developer access to commit your changes to the PloneOrg package. You 
can read about that here:
http://plone.org/documentation/manual/plone-core-developer-reference/overview/contributing.

Contact the `admins team`_ or join #plone.org on irc.freenode.net to discuss deployment of
your changes!

.. _`admins team`: mailto:admins@plone.org

