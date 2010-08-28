
Planet
======

The Plone planet (http://planet.plone.org) aggregates feeds of various community members for the enjoyment of all.


Details
-------

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

