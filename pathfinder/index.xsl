<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:i="intro" xmlns:gen="general"
	xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/1999/xhtml">

<xsl:import href="/trpg/pathfinder/static/xml/base.xsl" />

<xsl:output method="html" encoding="utf-8" doctype-system="about:legacy-compat" indent="yes" media-type="application/xhtml+xml" />

<xsl:template match="i:intro">
	<xsl:call-template name="page">
		<xsl:with-param name="title" select="i:header/i:title[@lang='zh-tw']" />
		<xsl:with-param name="pageTitle" select="i:header/i:title" />
		<xsl:with-param name="nav" select="document('/trpg/pathfinder/navbar.xml')" />
		<xsl:with-param name="page" select="i:body/*" />
		<xsl:with-param name="initDepth" select="2" />
	</xsl:call-template>
</xsl:template>

<xsl:template match="i:section">
	<xsl:param name="depth" />
	
	<xsl:call-template name="section">
		<xsl:with-param name="title" select="i:title" />
		<xsl:with-param name="depth" select="$depth" />
		<xsl:with-param name="articles" select="i:article" />
	</xsl:call-template>
</xsl:template>

<xsl:template match="i:article">
	<xsl:call-template name="article" />
</xsl:template>

<xsl:template match="i:paragraph">
	<xsl:call-template name="paragraph" />
</xsl:template>

<xsl:template match="i:publisher">
	<i><xsl:apply-templates /></i>
</xsl:template>
</xsl:stylesheet>
