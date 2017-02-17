<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:books="books" xmlns:gen="general"
	xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/1999/xhtml">

<xsl:import href="/pathfinder/static/xml/general.xsl" />

<xsl:template match="books:books">
	<nav class="w3-sidenav w3-collapse" style="width:200px;">
		<a href="javascript:void(0)" onclick="w3_close(this)" class="w3-closenav w3-large w3-hide-large">關閉 &#215;</a>
		<a href="/pathfinder/index.xml" class="w3-hover-none" ><img src="/pathfinder/static/img/PRD-Logo.png" alt="Pathfinder RPG" width="95%" /></a>
		<xsl:apply-templates />
	</nav>
	
	<script type="text/javascript">
	function w3_open() {
		$(".w3-sidenav.w3-collapse").css("display","block");
	}
	function w3_close(node) {
		$(node).parent("nav").css("display","none");
	}
	</script>
</xsl:template>

<xsl:template match="books:book">
	<h4><xsl:value-of select="books:name" /></h4>
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
</xsl:template>
</xsl:stylesheet> 
