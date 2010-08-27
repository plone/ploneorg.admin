The plone.org website
=====================

One of the main responsibilities of the Plone.org admins team is to keep the plone.org
website running smoothly. This includes the deployment of frequent "dot releases",
major upgrades (e.g. Plone 3 → Plone 4), and monitoring system performance.

Development
-----------

To get started, you should familiarize yourself with the combined buildout and policy 
product located here: http://dev.plone.org/plone/browser/Products.PloneOrg/trunk.

To develop locally, follow these steps::

    $ svn co https://svn.plone.org/svn/plone/Products.PloneOrg/trunk Products.PloneOrg
    $ python2.4 bootstrap.py
    $ bin/buildout
    $ bin/instance fg

Issues
------

You can find a list of things that need to be fixed here::

    https://dev.plone.org/plone.org/report/1

Deployment
----------

You will need core developer access to commit your changes to the PloneOrg package. You 
can read about that here: http://plone.org/documentation/manual/plone-core-developer-reference/overview/contributing.

Contact the `admins team`_ or join #plone.org on irc.freenode.net to discuss deployment of
your changes!

If you are an admin, you can deploy changes like this::

    $ ssh plone.org
    $ cd /srv/plone.org
    $ sudo -u zope svn up
    $ sudo -u zope bin/buildout -c production.cfg

Then restart the instances as instructed below.

Restarting
----------

If you are a member of the admins team, you may be occassionaly asked to restart the instances.
To do that, you can use the following commands::

    $ ssh plone.org
    $ cd /usr/local
    $ sudo -u zope bin/supervisorctl restart plone.org-client-{1,2,3,4}
    $ sleep 60 
    $ sudo -u zope bin/supervisorctl restart plone.org-client-{5,6,7,8}

Other services
--------------

Some services are not included in the buildout, including:

- Varnish
- NGINX
- Pound
- LDAP
- Postfix

Generally speaking, these services are controlled "BSD-style" and are located in /usr/local.
So for example to restart nginx, you can do the following::

    $ /usr/local/etc/rc.d restart nginx

Note the configuration files for some of these services are version controlled, e.g.
http://svn.plone.org/svn/plone/plone01-nginx/trunk/.

Ideally, all configuration files of interest will be added to our version control
system. The next likely targets for inclusion are Varnish and Pound.

.. _`admins team`: mailto:admins@lists.plone.org
