<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:math="http://www.w3.org/1998/Math/MathML" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:gen="general" xmlns:t="terms">

<xsl:import href="/pathfinder/navbar.xsl" />
<xsl:import href="/pathfinder/static/xml/terms.xsl" />

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
	
	<body style="min-width:500px;">
	
	<nav class="w3-bar w3-border-bottom w3-white w3-top" style="min-width:500px;">
		<div class="logo-container">
			<a href="javascript:void(0)" onclick="nav_toggle();" class="w3-bar-item w3-hover-none w3-xlarge w3-button">&#8801;</a>
			<a href="/pathfinder/index.xml" class="w3-bar-item"><img src="/pathfinder/static/img/PRD-Logo.png" alt="Pathfinder RPG" height="30px" /></a>
		</div>
		<div id="languages">
			<div class="language w3-bar-item">
				<input id="en" class="w3-check" type="checkbox" onclick="toggle_lang($(this))" />
				<label class="w3-validate">English</label>
			</div>
			<div class="language w3-bar-item">
				<input id="zh-tw" class="w3-check" type="checkbox" checked="checked" onclick="toggle_lang($(this))" />
				<label class="w3-validate">中文（台灣）</label>
			</div>
		</div>
	</nav>
	
	<xsl:apply-templates select="$nav" />
	
	<main style="margin-top:53px;margin-left:200px;">
	<header class="w3-container">
		<xsl:for-each select="$pageTitle">
			<h1>
				<xsl:attribute name="lang">
					<xsl:value-of select="@lang" />
				</xsl:attribute>
				<xsl:apply-templates />
			</h1>
		</xsl:for-each>
	</header>
	
	<div class="w3-container">
		<xsl:apply-templates select="$page">
			<xsl:with-param name="depth" select="$initDepth" />
		</xsl:apply-templates>
	</div>
	</main>
	</body>
	</html>
</xsl:template>

<xsl:template name="section">
	<xsl:param name="title" />
	<xsl:param name="depth" />
	<xsl:param name="articles" />
	
	<section>
	<xsl:for-each select="$title">
		<xsl:choose>
			<xsl:when test="$depth=1">
				<h1>
					<xsl:attribute name="lang">
						<xsl:value-of select="@lang" />
					</xsl:attribute>
					<xsl:apply-templates />
				</h1>
			</xsl:when>
			<xsl:when test="$depth=2">
				<h2>
					<xsl:attribute name="lang">
						<xsl:value-of select="@lang" />
					</xsl:attribute>
					<xsl:apply-templates />
				</h2>
			</xsl:when>
			<xsl:when test="$depth=3">
				<h3>
					<xsl:attribute name="lang">
						<xsl:value-of select="@lang" />
					</xsl:attribute>
					<xsl:apply-templates />
				</h3>
			</xsl:when>
			<xsl:when test="$depth=4">
				<h4>
					<xsl:attribute name="lang">
						<xsl:value-of select="@lang" />
					</xsl:attribute>
					<xsl:apply-templates />
				</h4>
			</xsl:when>
			<xsl:when test="$depth=5">
				<h5>
					<xsl:attribute name="lang">
						<xsl:value-of select="@lang" />
					</xsl:attribute>
					<xsl:apply-templates />
				</h5>
			</xsl:when>
			<xsl:otherwise>
				<h6>
					<xsl:attribute name="lang">
						<xsl:value-of select="@lang" />
					</xsl:attribute>
					<xsl:apply-templates />
				</h6>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
	
	<xsl:apply-templates select="$articles">
		<xsl:with-param name="depth" select="$depth+1" />
	</xsl:apply-templates>
	</section>
</xsl:template>

<xsl:template name="article">
	<article><xsl:apply-templates /></article>
</xsl:template>

<xsl:template name="paragraph">
	<p>
		<xsl:attribute name="lang">
			<xsl:value-of select="@lang" />
		</xsl:attribute>
		<xsl:apply-templates />
	</p>
</xsl:template>

<xsl:template name="reference">
	<xsl:param name="href" />
	
	<xsl:apply-templates select="document($href)/*" />
</xsl:template>

<xsl:template name="link">
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

<xsl:template match="gen:name">
	<xsl:variable name="terms" select="'/pathfinder/static/xml/terms.xml'" />
	
	<xsl:call-template name="glossary">
		<xsl:with-param name="href" select="concat($terms,'#',@href)" />
		<xsl:with-param name="type" select="@type" />
		<xsl:with-param name="lang" select="@lang" />
	</xsl:call-template>
</xsl:template>

<xsl:template match="gen:dice">
	<xsl:choose>
		<xsl:when test="namespace-uri(..)='http://www.w3.org/1999/xhtml'">
			<math:mn><xsl:value-of select="@num" /></math:mn><math:mi>d</math:mi><math:mn><xsl:value-of select="@face" /></math:mn>
		</xsl:when>
		<xsl:otherwise>
			<math:math><math:mn><xsl:value-of select="@num" /></math:mn><math:mi>d</math:mi><math:mn><xsl:value-of select="@face" /></math:mn></math:math>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="gen:rlink">
	<xsl:text>參照</xsl:text>
	<a>
		<xsl:attribute name="href">
			<xsl:value-of select="@href" />
		</xsl:attribute>
		<xsl:apply-templates />
	</a>
	<xsl:text>部份</xsl:text>
</xsl:template>

<xsl:template match="gen:DR">
	<math:math>
		<math:mn><xsl:value-of select="@num" /></math:mn>
	</math:math>
	<xsl:text>/</xsl:text>
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="gen:multiply">
	<xsl:choose>
		<xsl:when test="namespace-uri(..)='http://www.w3.org/1999/xhtml'">
			<math:mo>&#xD7;</math:mo><math:mn><xsl:value-of select="@value" /></math:mn>
		</xsl:when>
		<xsl:otherwise>
			<math:math><math:mo>&#xD7;</math:mo><math:mn><xsl:value-of select="@value" /></math:mn></math:math>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
</xsl:stylesheet>
