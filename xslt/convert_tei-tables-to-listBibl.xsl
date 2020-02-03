<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:pj="https://projectjaraid.github.io/ns"
    xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs pj"
    version="2.0">
    <xsl:output encoding="UTF-8" indent="yes" omit-xml-declaration="no" method="xml"/>
    <xsl:include href="convert_tei-row-to-biblstruct_functions.xsl"/>
    
    <xsl:template match="/">
<!--        <xsl:apply-templates select="descendant::tei:body/descendant::tei:table"/>-->
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="text()">
        <xsl:value-of select="normalize-space(.)"/>
    </xsl:template>
    
    
    <!-- transform tables to listBibl -->
    <xsl:template match="tei:table">
        <xsl:element name="listBibl">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <!-- transform rows into biblStruct -->
    <xsl:template match="tei:row[@role='data']">            
                <xsl:copy-of select="pj:transform-row-to-biblstruct(.)"/>
    </xsl:template>
    
    <xsl:template match="tei:table/tei:head | tei:row[@role='label']"/>
</xsl:stylesheet>