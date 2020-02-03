<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs pj" version="3.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:pj="https://projectjaraid.github.io/ns" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output encoding="UTF-8" indent="yes" method="xml" omit-xml-declaration="no"/>
    <!-- identity transform -->
    <xsl:template match="@* | node()" mode="m_identity-transform">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" mode="m_identity-transform"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="text()" mode="m_plain-text">
        <xsl:value-of select="normalize-space(.)"/>
    </xsl:template>
    
    
    <!-- transform rows into biblStruct -->
    <xsl:function name="pj:transform-row-to-biblstruct">
        <xsl:param name="tei_row"/>
        <biblStruct xml:id="biblStruct_{$tei_row/@xml:id}">
                    <monogr>
                        <!-- title(s) -->
                        <xsl:apply-templates mode="m_bibl" select="$tei_row/tei:cell[@n=4]/tei:name"/>
                        <!-- language -->
                        <!-- the basis for inclusion in al-Jarāʾid is a periodical being published in Arabic -->
                        <textLang mainLang="ar">
                            <xsl:if test="$tei_row/descendant::tei:lang">
                                <xsl:attribute name="otherLangs">
                                    <xsl:for-each select="$tei_row/descendant::tei:lang">
                                        <xsl:value-of select="pj:translate-language-codes(.)"/>
                                        <xsl:if test="following-sibling::tei:lang">
                                            <xsl:text> </xsl:text>
                                        </xsl:if>
                                    </xsl:for-each>
                                </xsl:attribute>
                            </xsl:if>
                        </textLang>
                        <!-- editor(s) -->
                        <xsl:apply-templates mode="m_bibl" select="$tei_row/tei:cell[@n=6]/tei:persName"/>
                        <imprint>
                            <!-- publisher -->
                            <xsl:apply-templates mode="m_bibl" select="$tei_row/tei:cell[@n=6]/tei:orgName"/>
                            <!-- place of publication -->
                            <xsl:apply-templates mode="m_bibl" select="$tei_row/tei:cell[@n=5]/tei:placeName"/>
                            <!-- date of publication -->
                            <xsl:apply-templates mode="m_bibl" select="$tei_row/tei:cell[@n=1]/tei:date"/>
                            <xsl:apply-templates mode="m_bibl" select="$tei_row/tei:cell[@n=3]/tei:date"/>
                        </imprint>
                    </monogr>
                </biblStruct>
    </xsl:function>
    <!-- transform languages to BCP47-->
    <xsl:function name="pj:translate-language-codes">
        <xsl:param name="tei_text"/>
        <xsl:choose>
            <xsl:when test="$tei_text = 'Armenian'">
                <xsl:text>hy</xsl:text>
            </xsl:when>
            <xsl:when test="$tei_text = 'colloquial Arabic'">
                <!-- all periodicals marked as such are from Egypt. Thus, we use arz -->
                <xsl:text>arz</xsl:text>
            </xsl:when>
            <xsl:when test="$tei_text = 'Coptic'">
                <xsl:text>cop</xsl:text>
            </xsl:when>
            <xsl:when test="$tei_text = 'English'">
                <xsl:text>en</xsl:text>
            </xsl:when>
            <xsl:when test="$tei_text = 'French'">
                <xsl:text>fr</xsl:text>
            </xsl:when>
            <xsl:when test="$tei_text = 'Greek'">
                <xsl:text>gr</xsl:text>
            </xsl:when>
            <xsl:when test="$tei_text = 'Hebrew'">
                <xsl:text>he</xsl:text>
            </xsl:when>
            <xsl:when test="$tei_text = 'Italian'">
                <xsl:text>it</xsl:text>
            </xsl:when>
            <xsl:when test="$tei_text = 'Judeo-Arabic'">
                <xsl:text>jrb</xsl:text>
            </xsl:when>
            <xsl:when test="$tei_text = 'Ottoman Turkish'">
                <xsl:text>ota</xsl:text>
            </xsl:when>
            <xsl:when test="$tei_text = 'Persian'">
                <xsl:text>fa</xsl:text>
            </xsl:when>
            <xsl:when test="$tei_text = 'Portuguese'">
                <xsl:text>pt</xsl:text>
            </xsl:when>
            <!-- fallback: -->
            <xsl:otherwise>
                <xsl:value-of select="$tei_text"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    <!-- dates -->
    <xsl:template match="tei:cell[@n=1]/tei:date" mode="m_bibl">
        <xsl:copy>
            <xsl:attribute name="type" select="'onset'"/>
            <xsl:apply-templates select="@* | node()" mode="m_identity-transform"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="tei:cell[@n=3]/tei:date" mode="m_bibl">
        <xsl:copy>
            <xsl:attribute name="type" select="'terminus'"/>
            <xsl:apply-templates select="@* | node()" mode="m_identity-transform"/>
        </xsl:copy>
    </xsl:template>
    <!-- titles -->
    <xsl:template match="tei:cell[@n=4]/tei:name" mode="m_bibl">
        <title level="j" xml:lang="ar-Latn-x-ijmes">
            <xsl:apply-templates mode="m_plain-text"/>
        </title>
    </xsl:template>
    <xsl:template match="tei:cell[@n=5]/tei:placeName" mode="m_bibl">
        <pubPlace>
            <xsl:copy>
                <xsl:attribute name="xml:lang">
                    <xsl:choose>
                        <xsl:when test="@xml:lang">
                            <xsl:value-of select="@xml:lang"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>en</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:apply-templates mode="m_plain-text"/>
            </xsl:copy>
        </pubPlace>
    </xsl:template>
    <xsl:template match="tei:cell[@n=6]/tei:orgName" mode="m_bibl">
        <publisher>
            <xsl:copy>
                <xsl:attribute name="xml:lang">
                    <xsl:choose>
                        <xsl:when test="@xml:lang">
                            <xsl:value-of select="@xml:lang"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>en</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:apply-templates mode="m_plain-text"/>
            </xsl:copy>
        </publisher>
    </xsl:template>
    <xsl:template match="tei:cell[@n=6]/tei:persName" mode="m_bibl">
        <editor>
            <xsl:copy>
                <xsl:attribute name="xml:lang" select="'ar-Latn-x-ijmes'"/>
                <xsl:apply-templates mode="m_plain-text"/>
            </xsl:copy>
        </editor>
    </xsl:template>
</xsl:stylesheet>