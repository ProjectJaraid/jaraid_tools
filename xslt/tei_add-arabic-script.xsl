<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:pj="https://projectjaraid.github.io/ns"
    xmlns:oape="https://openarabicpe.github.io/ns" 
    xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs pj"
    version="3.0">
    <xsl:output encoding="UTF-8" indent="no" omit-xml-declaration="no" method="xml"/>
    <xsl:include href="/BachUni/BachBibliothek/GitHub/OpenArabicPE/tools/xslt/functions_arabic-transcription.xsl"/>
    
    <xsl:param name="p_id-change" select="generate-id(//tei:change[last()])"/>
    
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@* | node()" mode="m_translate">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" mode="m_translate"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="@*" mode="m_duplicate">
        <xsl:copy/>
    </xsl:template>
    <xsl:template match="@xml:id" mode="m_duplicate"/>
    
    <xsl:template match="tei:standOff">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" mode="m_translate"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="node()[@xml:lang='ar-Latn-x-ijmes']" mode="m_translate">
        <xsl:variable name="v_self-arabic">
            <xsl:value-of select="oape:string-transliterate-ijmes-to-arabic(.)"/>
        </xsl:variable>
        <!-- reproduce content -->
        <xsl:copy-of select="."/>
        <!-- add arabic script -->
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="m_duplicate"/>
            <xsl:attribute name="change" select="concat('#', $p_id-change)"/>
            <xsl:attribute name="xml:lang" select="'ar'"/>
            <xsl:value-of select="normalize-space($v_self-arabic)"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- generate documentation of change -->
    <xsl:template match="tei:revisionDesc">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:element name="tei:change">
                <xsl:attribute name="when"
                    select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>
                <xsl:attribute name="xml:lang" select="'en'"/>
                <xsl:attribute name="xml:id" select="$p_id-change"/>
                <xsl:text>Automatically translated IJMES transcription of titles and names into Arabic script</xsl:text>
            </xsl:element>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>