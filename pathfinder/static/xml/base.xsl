<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ext="http://exslt.org/common"
	xmlns="http://www.w3.org/1999/xhtml">

<xsl:template name="reference">
	<xsl:param name="ref_node" />
	<xsl:variable name="xml_path" select="$ref_node/@xml" />
	<xsl:variable name="xml" select="document($xml_path)" />
	<xsl:apply-templates select="$xml/*" />
</xsl:template>

<xsl:template name="page">
	<xsl:param name="root" />
	<xsl:param name="title" />
	<xsl:param name="pageTitle" />
	<xsl:param name="pageDes" />
		
	<html>
	<head>
		<meta content="text/html; charset=UTF-8" http-equiv="Content-Type" />
		<title><xsl:apply-templates select="ext:node-set($title)" /></title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script src="/pathfinder/static/js/base.js"></script>
	</head>
	
	<body>
	
	<div id="header" class="navbar navbar-default navbar-fixed-top"></div>
	
	<div class="container">
		<div class="jumbotron">
			<h1><xsl:apply-templates select="ext:node-set($pageTitle)" /></h1>
			<p><xsl:apply-templates select="ext:node-set($pageDes)" /></p>
		</div>
	</div>
	
	<div class="container">
		<xsl:apply-templates select="$root/*" />
	</div>
	</body>
	</html>
</xsl:template>

<xsl:template name="paragraph">
	<xsl:param name="title" />
	<xsl:param name="depth" />
</xsl:template>

<xsl:template name="gen_paragraph">
	<xsl:param name="node" />
	<xsl:param name="depth" />

	<xsl:for-each select="$node/*[local-name()='paragraph'][namespace-uri()=namespace-uri($node)]">
		<xsl:if test="*[local-name()='title'][namespace-uri()=namespace-uri($node)]">
			<xsl:choose>
				<xsl:when test="$depth=1">
					<h2><xsl:apply-templates select="*[local-name()='title'][namespace-uri()=namespace-uri($node)]" /></h2>
				</xsl:when>
				<xsl:when test="$depth=2">
					<h3><xsl:apply-templates select="*[local-name()='title'][namespace-uri()=namespace-uri($node)]" /></h3>
				</xsl:when>
				<xsl:when test="$depth=3">
					<h4><xsl:apply-templates select="*[local-name()='title'][namespace-uri()=namespace-uri($node)]" /></h4>
				</xsl:when>
				<xsl:when test="$depth=4">
					<h5><xsl:apply-templates select="*[local-name()='title'][namespace-uri()=namespace-uri($node)]" /></h5>
				</xsl:when>
				<xsl:otherwise>
					<h6><xsl:apply-templates select="*[local-name()='title'][namespace-uri()=namespace-uri($node)]" /></h6>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		
		<xsl:for-each select="*[local-name()='contains'][namespace-uri()=namespace-uri($node)]/*[local-name()='contain'][namespace-uri()=namespace-uri($node)]">
			<p>
				<xsl:choose>
					<xsl:when test="*[local-name()='paragraphs'][namespace-uri()=namespace-uri($node)]">
						<xsl:call-template name="gen_paragraph">
							<xsl:with-param name="node" select="*[local-name()='paragraphs'][namespace-uri()=namespace-uri($node)]" />
							<xsl:with-param name="depth" select="$depth+1" />
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates />
					</xsl:otherwise>
				</xsl:choose>
			</p>
		</xsl:for-each>
	</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
