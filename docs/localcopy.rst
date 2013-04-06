Local dev copy
================

Instructions.

Clone::

    git clone git@github.com:plone/Products.PloneOrg.git

Create b.out::

    cp buildout.cfg.in buildout.cfg

Edit it::

    [buildout]
    # Rename to buildout.cfg and uncomment one of the profiles below
    extends =
    # Copy data local (with plone.org account)
        conf/database.cfg

Run buildout::

    python bootstrap.py -v 1.6.3
    bin/buildout

This will create p.org configuration and rsync cleaned ``Data.fs``
from p.org for your local computer.

TODO

TODO

Whisky and rye

