<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="*">
        <xsl:element name="{local-name()}">
            <xsl:apply-templates select="@*[name() != 'xmlns']|node()" />
        </xsl:element>
    </xsl:template>

    <xsl:template match="text()">
        <xsl:value-of select="." />
    </xsl:template>

    <xsl:template match="@*">
        <xsl:attribute name="{local-name()}">
            <xsl:value-of select="." />
        </xsl:attribute>
    </xsl:template>
    
</xsl:stylesheet>