
Services
========

These are (some of) the services that the Plone.org infrastructure team is currently responsible for:

Plone.org
---------

One of the main responsibilities of the Plone.org admins team is to keep the plone.org
website running smoothly. This includes the deployment of frequent "dot releases",
major upgrades (e.g. Plone 3 → Plone 4), and monitoring system performance.

Development
~~~~~~~~~~~

To get started, you should familiarize yourself with the combined buildout and policy 
product located here: http://dev.plone.org/plone/browser/Products.PloneOrg/trunk.

To develop locally, follow these steps::

    $ svn co https://svn.plone.org/svn/plone/Products.PloneOrg/trunk Products.PloneOrg
    $ python2.4 bootstrap.py
    $ bin/buildout
    $ bin/instance fg

Issues
~~~~~~

You can find a list of things that need to be fixed here::

    https://dev.plone.org/plone.org/report/1

Deployment
~~~~~~~~~~

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
~~~~~~~~~~

If you are a member of the admins team, you may be occassionaly asked to restart the instances.
To do that, you can use the following commands::

    $ ssh plone.org
    $ cd /usr/local
    $ sudo -u zope bin/supervisorctl restart plone.org-client-{1,2,3,4}
    $ sleep 60 
    $ sudo -u zope bin/supervisorctl restart plone.org-client-{5,6,7,8}

Other services
~~~~~~~~~~~~~~

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

Mailman
-------

These are the details of the Mailman service running on aneka.plone.org (CNAME lists.plone.org).

Specs
~~~~~

- Version = 2.1.6 (source build) 
- Location = /srv/lists.plone.org/mailman
- Path = /Applications/mailman (symlinked Applications = /srv/lists.plone.org)

Notes
~~~~~

Mailman was built from source due to the need to pass selected parameters on install. The original location on dues was copied on the aneka install and on the original the libs and archives where symlinked as well, the newer install uses the same method symlinking from the server release location to /Applications/mailman/archives/

The path is /Applications symlinked as that was what was most convenient to use at the time due to the person migrating it using that path on there own system.

Postfix
-------

Specs
~~~~~

- Postfix: Version = 2.3.8 
- Location = /usr/lib/postfix 
- relay domains = lists.plone.org 
- Allowed domains = aneka.plone.org, localhost.plone.org, localhost
- Spamassassin: Version = 3.2.3 
- Perl version = 5.8.8

Notes
~~~~~

Spamassassin is using Bayes system rules with a current score of 5.0 – at the moment it delivers the mail marked as spam so a judgement can be made on if it is spam or not until a good balance in terms of scoring has been found, they can then be temporarily stored in a separate mailbox or discarded automatically.

Subversion
----------

The Plone.org admins are responsible for the management of the following
repositories:

- https://svn.plone.org/svn/archetypes
- https://svn.plone.org/svn/collective
- https://svn.plone.org/svn/foundation
- https://svn.plone.org/svn/plone

Servers
~~~~~~~

The primary server is OSU's deus.plone.org with a mirror to XS4ALL's 
antiloop.plone.org.

Users
~~~~~

The repositories are owned by the ``www-data`` user.

Mirroring
~~~~~~~~~

In /etc/cron.hourly on deus we have::

    #!/bin/sh

    LOCKFILE=/var/lock/cron.svn-mirror

    if [ -x /usr/bin/lockfile-create ] ; then
        lockfile-create $LOCKFILE
        if [ $? -ne 0 ] ; then
            cat <<EOF

    Unable to run /etc/cron.daily/svn-mirror because lockfile $LOCKFILE
    acquisition failed. This probably means that the previous day's
    instance is still running. Please check and correct if necessary.

    EOF
            exit 1
        fi

        # Keep lockfile fresh
        lockfile-touch $LOCKFILE &
        LOCKTOUCHPID="$!"
    fi

    for repo in archetypes plone collective ; do
            su www-data -c "svnsync sync https://svn-mirror.plone.org/svn/$repo --non-interactive" > /dev/null
    done

    if [ -x /usr/bin/lockfile-create ] ; then
        kill $LOCKTOUCHPID
        lockfile-remove $LOCKFILE
    fi

Troubleshooting
~~~~~~~~~~~~~~~

Occasionally when running svnsync on ``deus`` you may get an error like this::

    Failed to get lock on destination repos…

At which point running the following command should help::

    svn pdel --revprop -r 0 svn:sync-lock https://svn-mirror.plone.org/svn/<repo>

Hudson
------

Hudson provides continuous integration services for the Plone core software.

Details
~~~~~~~

- Available via https://hudson.plone.org. 
    - sites-enabled directory contents managed in svn (http://svn.plone.org/svn/plone/muse-apache/trunk/hudson-ssl)

- "Installed" in /srv/hudson (which means that is where hudson.war lives).

- Run via OS vendor installed supervisor
    - conf.d directory contents managed in svn (http://svn.plone.org/svn/plone/muse-supervisor/trunk/hudson.conf)

- Configured to allow core devs to login (via ldap).

Planet
------

Planet Plone (http://planet.plone.org) aggregates blog feeds of various community members to a single website, for the enjoyment of all.

Details
~~~~~~~

The Plone planet runs Venus planet software (http://intertwingly.net/code/venus/) and is installed on deus.plone.org in::

    /srv/planet.plone.org/venus/plone

Its configuration is version controlled here::

    https://svn.plone.org/svn/plone/planet/trunk

And it is updated via a cron job on deus.plone.org here::

    /etc/cron.d/planet

That file looks like this::

    # Update the planet site every 10 minutes
    MAILTO=admins@plone.org
    */10 * * * * planet /srv/planet.plone.org/bin/update >/dev/null 2>/dev/null

You can update it manually by running the following command on deus.plone.org as the planet user::

    $ /srv/planet.plone.org/bin/update

