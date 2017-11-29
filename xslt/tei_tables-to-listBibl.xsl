<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output encoding="UTF-8" indent="yes" omit-xml-declaration="no" method="xml"/>
    
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
    
    <xsl:template match="tei:table/tei:head | tei:row[@role='label']"/>
    
    <!-- transform rows into bibls -->
    <xsl:template match="tei:row[@role='data']">
        <biblStruct>
            <monogr>
                <!-- title(s) -->
                <xsl:apply-templates select="child::tei:cell[@n=4]/tei:name"/>
                <!-- editor -->
                <xsl:apply-templates select="child::tei:cell[@n=6]/tei:persName"/>
                <imprint>
                    <!-- publisher -->
                    <xsl:apply-templates select="child::tei:cell[@n=6]/tei:orgName"/>
                    <!-- place of publication -->
                    <xsl:apply-templates select="child::tei:cell[@n=5]/tei:placeName"/>
                    <!-- date of publication -->
                    <xsl:apply-templates select="child::tei:cell[@n=1]/tei:date"/>
                    <xsl:apply-templates select="child::tei:cell[@n=3]/tei:date"/>
                </imprint>
            </monogr>
            <!-- comments -->
            <note type="comments">
                <xsl:apply-templates select="child::tei:cell[@n=7]/node()"/>
            </note>
            <!-- sources for some of the comments -->
            <note type="sources">
                <xsl:apply-templates select="child::tei:cell[@n=8]/node()"/>
            </note>
            <!-- information on holdings goes into a note -->
            <note type="holdings">
                <xsl:apply-templates select="child::tei:cell[@n=9]/node()"/>
            </note>
        </biblStruct>
    </xsl:template>
    
    <!-- dates -->
    <xsl:template match="tei:cell[@n=1]/tei:date">
        <xsl:copy>
            <xsl:attribute name="type" select="'start'"/>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="tei:cell[@n=3]/tei:date">
        <xsl:copy>
            <xsl:attribute name="type" select="'end'"/>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <!-- titles -->
    <xsl:template match="tei:cell[@n=4]/tei:name">
        <title level="j" xml:lang="ar-Latn-x-ijmes">
            <xsl:apply-templates/>
        </title>
    </xsl:template>
    <xsl:template match="tei:cell[@n=5]/tei:placeName">
        <pubPlace>
            <xsl:copy>
                <xsl:attribute name="xml:lang" select="'en'"/>
                <xsl:apply-templates/>
            </xsl:copy>
        </pubPlace>
    </xsl:template>
    <xsl:template match="tei:cell[@n=6]/tei:orgName">
        <publisher>
            <xsl:copy>
                <xsl:attribute name="xml:lang" select="'en'"/>
                <xsl:apply-templates/>
            </xsl:copy>
        </publisher>
    </xsl:template>
    <xsl:template match="tei:cell[@n=6]/tei:persName">
        <editor>
            <xsl:copy>
                <xsl:attribute name="xml:lang" select="'ar-Latn-x-ijmes'"/>
                <xsl:apply-templates/>
            </xsl:copy>
        </editor>
    </xsl:template>
    
</xsl:stylesheet>