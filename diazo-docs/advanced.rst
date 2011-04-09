Advanced usage
--------------

The simple rules above should suffice for most use cases. However, there are
a few more advanced tools at your disposal, should you need them.

Conditional rules
~~~~~~~~~~~~~~~~~

Sometimes, it is useful to apply a rule only if a given element appears or
does not appear in the markup. The ``if-content`` attribute can be used with
any rule to make it conditional.

``if-content`` should be set to an XPath expression. You can also use
``css:if-content`` with a CSS3 expression. If the expression matches a node
in the content, the rule will be applied::

    <copy css:theme="#portlets" css:content=".portlet"/>
    <drop css:theme="#portlet-wrapper" if-content="not(//*[@class='portlet'])"/>

This will copy all elements with class ``portlet`` into the ``portlets``
element. If there are no matching elements in the content we drop the
``portlet-wrapper`` element, which is presumably superfluous.

Here is another example using CSS selectors::

    <copy css:theme="#header" css:content="#header-box > *" 
          css:if-content="#personal-bar"/>

This will copy the children of the element with id ``header-box`` in the
content into the element with id ``header`` in the theme, so long as an
element with id ``personal-bar`` also appears somewhere in the content.

An empty ``if-content`` (or ``css:if-content``) is a shortcut meaning "use the
expression in the ``content`` or ``css:content``` attribute as the condition".
Hence the following two rules are equivalent::

    <copy css:theme="#header" css:content="#header-box > *"
          css:if-content="#header-box > *"/>
    <copy css:theme="#header" css:content="#header-box > *" 
          css:if-content=""/>

If multiple rules of the same type match the same theme node but have
different ``if-content`` expressions, they will be combined as an
if..else if...else block::

    <copy theme="/html/body/h1" content="/html/body/h1/text()"
          if-content="/html/body/h1"/>
    <copy theme="/html/body/h1" content="//h1[@id='first-heading']/text()"
          if-content="//h1[@id='first-heading']"/>
    <copy theme="/html/body/h1" content="/html/head/title/text()" />

These rules all attempt to fill the text in the ``<h1 />`` inside the body.
The first rule looks for a similar ``<h1 />`` tag and uses its text. If that
doesn't match, the second rule looks for any ``<h1 />`` with id
``first-heading``, and uses its text. If that doesn't match either, the
final rule will be used as a fallback (since it has no ``if-content``),
taking the contents of the ``<title />`` tag in the head of the content
document.

Condition grouping and nesting
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A condition may be applied to multiple rules by placing it on a ``<rules>``
tag::

    <rules xmlns="http://namespaces.plone.org/diazo"
           xmlns:css="http://namespaces.plone.org/diazo+css">
        
        <rules css:if-content="#personal-bar">
            <append css:theme="#header-box" css:content="#user-prefs"/>
            <append css:theme="#header-box" css:content="#logout"/>
        </rules>
        
        ...
        
    </rules>

Conditions may also be nested, so::

    <rules if-content="condition1">
        <rules if-content="condition2">
            <copy if-content="condition3" css:theme="#a" css:content="#b"/>
        </rules>
    </rules>

Is equivalent to::

    <copy if-content="(condition1) and (condition2) and (condition3)" css:theme="#a" css:content="#b"/>

Multiple themes
~~~~~~~~~~~~~~~

It's possible to specify multiple themes using conditions. For instance::

    <theme href="theme.html"/>
    <theme href="news.html" css:if-content="body.section-news"/>
    <theme href="members.html" css:if-content="body.section-members"/>

The unconditional theme is used as a fallback when no other theme's condition
is satisfied. If no unconditional theme is specified, the document is passed
through without theming.

All rules are applied to all themes. To have a rule apply to only a single
theme, use the condition grouping syntax::

    <rules css:if-content="body.section-news">
        <theme href="news.html"/>
        <copy css:content="h2.articleheading" css:theme="h1"/>
    </rules>

Path conditions
~~~~~~~~~~~~~~~

A path condition may be applied to a rule, theme or group with the ``if-path``
attribute.

A leading ``/`` indicates that a path should be matched at the start of the
url::

    <theme href="news.html" if-path="/news"/>

matches pages with urls ``/news``, ``/news/`` and ``/news/page1.html`` but
not ``/newspapers`` - only complete path segments are matched.

A trailing ``/`` indicates that a path should be matched at the end of the
url::

    <theme href="news.html" if-path="news/"/>

matches ``/mysite/news`` and ``/mysite/news/``.

To match an exact url, use both leading and trailing ``/``::

    <theme href="news.html" if-path="/news/"/>

matches ``/news`` and ``/news/``.

Without a leading or trailing ``/`` the path segment(s) may match anywhere in
the url::

    <theme href="news.html" if-path="news/space"/>

matches ``/mysite/news/space/page1.html``.

Multiple alternative path conditions may be included in the ``if-path``
attribute as whitespace separated list::

    <theme href="wide.html" if-path="/ /index.html/"/>

matches ``/`` and ``/index.html``. ``if-path="/"`` is considered an exact
match condition

Including external content
~~~~~~~~~~~~~~~~~~~~~~~~~~

Normally, the ``content`` attribute of any rule selects nodes from the
response being returned by the underlying dynamic web server. However, it is
possible to include content from a different URL using the ``href`` attribute
on any rule (other than ``<drop />``). For example::

    <append css:theme="#left-column" css:content="#portlet" href="/extra.html"/>

This will resolve the URL ``/extra.html``, look for an element with id
``portlet`` and then append to to the element with id ``left-column`` in the
theme.

The inclusion can happen in one of three ways:

* Using the XSLT ``document()`` function. This is the default, but it can
  be explicitly specified by adding an attribute ``method="document"`` to the 
  rule element. Whether this is able to resolve the URL depends on how and
  where the compiled XSLT is being executed::
  
    <append css:theme="#left-column" css:content="#portlet"
            href="/extra.html" method="document" />
  
* Via a Server Side Include directive. This can be specified by setting the
  ``method`` attribute to ``ssi``::
  
    <append css:theme="#left-column" css:content="#portlet"
            href="/extra.html" method="ssi"/>

  The output will render like this::
  
    <!--#include virtual="/extra.html?;filter_xpath=descendant-or-self::*[@id%20=%20'portlet']"-->
  
  This SSI instruction would need to be processed by a fronting web server
  such as Apache or Nginx. Also note the ``;filter_xpath`` query string
  parameter. Since we are deferring resolution of the referenced document
  until SSI processing takes place (i.e. after the compiled Diazo XSLT transform
  has executed), we need to ask the SSI processor to filter out elements in
  the included file that we are not interested in. This requires specific
  configuration. An example for Nginx is included below.
  
  For simple SSI includes of a whole document, you may omit the ``content``
  selector from the rule::
  
    <append css:theme="#left-column" href="/extra.html" method="ssi"/>
  
  The output then renders like this::
  
    <!--#include virtual="/extra.html"-->

  Some versions of Nginx have required the ``wait="yes"`` ssi option to be
  stable. This can be specified by setting the ``method`` attribute to
  ``ssiwait``.

* Via an Edge Side Includes directive. This can be specified by setting the
  ``method`` attribute to ``esi``::
  
    <append css:theme="#left-column" css:content="#portlet"
            href="/extra.html" method="esi"/>

  The output is similar to that for the SSI mode::

    <esi:include src="/extra.html?;filter_xpath=descendant-or-self::*[@id%20=%20'portlet']"></esi:include>
  
  Again, the directive would need to be processed by a fronting server, such
  as Varnish. Chances are an ESI-aware cache server would not support
  arbitrary XPath filtering. If the referenced file is served by a dynamic
  web server, it may be able to inspect the ``;filter_xpath`` parameter and
  return a tailored response. Otherwise, if a server that can be made aware
  of this is placed in-between the cache server and the underlying web server,
  that server can perform the necessary filtering.

  For simple ESI includes of a whole document, you may omit the ``content``
  selector from the rule::
  
    <append css:theme="#left-column" href="/extra.html" method="esi"/>
  
  The output then renders like this::
  
    <esi:include src="/extra.html"></esi:include>

Modifying the theme on the fly
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sometimes, the theme is almost perfect, but cannot be modified, for example
because it is being served from a remote location that you do not have access
to, or because it is shared with other applications.

Diazo allows you to modify the theme using "inline" markup in the rules file.
You can think of this as a rule where the matched ``content`` is explicitly
stated in the rules file, rather than pulled from the response being styled.

For example::

    <rules
        xmlns="http://namespaces.plone.org/diazo"
        xmlns:css="http://namespaces.plone.org/diazo+css"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        >

        <append theme="/html/head">
            <style type="text/css">
                /* From the rules */
                body > h1 { color: red; }
            </style>
        </append>

    </diazo:rules>

In the example above, the ``<append />`` rule will copy the ``<style />``
attribute and its contents into the ``<head />`` of the theme. Similar rules
can be constructed for ``<copy />``, ``<replace />``, ``<prepend />``, 
``<before />`` or ``<after />``.

It is even possible to insert XSLT instructions into the compiled theme in
this manner. Having declared the ``xsl`` namespace as shown above, we can do
something like this::

    <replace css:theme="#details">
        <dl id="details">
            <xsl:for-each css:select="table#details > tr">
                <dt><xsl:copy-of select="td[1]/text()"/></dt>
                <dd><xsl:copy-of select="td[2]/node()"/></dd>
            </xsl:for-each>
        </dl>
    </replace>

Inline XSL directives
~~~~~~~~~~~~~~~~~~~~~

You may supply inline XSL directives in the rules to tweak the final output,
for instance to strip space from the output document use::

    <rules xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

        <xsl:strip-space elements="*" />

    </rules>

Note: this may effect the rendering of the page on the browser.

Doctypes
~~~~~~~~

By default, Diazo transforms output pages with the XHTML 1.0 Transitional
doctype. To use a strict doctype include this inline XSL::

    <xsl:output
        doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

It's important to note that only the XHTML 1.0 Strict and XHTML 1.0
Transitional doctypes trigger the special XHTML compatibility mode of
libxml2's XML serializer. This ensures ``<br/>`` is rendered as ``<br />`` and
``<div/>`` as ``<div></div>``, which is necessary for browsers to correctly
parse the document as HTML.

The HTML5 specification lists XHTML 1.0 Strict as as `obsolete permitted
doctype string`_, so this doctype is recommended when HTML5 output is desired.

XInclude
~~~~~~~~

You may wish to re-use elements of your rules file across multiple themes.
This is particularly useful if you have multiple variations on the same theme
used to style different pages on a particular website.

Rules files may be included using the XInclude protocol.

Inclusions use standard XInclude syntax. For example::

    <rules
        xmlns="http://namespaces.plone.org/diazo"
        xmlns:css="http://namespaces.plone.org/diazo+css"
        xmlns:xi="http://www.w3.org/2001/XInclude">
        
        <xi:include href="standard-rules.xml" />
    
    </rules>