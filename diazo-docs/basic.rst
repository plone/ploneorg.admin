Rules file syntax
=================

The rules file, conventionally called ``rules.xml``, is rooted in a tag
called ``<rules />``::

    <rules xmlns="http://namespaces.plone.org/diazo"
           xmlns:css="http://namespaces.plone.org/diazo+css">
           
           ...
           
    </rules>

Here we have defined two namespaces: the default namespace is used for rules
and XPath selectors. The ``css`` namespace is used for CSS3 selectors. These
are functionally equivalent. In fact, CSS selectors are replaced by the
equivalent XPath selector during the pre-processing step of the compiler.
Thus, they have no performance impact.

Diazo supports complex CSS3 and XPath selectors, including things like the
``nth-child`` pseudo-selector. You are advised to consult a good reference
if you are new to XPath and/or CSS3.

The following elements are allowed inside the ``<rules />`` element:

``<theme />``
-------------

Used to specify the theme file. For example::

    <theme href="theme.html"/>

Relative paths are resolved relative to the rules.xml file. For http/https
urls, the ``--network`` switch must be supplied to diazocompiler/diazorun.

``<replace />``
---------------

Used to replace an element in the theme entirely with an element in the
content. For example::

    <replace theme="/html/head/title" content="/html/head/title"/>

The (near-)equivalent using CSS selectors would be::

    <replace css:theme="title" css:content="title"/>

The result of either is that the ``<title />`` element in the theme is
replaced with the ``<title />`` element in the (dynamic) content.

``<copy />``
------------

Used to replace the contents of a placeholder tag with a tag from the
theme. For example::

    <copy css:theme="#main" css:content="#portal-content > *" />

This would replace any placeholder content inside the element with id
``main`` in the theme with all children of the element with id
``portal-content`` in the content. The usual reason for using ``<copy />``
instead of ``<replace />``, is that the theme has CSS styles or other
behaviour attached to the target element (with id ``main`` in this case).

``<append />`` and ``<prepend />``
----------------------------------

Used to copy elements from the content into an element in the theme,
leaving existing content in place. ``<append />`` places the matched
content directly before the closing tag in the theme; ``<prepend />`` places
it directly after the opening tag. For example::

    <append theme="/html/head" content="/html/head/link" />

This will copy all ``<link />`` elements in the head of the content into
the theme.

As a special case, you can copy individual *attributes* from a content
element to an element in the theme using ``<prepend />``::

    <prepend theme="/html/body" content="/html/body/@class" />

This would copy the ``class`` attribute of the ``<body />`` element in
the content into the theme (replacing an existing attribute with the
same name if there is one).

``<before />`` and ``<after />``
--------------------------------

These are equivalent to ``<append />`` and ``<prepend />``, but place
the matched content before or after the matched theme element, rather
than immediately inside it. For example:
    
    <before css:theme="#content" css:content="#info-box" />

This would place the element with id ``info-box`` from the content
immediately before the element with id ``content`` in the theme. If we
wanted the box below the content instead, we could do::

    <after css:theme="#content" css:content="#info-box" />

``<drop />``
------------

Used to drop elements from the theme or the content. This is the only
element that accepts either ``theme`` or ``content`` attributes (or their
``css:`` equivalents), but not both::

    <drop css:content="#portal-content .about-box" />
    <copy css:theme="#content" css:content="#portal-content > *" />

This would copy all children of the element with id ``portal-content`` in
the theme  into the element with id ``content`` in the theme, but only
after removing any element with class ``about-box`` inside the content
element first. Similarly::

    <drop theme="/html/head/base" />

Would drop the ``<base />`` tag from the head of the theme.

Order of rule execution
-----------------------

In most cases, you should not care too much about the inner workings of the
Diazo compiler. However, it can sometimes be useful to understand the order
in which rules are applied.

1. ``<before />`` rules are always executed first.
2. ``<drop />`` rules are executed next.
3. ``<replace />`` rules are executed next, provided no ``<drop />`` rule was
   applied to the same theme node.
4. ``<prepend />``, ``<copy />`` and ``<append />`` rules execute next,
   provided no ``<replace />`` rule was applied to the same theme node.
5. ``<after />`` rules are executed last.

Behaviour if theme or content is not matched
--------------------------------------------

If a rule does not match the theme (whether or not it matches the content),
it is silently ignored.

If a ``<replace />`` rule matches the theme, but not the content, the matched
element will be dropped in the theme::

    <replace css:theme="#header" content="#header-element" />

Here, if the element with id ``header-element`` is not found in the content,
the placeholder with id ``header`` in the theme is removed.

Similarly, the contents of a theme node matched with a ``<copy />`` rule will
be dropped if there is no matching content. Another way to think of this is
that if no content node is matched, Diazo uses an empty nodeset when copying or
replacing.

If you want the placeholder to stay put in the case of a missing content node,
you can make this a conditional rule::

    <replace css:theme="#header" content="#header-element" if-content="" />

See below for more details on conditional rules.