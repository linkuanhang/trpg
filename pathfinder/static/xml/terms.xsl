<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:t="terms">
	
<xsl:output
	method="html"
	encoding="UTF-8"
	doctype-public="-//W3C//DTD XHTML 1.1 plus MathML 2.0 plus SVG 1.1//EN"
	doctype-system="http://www.w3.org/2002/04/xhtml-math-svg/xhtml-math-svg.dtd"
	indent="yes"
	media-type="application/xhtml+xml" />

<xsl:template match="t:terms">
<html>
<head>
	<meta content="text/html; charset=UTF-8" http-equiv="Content-Type" />
	<title>翻譯詞彙</title>
	<link rel="stylesheet" href="static/css/bootstrap.min.css" />
	<script src="static/js/jquery.min.js"></script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/base.js"></script>
</head>

<body>

<div id="header" class="navbar navbar-default navbar-fixed-top"></div>

<div class="container">
	<div class="jumbotron">
		<h1>翻譯詞彙</h1>
	</div>
</div>

<div class="container">
	<table class="table table-bordered">
		<thead>
			<tr>
				<th>原文</th>
				<th>原文縮寫</th>
				<th>中文翻譯</th>
			</tr>
		</thead>
		
		<tbody>
			<xsl:for-each select="t:term">
				<xsl:apply-templates select="." />
			</xsl:for-each>
		</tbody>
	</table>
</div>
</body>
</html>
</xsl:template>

<xsl:template match="t:term">
	<tr>
		<td><xsl:apply-templates select="t:name/t:en" /></td>
		<td><xsl:apply-templates select="t:name/t:en_abbr" /></td>
		<td><xsl:apply-templates select="t:name/t:ch" /></td>
	</tr>
</xsl:template>

<xsl:template match="t:ref">
	<xsl:param name="xlink" select="./@xlink:href" />
	<xsl:param name="id" select="substring-after($xlink,'#')" />
	<xsl:param name="type" select="name(..)" />
	<xsl:param name="node" select="//t:term[@id=$id]" />
	
	<xsl:apply-templates select="$node/t:name/*[name(.)=$type]" />
</xsl:template>
</xsl:stylesheet>

