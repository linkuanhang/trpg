<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:math="http://www.w3.org/1998/Math/MathML" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:b="begin" xmlns:gen="general" xmlns:com="common" xmlns:talk="talk" xmlns:cre="create" xmlns:ga="generate_ability" xmlns:db="determine_bonus" xmlns:abi="ability">

<xsl:import href="/pathfinder/static/xml/base.xsl" />

<xsl:output method="html" encoding="utf-8" doctype-system="about:legacy-compat" indent="yes" media-type="application/xhtml+xml" />

<xsl:template match="b:begin">
	<xsl:call-template name="page">
		<xsl:with-param name="title" select="b:title" />
		<xsl:with-param name="pageTitle" select="b:title" />
		<xsl:with-param name="nav" select="document('/pathfinder/navbar.xml')" />
		<xsl:with-param name="page" select="b:paragraphs" />
		<xsl:with-param name="initDepth" select="1" />
	</xsl:call-template>
</xsl:template>

<xsl:template match="b:paragraphs">
	<xsl:param name="depth" />
	
	<xsl:apply-templates>
		<xsl:with-param name="depth" select="$depth" />
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="b:paragraph">
	<xsl:param name="depth" />
	
	<xsl:choose>
		<xsl:when test="b:title">
			<xsl:call-template name="section">
				<xsl:with-param name="title" select="b:title" />
				<xsl:with-param name="depth" select="$depth" />
				<xsl:with-param name="articles" select="b:contains" />
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates>
				<xsl:with-param name="depth" select="$depth" />
			</xsl:apply-templates>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="b:contains">
	<xsl:param name="depth" />
	
	<xsl:apply-templates>
		<xsl:with-param name="depth" select="$depth" />
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="b:contain">
	<xsl:param name="depth" />
	
	<xsl:choose>
		<xsl:when test="b:paragraphs">
			<xsl:apply-templates>
				<xsl:with-param name="depth" select="$depth" />
			</xsl:apply-templates>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="paragraph" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="gen:name">
	<xsl:choose>
		<xsl:when test="@type='total'">
			<xsl:call-template name="glossary">
				<xsl:with-param name="href" select="@xlink:href" />
				<xsl:with-param name="type" select="'name'" />
				<xsl:with-param name="lang">zh-tw</xsl:with-param>
			</xsl:call-template>
			<xsl:text>〔</xsl:text>
			<xsl:call-template name="glossary">
				<xsl:with-param name="href" select="@xlink:href" />
				<xsl:with-param name="type" select="'name'" />
				<xsl:with-param name="lang">en</xsl:with-param>
			</xsl:call-template>
			<xsl:text>〕</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="glossary">
				<xsl:with-param name="href" select="@xlink:href" />
				<xsl:with-param name="type" select="'name'" />
				<xsl:with-param name="lang">
					<xsl:choose>
						<xsl:when test="@type='ch'">zh-tw</xsl:when>
						<xsl:otherwise><xsl:value-of select="@type" /></xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="math:*">
	<xsl:copy-of select="." />
</xsl:template>

<xsl:template match="com:terms">
	<xsl:for-each select="com:term">
		<p>
			<xsl:if test="com:name">
				<b><xsl:apply-templates select="com:name" /></b>
				<xsl:text>︰</xsl:text>
			</xsl:if>
			<xsl:for-each select="com:descriptions/com:description">
				<xsl:apply-templates />
			</xsl:for-each>
		</p>
	</xsl:for-each>
</xsl:template>

<xsl:template match="cre:steps">
	<ol style="list-style-type:cjk-ideographic;">
		<xsl:for-each select="cre:step">
			<li>
				<b><xsl:apply-templates select="cre:title" /></b>
				<xsl:text>︰</xsl:text>
				<xsl:apply-templates select="cre:description" />
			</li>
		</xsl:for-each>
	</ol>
</xsl:template>

<xsl:template match="ga:methods">
	<xsl:for-each select="ga:method">
		<p>
			<b><xsl:apply-templates select="ga:name" /></b>
			<xsl:text>︰</xsl:text>
			<xsl:for-each select="ga:descriptions/ga:description">
				<xsl:choose>
					<xsl:when test="position()!=1">
						<p><xsl:apply-templates /></p>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</p>
	</xsl:for-each>
</xsl:template>

<xsl:template match="ga:purchase_points">
	<table class="w3-table w3-border w3-bordered">
		<thead class="w3-grey">
			<tr>
				<xsl:for-each select="ga:heads/ga:head">
					<th><xsl:apply-templates /></th>
				</xsl:for-each>
			</tr>
		</thead>
		<tbody>
			<xsl:for-each select="ga:point">
				<tr>
					<td><xsl:apply-templates select="ga:ability" /></td>
					<td><xsl:apply-templates select="ga:purchase_point" /></td>
				</tr>
			</xsl:for-each>
		</tbody>
	</table>
</xsl:template>

<xsl:template match="ga:fantasies">
	<table class="w3-table w3-border w3-bordered">
		<thead class="w3-grey">
			<tr>
				<xsl:for-each select="ga:heads/ga:head">
					<th><xsl:apply-templates /></th>
				</xsl:for-each>
			</tr>
		</thead>
		<tbody>
			<xsl:for-each select="ga:fantasy">
				<tr>
					<td><xsl:apply-templates select="ga:name" /></td>
					<td><xsl:apply-templates select="ga:point" /></td>
				</tr>
			</xsl:for-each>
		</tbody>
	</table>
</xsl:template>

<xsl:template match="db:scores">
	<table class="w3-table w3-border w3-bordered">
		<thead class="w3-grey">
			<tr>
				<xsl:for-each select="db:heads/db:head">
					<th><xsl:apply-templates /></th>
				</xsl:for-each>
			</tr>
		</thead>
		<tbody>
			<xsl:for-each select="db:score">
				<tr>
					<td><xsl:apply-templates select="db:value" /></td>
					<td><xsl:apply-templates select="db:mod" /></td>
					<xsl:choose>
						<xsl:when test="db:spells">
							<xsl:for-each select="db:spells/db:spell">
								<td><xsl:apply-templates /></td>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<td colspan="10"><xsl:text>無法施法</xsl:text></td>
						</xsl:otherwise>
					</xsl:choose>
				</tr>
			</xsl:for-each>
		</tbody>
	</table>
</xsl:template>

<xsl:template match="abi:abilities">
	<xsl:for-each select="abi:ability">
		<h6><xsl:apply-templates select="abi:name" /></h6>
		
		<xsl:for-each select="abi:descriptions/abi:description">
			<p><xsl:apply-templates /></p>
		</xsl:for-each>
		
		<ul>
			<xsl:for-each select="abi:uses/abi:use">
				<li><xsl:apply-templates /></li>
			</xsl:for-each>
		</ul>
		
		<xsl:if test="abi:mark">
			<p><xsl:apply-templates select="abi:mark" /></p>
		</xsl:if>
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
