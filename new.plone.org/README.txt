What is this?

  This is a Deliverance buildout for applying the new theme for plone.org using
  a slightly modified version of Deliverance called xdv.

How does it work?

  To install:
  cd new.plone.org
  python bootstrap.py
  bin/buildout (or, if you're on OS X: bin/buildout -C osx.cfg)

  Then, to run the proxy:
  bin/run-deliverance

  This will look for a Plone site at http://new.plone.org/ and apply the
  new plone.org theme to it. If you want to replace this with a local instance,
  edit 'server.ini'.

In the target site:

  (for this particular theme, not Deliverance/xdv in general)

  - Disable all CSS except for the Kupu stuff

  - Disable KSS

  - Turn off document_actions in /@@manage-viewlets

  - Note that the CSS won't carry over properly unless you have a version of
    ResourceRegistries that incorporates this change: 
    http://dev.plone.org/plone/changeset/23996
    (the symptoms will be that you don't get the Kupu CSS)