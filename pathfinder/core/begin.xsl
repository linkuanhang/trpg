<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:math="http://www.w3.org/1998/Math/MathML" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:b="begin" xmlns:gen="general" xmlns:com="common" xmlns:talk="talk" xmlns:cre="create" xmlns:ga="generate_ability" xmlns:db="determine_bonus" xmlns:abi="ability" xmlns:t="terms">

<xsl:import href="/trpg/pathfinder/static/xml/base.xsl" />

<xsl:output method="html" encoding="utf-8" doctype-system="about:legacy-compat" indent="yes" media-type="application/xhtml+xml" />

<xsl:template match="b:begin">
	<xsl:call-template name="page">
		<xsl:with-param name="title" select="b:header/b:title[@lang='en']" />
		<xsl:with-param name="pageTitle" select="b:header/b:title" />
		<xsl:with-param name="nav" select="document('/trpg/pathfinder/navbar.xml')" />
		<xsl:with-param name="page" select="b:body/*" />
		<xsl:with-param name="initDepth" select="2" />
	</xsl:call-template>
</xsl:template>

<xsl:template match="b:section">
	<xsl:param name="depth" />
	
	<xsl:call-template name="section">
		<xsl:with-param name="title" select="b:title" />
		<xsl:with-param name="depth" select="$depth" />
		<xsl:with-param name="articles" select="*[name()!='title']" />
	</xsl:call-template>
</xsl:template>

<xsl:template match="b:article">
	<xsl:call-template name="article" />
</xsl:template>

<xsl:template match="b:paragraph">
	<xsl:call-template name="paragraph" />
</xsl:template>

<xsl:template match="com:terms">
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="com:term">
	<article>
		<p lang="en">
			<dfn style="font-style:normal;font-weight:bold;"><xsl:apply-templates select="com:name[@lang='en']" /></dfn>
			<xsl:text>: </xsl:text>
			<xsl:apply-templates select="com:description[@lang='en'][position()=1]" />
		</p>

		<p lang="zh-tw">
			<dfn style="font-style:normal;font-weight:bold;"><xsl:apply-templates select="com:name[@lang='zh-tw']" /></dfn>
			<xsl:text>︰</xsl:text>
			<xsl:apply-templates select="com:description[@lang='zh-tw'][position()=1]" />
		</p>
		
		<xsl:for-each select="com:description[@lang='zh-tw'][position() &gt; 1]|com:description[@lang='en'][position() &gt; 1]">
			<p>
				<xsl:attribute name="lang">
					<xsl:value-of select="@lang" />
				</xsl:attribute>
				<xsl:apply-templates />
			</p>
		</xsl:for-each>
	</article>
</xsl:template>

<xsl:template match="cre:steps">
	<article>
		<xsl:for-each select="cre:step">
			<p lang="en">
				<b>
					<xsl:text>Step </xsl:text>
					<xsl:value-of select="position()" />
					<xsl:text>—</xsl:text>
					<xsl:apply-templates select="cre:title[@lang='en']" />
				</b>
				<xsl:text>: </xsl:text>
				<xsl:apply-templates select="cre:description[@lang='en']" />
			</p>
			
			<p lang="zh-tw">
				<b>
					<xsl:text>步驟</xsl:text>
					<xsl:value-of select="position()" />
					<xsl:text>——</xsl:text>
					<xsl:apply-templates select="cre:title[@lang='zh-tw']" />
				</b>
				<xsl:text>︰</xsl:text>
				<xsl:apply-templates select="cre:description[@lang='zh-tw']" />
			</p>
		</xsl:for-each>
	</article>
	<!--
	<ol style="list-style-type:cjk-ideographic;">
		<xsl:for-each select="cre:step">
			<li>
				<b><xsl:apply-templates select="cre:title" /></b>
				<xsl:text>︰</xsl:text>
				<xsl:apply-templates select="cre:description" />
			</li>
		</xsl:for-each>
	</ol>
	-->
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
