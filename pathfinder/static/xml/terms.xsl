<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:t="terms">
	
<xsl:import href="/pathfinder/navbar.xsl" />

<xsl:output method="html" encoding="utf-8" doctype-system="about:legacy-compat" indent="yes" media-type="application/xhtml+xml" />

<xsl:template match="t:terms">
<xsl:variable name="xml" value="/pathfinder/static/xml/test.xml" />

<html>
<head>
	<meta content="text/html; charset=UTF-8" http-equiv="Content-Type" />
	<title>翻譯詞彙</title>
	<link rel="stylesheet" href="https://www.w3schools.com/lib/w3.css" />
	<script type="text/javascript" src="/pathfinder/static/js/jquery-3.1.1.min.js"></script>
	<script type="text/javascript" src="/pathfinder/static/js/base.js"></script>
</head>

<body>

<xsl:apply-templates select="document('/pathfinder/navbar.xml')" />

<div class="w3-main" style="margin-left:200px">
<header class="w3-container">
	<span class="w3-opennav w3-xlarge w3-hide-large" onclick="w3_open()">&#9776;</span>
	<h1>翻譯詞彙</h1>
</header>

<div class="w3-container">
	<table class="w3-table-all">
		<thead>
			<tr>
				<th>原文</th>
				<th>原文縮寫</th>
				<th>中文翻譯</th>
			</tr>
		</thead>
		
		<tbody>
			<xsl:for-each select="t:term">
				<tr>
					<td><xsl:apply-templates select="t:name[@lang='en']" /></td>
					<td><xsl:apply-templates select="t:abbr[@lang='en']" /></td>
					<td><xsl:apply-templates select="t:name[@lang='zh-tw']" /></td>
				</tr>
			</xsl:for-each>
		</tbody>
	</table>
</div>
</div>
</body>
</html>
</xsl:template>

<xsl:template match="t:ref">
	<xsl:variable name="href" select="@href" />
	<xsl:variable name="id" select="substring-after($href,'#')" />
	<xsl:variable name="node" select="../../../t:term[@id=$id]" />
	<xsl:variable name="type" select="@type" />
	<xsl:variable name="lang" select="@lang" />
	
	<xsl:apply-templates select="$node/*[name()=$type][@lang=$lang]" />
</xsl:template>
</xsl:stylesheet>
