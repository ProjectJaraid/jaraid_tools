<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:pj="https://projectjaraid.github.io/ns"
    xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs pj"
    version="3.0">
    <xsl:output encoding="UTF-8" indent="yes" omit-xml-declaration="no" method="xml"/>
    <xsl:include href="convert_tei-row-to-biblstruct_functions.xsl"/>
    
    <xsl:param name="p_id-change" select="generate-id(//tei:change[last()])"/>
    
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
   <!-- <xsl:template match="text()">
        <xsl:value-of select="normalize-space(.)"/>
    </xsl:template>-->
    
    <!-- transform tables to listBibl -->
    <xsl:template match="tei:table">
        <xsl:element name="listBibl">
            <xsl:apply-templates select="tei:row">
                <xsl:sort select="pj:getDate(tei:cell[1]/tei:date[1])" data-type="text"/>
                <xsl:sort select="tei:cell[4]"/>
            </xsl:apply-templates>
        </xsl:element>
    </xsl:template>
    
    <!-- transform rows into biblStruct -->
    <xsl:template match="tei:row[@role='data']">            
                <xsl:copy-of select="pj:transform-row-to-biblstruct(.)"/>
    </xsl:template>
    
    <xsl:template match="tei:table/tei:head | tei:row[@role='label']"/>
    
    <!-- generate documentation of change -->
    <xsl:template match="tei:revisionDesc">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:element name="tei:change">
                <xsl:attribute name="when"
                    select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>
                <xsl:attribute name="xml:lang" select="'en'"/>
                <xsl:attribute name="xml:id" select="$p_id-change"/>
                <xsl:text>Converted tabular bibliographic data to lists of </xsl:text><tei:gi>biblStruct</tei:gi><xsl:text>.</xsl:text>
            </xsl:element>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>