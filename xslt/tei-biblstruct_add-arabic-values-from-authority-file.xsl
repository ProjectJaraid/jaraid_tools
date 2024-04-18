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
    <xsl:include href="functions.xsl"/>
    
    <xsl:param name="p_string-separator" select="' / '" as="xs:string"/>
    
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- identity transform -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:editor">
        <xsl:copy>
            <!-- identity transform -->
            <xsl:apply-templates select="@* | node()"/>
            <!-- add Arabic child from authority file -->
            <xsl:variable name="v_additional-name" select="pj:entity-names_get-version-from-authority-file(tei:persName, $v_file-entities-master, 'jaraid', 'ar')"/>
            <xsl:copy-of select="$v_additional-name"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:publisher">
        <xsl:copy>
            <!-- identity transform -->
            <xsl:apply-templates select="@* | node()"/>
            <!-- add Arabic child from authority file -->
            <xsl:variable name="v_additional-name" select="pj:entity-names_get-version-from-authority-file(tei:orgName, $v_file-entities-master, 'jaraid', 'ar')"/>
            <xsl:copy-of select="$v_additional-name"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="tei:pubPlace">
        <xsl:copy>
            <!-- identity transform -->
            <xsl:apply-templates select="@* | node()"/>
            <!-- add Arabic child from authority file -->
            <xsl:variable name="v_additional-name" select="pj:entity-names_get-version-from-authority-file(tei:placeName, $v_file-entities-master, 'jaraid', 'ar')"/>
            <xsl:copy-of select="$v_additional-name"/>
        </xsl:copy>
    </xsl:template>

    
    
    <!-- generate documentation of change -->
    <!-- NOTE: as this XSLT is used by a GitHub action, it is frequently run and will infest the master files with <change> nodes. I, therefore removed the documentation -->
    <!-- <xsl:template match="tei:revisionDesc" priority="100">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:element name="change">
                <xsl:attribute name="when"
                    select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>
                <xsl:attribute name="who" select="concat('#', $p_id-editor)"/>
                <xsl:attribute name="xml:id" select="$p_id-change"/>
                <xsl:attribute name="xml:lang" select="'en'"/>
                <xsl:text>Updated Arabic content of rows 11 and 12 based on recent changes to the authority file</xsl:text>
            </xsl:element>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template> -->
</xsl:stylesheet>