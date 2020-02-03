<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs pj" version="3.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:pj="https://projectjaraid.github.io/ns" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output encoding="UTF-8" indent="yes" method="xml" omit-xml-declaration="no"/>
    
    <xsl:include href="convert_tei-row-to-biblstruct_functions.xsl"/>
    <!-- identity transform -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- transform rows into biblStruct -->
    <xsl:template match="tei:row[@role='data']">
        <xsl:copy>
            <!-- replicate existing columns -->
            <xsl:apply-templates select="@* | node()"/>
            <!-- add column with biblStruct -->
            <cell n="10">
                <xsl:copy-of select="pj:transform-row-to-biblstruct(.)"/>
            </cell>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>