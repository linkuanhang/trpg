<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:books="books" xmlns:gen="general"
	xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/1999/xhtml">

<xsl:import href="/trpg/pathfinder/static/xml/general.xsl" />

<xsl:template match="books:books">
	<nav id="sidenav" class="w3-sidenav w3-border-right" style="width:200px;top:53px;">
		<xsl:apply-templates />
	</nav>
</xsl:template>

<xsl:template match="books:book">
	<a href="javascript:void(0)">
		<xsl:attribute name="onclick">
			<xsl:text>sidenav_toggle($('#</xsl:text>
			<xsl:value-of select="@id" />
			<xsl:text>'))</xsl:text>
		</xsl:attribute>
		<xsl:value-of select="books:name" />
		<xsl:text> &#9660;</xsl:text>
	</a>
	<div class="w3-hide w3-border">
		<xsl:attribute name="id">
			<xsl:value-of select="@id" />
		</xsl:attribute>
		<xsl:for-each select="books:chapters/books:chapter">
			<a>
				<xsl:choose>
					<xsl:when test="@xlink:href">
						<xsl:attribute name="href">
							<xsl:value-of select="@xlink:href" />
						</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="href">
							<xsl:text>javascript:void(0)</xsl:text>
						</xsl:attribute>
						<xsl:attribute name="class">
							<xsl:text>w3-hover-red</xsl:text>
						</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="text()" />
			</a>
		</xsl:for-each>
	</div>
</xsl:template>
</xsl:stylesheet> 
