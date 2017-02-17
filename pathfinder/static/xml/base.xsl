<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:gen="general" xmlns:t="terms">

<xsl:import href="/pathfinder/navbar.xsl" />

<xsl:template name="page">
	<xsl:param name="title" />
	<xsl:param name="pageTitle" />
	<xsl:param name="nav" />
	<xsl:param name="page" />
	<xsl:param name="initDepth" />
	
	<html>
	<head>
		<meta content="text/html; charset=UTF-8" http-equiv="Content-Type" />
		<title><xsl:apply-templates select="$title" /></title>
		<link rel="stylesheet" href="/pathfinder/static/css/w3.css" />
		<script type="text/javascript" src="/pathfinder/static/js/jquery-3.1.1.min.js"></script>
		<script type="text/javascript" src="/pathfinder/static/js/base.js"></script>
	</head>
	
	<body>
	
	<xsl:apply-templates select="$nav" />
	
	<div class="w3-main" style="margin-left:200px">
	<header class="w3-container">
		<span class="w3-opennav w3-xlarge w3-hide-large" onclick="w3_open()">&#9776;</span>
		<h1><xsl:apply-templates select="$pageTitle" /></h1>
	</header>
	
	<div class="w3-container">
		<xsl:apply-templates select="$page">
			<xsl:with-param name="depth" select="$initDepth" />
		</xsl:apply-templates>
	</div>
	</div>
	</body>
	</html>
</xsl:template>

<xsl:template name="section">
	<xsl:param name="title" />
	<xsl:param name="depth" />
	<xsl:param name="articles" />
	
	<section>
	<xsl:choose>
		<xsl:when test="$depth=1">
			<h2><xsl:apply-templates select="$title" /></h2>
		</xsl:when>
		<xsl:when test="$depth=2">
			<h3><xsl:apply-templates select="$title" /></h3>
		</xsl:when>
		<xsl:when test="$depth=3">
			<h4><xsl:apply-templates select="$title" /></h4>
		</xsl:when>
		<xsl:when test="$depth=4">
			<h5><xsl:apply-templates select="$title" /></h5>
		</xsl:when>
		<xsl:otherwise>
			<h6><xsl:apply-templates select="$title" /></h6>
		</xsl:otherwise>
	</xsl:choose>
	
	<xsl:apply-templates select="$articles">
		<xsl:with-param name="depth" select="$depth+1" />
	</xsl:apply-templates>
	</section>
</xsl:template>

<xsl:template name="article">
	<article><xsl:apply-templates /></article>
</xsl:template>

<xsl:template name="paragraph">
	<p><xsl:apply-templates /></p>
</xsl:template>

<xsl:template name="reference">
	<xsl:param name="href" />
	
	<xsl:apply-templates select="document($href)/*" />
</xsl:template>

<xsl:template name="xlink">
	<xsl:param name="href" />
	
	<a href="$href"><xsl:apply-templates /></a>
</xsl:template>

<xsl:template name="comment">
	<xsl:text>【譯注︰</xsl:text>
	<xsl:apply-templates />
	<xsl:text>】</xsl:text>
</xsl:template>

<xsl:template name="glossary">
	<xsl:param name="href" />
	<xsl:param name="type" />
	<xsl:param name="lang" />
	
	<xsl:variable name="xml" select="substring-before($href,'#')" />
	<xsl:variable name="id" select="substring-after($href,'#')" />
	<xsl:variable name="term" select="document($xml)//*[@id=$id]" />
	
	<xsl:apply-templates select="$term/*[name()=$type][@lang=$lang]">
		<xsl:with-param name="xml" select="$xml" />
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="t:ref">
	<xsl:param name="xml" />
	
	<xsl:variable name="href" select="@href" />
	<xsl:variable name="id" select="substring-after($href,'#')" />
	<xsl:variable name="node" select="document($xml)//*[@id=$id]" />
	<xsl:variable name="type" select="@type" />
	<xsl:variable name="lang" select="@lang" />
	
	<xsl:apply-templates select="$node/*[name()=$type][@lang=$lang]" />
</xsl:template>

</xsl:stylesheet>
