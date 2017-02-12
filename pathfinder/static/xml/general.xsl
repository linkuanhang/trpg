<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:ext="http://exslt.org/common"
	xmlns:gen="general" xmlns:t="terms" xmlns="http://www.w3.org/1999/xhtml">

<xsl:template match="gen:name">
	<xsl:param name="xlink" select="./@xlink:href" />
	<xsl:param name="xml" select="document(substring-before($xlink,'#'))" />
	<xsl:param name="id" select="substring-after($xlink,'#')" />
	<xsl:param name="node" select="$xml/t:terms/t:term[@id=$id]" />
	<xsl:param name="type" select="./@type" />
	
	<xsl:choose>
		<xsl:when test="$type='total'">
			<xsl:apply-templates select="$node/t:name/t:ch" />
			<xsl:text>〔</xsl:text>
				<xsl:apply-templates select="$node/t:name/t:en" />
				<xsl:if test="$node/t:name/t:en_abbr">
					<xsl:text>, </xsl:text><xsl:apply-templates select="$node/t:name/t:en_abbr" />
				</xsl:if>
			<xsl:text>〕</xsl:text>
		</xsl:when>
		<xsl:when test="$type='ch'">
			<xsl:apply-templates select="$xml/t:terms/t:term[@id=$id]/t:name/t:ch" />
		</xsl:when>
		<xsl:when test="$type='en'">
			<xsl:apply-templates select="$xml/t:terms/t:term[@id=$id]/t:name/t:en" />
		</xsl:when>
		<xsl:when test="$type='en_abbr'">
			<xsl:apply-templates select="$xml/t:terms/t:term[@id=$id]/t:name/t:en_abbr" />
		</xsl:when>
		<xsl:when test="$type='test'">
			<xsl:copy select="$xml/t:terms/t:term[@id=$id]/t:name/t:ch" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>\[\]</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="gen:names">
	<xsl:param name="xlink" select="./@xlink:href" />
	<xsl:param name="xml" select="document(substring-before($xlink,'#'))" />
	<xsl:param name="id" select="substring-after($xlink,'#')" />
	<xsl:param name="node" select="$xml/t:terms/t:term[@id=$id]" />
	<xsl:param name="type" select="./@type" />
	
	<xsl:choose>
		<xsl:when test="$type='total'">
			<xsl:apply-templates select="$node/t:name/t:ch" />
			<xsl:text>〔</xsl:text>
				<xsl:apply-templates select="$node/t:name/t:en" />
				<xsl:if test="$node/t:name/t:en_abbr">
					<xsl:text>, </xsl:text><xsl:apply-templates select="$node/t:name/t:en_abbr" />
				</xsl:if>
			<xsl:text>〕</xsl:text>
		</xsl:when>
		<xsl:when test="$type='ch'">
			<xsl:apply-templates select="$xml/t:terms/t:term[@id=$id]/t:name/t:ch" />
		</xsl:when>
		<xsl:when test="$type='en'">
			<xsl:apply-templates select="$xml/t:terms/t:term[@id=$id]/t:name/t:en" />
		</xsl:when>
		<xsl:when test="$type='en_abbr'">
			<xsl:apply-templates select="$xml/t:terms/t:term[@id=$id]/t:name/t:en_abbr" />
		</xsl:when>
		<xsl:when test="$type='test'">
			<xsl:apply-templates select="$xml/t:terms/t:term[@id=$id]/t:name/t:ch" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>\[\]</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="gen:link">
	<a href="{./@xlink:href}"><xsl:apply-templates /></a>
</xsl:template>

<xsl:template match="gen:comment">
	<xsl:text>【譯注︰</xsl:text><xsl:apply-templates /><xsl:text>】</xsl:text>
</xsl:template>
</xsl:stylesheet>
