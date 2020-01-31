<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:math="http://www.w3.org/1998/Math/MathML" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:r="races" xmlns:gen="general">

<xsl:import href="/trpg/pathfinder/static/xml/base.xsl" />

<xsl:output method="html" encoding="utf-8" doctype-system="about:legacy-compat" indent="yes" media-type="application/xhtml+xml" />

<xsl:template match="r:races">
	<xsl:variable name="xml" select="document('/trpg/pathfinder/static/xml/terms.xml')" />
	<xsl:call-template name="page">
		<xsl:with-param name="title" select="$xml//*[@id='race']/*[name()='name'][@lang='zh-tw']" />
		<xsl:with-param name="pageTitle" select="$xml//*[@id='race']/*[name()='name'][@lang='zh-tw']" />
		<xsl:with-param name="nav" select="document('/trpg/pathfinder/navbar.xml')" />
		<xsl:with-param name="page" select="r:race" />
		<xsl:with-param name="initDepth" select="1" />
	</xsl:call-template>
</xsl:template>

<xsl:template match="r:race">
	<xsl:variable name="xml" select="document('/trpg/pathfinder/static/xml/terms.xml')" />
	<h2><xsl:apply-templates select="r:name" /></h2>
	
	<xsl:for-each select="r:descriptions/r:description">
		<p><xsl:apply-templates /></p>
	</xsl:for-each>
	
	<p><b>體貌描述</b>
		<xsl:text>︰</xsl:text><xsl:apply-templates select="r:physical" /></p>
		
	<p><b>社會</b>
		<xsl:text>︰</xsl:text><xsl:apply-templates select="r:society" /></p>
		
	<p><b>關係</b>
		<xsl:text>︰</xsl:text><xsl:apply-templates select="r:relation" /></p>
		
	<p><b>陣營和宗教</b>
		<xsl:text>︰</xsl:text><xsl:apply-templates select="r:alignment" /></p>
		
	<p><b>冒險</b>
		<xsl:text>︰</xsl:text><xsl:apply-templates select="r:adventurer" /></p>
		
	<h3><xsl:apply-templates select="r:name" /><xsl:apply-templates select="$xml//*[@id='race']/*[name()='name'][@lang='zh-tw']" />特性</h3>
	
	<xsl:for-each select="r:traits/r:trait">
		<p><b><xsl:apply-templates select="r:name" /></b>
		<xsl:text>︰</xsl:text><xsl:apply-templates select="r:description" /></p>
	</xsl:for-each>
</xsl:template>

<xsl:template match="math:*">
	<xsl:copy-of select=".">
		<xsl:apply-templates />
	</xsl:copy-of>
</xsl:template>

<xsl:template match="gen:name">
	<xsl:call-template name="glossary">
		<xsl:with-param name="href" select="@xlink:href" />
		<xsl:with-param name="type" select="'name'" />
		<xsl:with-param name="lang" select="'zh-tw'" />
	</xsl:call-template>
</xsl:template>
</xsl:stylesheet>
