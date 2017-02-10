<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:books="books" xmlns:gen="general"
	xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/1999/xhtml">

<xsl:import href="/static/xml/base.xsl" />

<xsl:output
	method="html"
	encoding="UTF-8"
	doctype-public="-//W3C//DTD XHTML 1.1 plus MathML 2.0 plus SVG 1.1//EN"
	doctype-system="http://www.w3.org/2002/04/xhtml-math-svg/xhtml-math-svg.dtd"
	indent="yes"
	media-type="application/xhtml+xml" />

<xsl:template match="books:books">
<xsl:call-template name="page">
	<xsl:with-param name="root" select="." />
	<xsl:with-param name="title">
		<gen:name xlink:type="simple" xlink:href="/static/xml/terms.xml#pathfinder" type="ch">pathfinder</gen:name>
	</xsl:with-param>
	<xsl:with-param name="pageTitle">
		<gen:name xlink:type="simple" xlink:href="/static/xml/terms.xml#pathfinder" type="total">pathfinder</gen:name>
	</xsl:with-param>
	<xsl:with-param name="pageDes"><gen:name xlink:type="simple" xlink:href="/static/xml/terms.xml#pathfinder" type="ch">pathfinder</gen:name>規則整理站</xsl:with-param>
</xsl:call-template>
</xsl:template>

<xsl:template match="books:book">
<div class="col-sm-6">
	<h3><xsl:value-of select="books:name" /></h3>
	<ol>
	<xsl:for-each select="books:chapters/books:chapter">
		<li>
			<xsl:choose>
				<xsl:when test="@xlink:href">
					<a>
						<xsl:attribute name="href">
							<xsl:value-of select="@xlink:href" />
						</xsl:attribute>
						<xsl:value-of select="text()" />
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="text()" />
				</xsl:otherwise>
			</xsl:choose>
		</li>
	</xsl:for-each>
	</ol>
</div>
</xsl:template>
</xsl:stylesheet> 
