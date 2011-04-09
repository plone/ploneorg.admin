Installation
============

To install Diazo, you should install the ``diazo`` egg. You can do that using
``easy_install``, ``pip`` or ``zc.buildout``. For example, using
``easy_install`` (ideally in a ``virtualenv``)::
    
    $ easy_install -U diazo

If using ``zc.buildout``, you can use the following ``buildout.cfg`` as a
starting point. This will ensure that the console scripts are installed,
which is important if you need to execute the Diazo compiler manually::

    [buildout]
    parts =
        diazo

    [diazo]
    recipe = zc.recipe.egg
    eggs = diazo

Note that ``lxml`` is a dependency of ``diazo``, so you may need to install the
libxml2 and libxslt development packages in order for it to build. On
Debian/Ubuntu you can run::

    $ sudo apt-get install build-essential python2.6-dev libxslt1-dev

On some operating systems, notably Mac OS X, installing a "good" ``lxml`` egg
can be problematic, due to a mismatch in the operating system versions of the
``libxml2`` and ``libxslt`` libraries that ``lxml`` uses. To get around that,
you can compile a static ``lxml`` egg using the following buildout recipe::

    [buildout]
    # lxml should be first in the parts list
    parts =
        lxml
        diazo
    
    [lxml]
    recipe = z3c.recipe.staticlxml
    egg = lxml
    libxml2-url = http://xmlsoft.org/sources/libxml2-2.7.7.tar.gz
    libxslt-url = http://xmlsoft.org/sources/libxslt-1.1.26.tar.gz
    
    [diazo]
    recipe = zc.recipe.egg
    eggs = diazo

Once installed, you should find ``diazocompiler`` and ``diazorun`` in your
``bin`` directory.