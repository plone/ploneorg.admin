
Todo 2011
=========

* Reinstall Subversion and Trac with mod_wsgi

  - Check in all configs to http://svn.plone.org/svn/plone/plone.org/

* Combine/consolidate http://dev.plone.org/plone.org trac with http://dev.plone.org/plone trac

* Configure commit hook to use "Fixes" and "Refs" across 
  repositories. E.g. use something like "Fixes plone:#1234" in a commit
  to the archetypes repository. 
  http://trac-hacks.org/wiki/InterTracCommitPatch implements this.
  Configure Intertrac links to link to other trac instances,
  like archetypes:[1234] to link to the archetypes changeset. See
  http://trac.edgewall.org/wiki/InterTrac

* Reinstall Planet Plone with latest Venus: https://github.com/rubys/venus/commits/master

* Install PHP LDAP Admin: http://phpldapadmin.sourceforge.net/wiki/index.php/Main_Page

* Install a public facing Hudson to complement: https://hudson.plone.org/ 

  - Rename (or CNAME) hudson.plone.org to ci.plone.org

* Upgrade/reinstall plone.net (pending the outcome of the Cioppino sprint)

  - Check in buildout to http://svn.plone.org/svn/plone/plone.org/

* Update/reinstall http://api.plone.org.

  - Create a buildout to run epydoc on core

* Host plone.hu, plone.it and all international Plone sites.

  - Some of these are on antiloop; DNS have expired for most.

* Host Plone user group sites.

  - There is a proposal for this somewhere.

* Restore stats.plone.org in some capacity.

  - What stats if any do we want to track?

* Move http://collective-docs.plone.org to "new deus"

* Move http://admin-docs.plone.org to "new deus"

* Move http://demo.plone.org to community controlled resource

  - Currently CNAME'd to http://plone-demo.sixfeetup.com/

* Break plone.org up into smaller Plone sites

  - Foster community use of plone.org as intranet

  - Separate foundation intranet from general Plone community

* Export/import Plone.org content via transmogrifier

* Setup git.plone.org mirror of svn.plone.org (to experiment with git)

* Setup hg.plone.org mirror of svn.plone.org (to experiment with hg)

* Host something like http://uml.joelburton.com/ on plone.org.

* Host something like http://paster.joelburton.com/ on plone.org.

* Host a paste server that doesn't suck, e.g. http://dpaste.com.

* Move the rest of the Sourceforge lists to lists.plone.org
