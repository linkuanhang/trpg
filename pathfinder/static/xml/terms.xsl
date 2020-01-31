<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:t="terms">
	
<xsl:import href="/trpg/pathfinder/navbar.xsl" />

<xsl:output method="html" encoding="utf-8" doctype-system="about:legacy-compat" indent="yes" media-type="application/xhtml+xml" />

<xsl:template match="t:terms">
	<html>
	<head>
		<meta content="text/html; charset=UTF-8" http-equiv="Content-Type" />
		<title>翻譯詞彙</title>
		<link rel="stylesheet" href="/trpg/pathfinder/static/css/w3.css" />
		<script type="text/javascript" src="/trpg/pathfinder/static/js/jquery-3.1.1.min.js"></script>
		<script type="text/javascript" src="/trpg/pathfinder/static/js/base.js"></script>
	</head>
	
	<body>
	
	<nav class="w3-bar w3-border-bottom w3-white w3-top">
		<div class="logo-container">
			<a href="javascript:void(0)" onclick="nav_toggle();" class="w3-bar-item w3-hover-none w3-xlarge w3-button">&#8801;</a>
			<a href="/pathfinder/index.xml" class="w3-bar-item"><img src="/trpg/pathfinder/static/img/PRD-Logo.png" alt="Pathfinder RPG" height="30px" /></a>
		</div>
		<div id="languages">
			<input id="en" class="w3-bar-item w3-check" type="checkbox" onclick="toggle_lang($(this))" />
			<label class="w3-bar-item w3-validate">English</label>
			<input id="zh-tw" class="w3-bar-item w3-check" type="checkbox" checked="checked" onclick="toggle_lang($(this))" />
			<label class="w3-bar-item w3-validate">中文（台灣）</label>
		</div>
	</nav>
	
	<xsl:apply-templates select="document('/pathfinder/navbar.xml')" />
	
	<main style="margin-top:53px;margin-left:200px;">
		<header class="w3-container">
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
	</main>
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
