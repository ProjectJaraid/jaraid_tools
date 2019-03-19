<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:atom="http://www.w3.org/2005/Atom"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output encoding="UTF-8" indent="yes" method="xml" omit-xml-declaration="no" version="1.0"/>

    <!-- This stylesheet will generate RSS feed XML files from the revisionDesc of the TEI file and additional files on the website-->
    <!-- rss-data.xml documents the changes made to the data of the TEI master file-->
    <!-- rss-website.xml is a manually updated RSS file documenting the changes made to our web interface that differentiates between official and beta releases as @type ("official" or "beta") attribute on the item level -->
    <!-- rss-jaraid.xml is the aggregate of both files into one -->

    <xsl:template match="tei:TEI">
        <xsl:result-document href="..//RSS/rss-data.xml">
            <xsl:element name="rss">
                <xsl:attribute name="version">2.0</xsl:attribute>
                <xsl:element name="channel">
                    <xsl:call-template name="templHead"/>
                    <xsl:apply-templates select="tei:teiHeader/tei:revisionDesc/tei:change"/>
                </xsl:element>
            </xsl:element>
        </xsl:result-document>
        <xsl:result-document href="..//RSS/rss-jaraid.xml">
            <xsl:element name="rss">
                <xsl:attribute name="version">2.0</xsl:attribute>
                <xsl:element name="channel">
                    <xsl:call-template name="templHead"/>
                    <xsl:apply-templates select="tei:teiHeader/tei:revisionDesc/tei:change"/>
                    <xsl:call-template name="templWebsiteRSS"/>
                </xsl:element>
            </xsl:element>

        </xsl:result-document>
    </xsl:template>

    <xsl:template name="templHead">
        <xsl:element name="title">
            <xsl:text>Project Jarāʾid</xsl:text>
        </xsl:element>
        <xsl:element name="description">
            <xsl:value-of select=".//tei:titleStmt/tei:title"/>
        </xsl:element>
        <xsl:element name="link">
            <xsl:text>http://www.zmo.de/jaraid</xsl:text>
        </xsl:element>
        <xsl:element name="language">
            <xsl:text>en-uk</xsl:text>
        </xsl:element>
        <xsl:element name="docs">
            <xsl:text>http://www.rssboard.org/rss-specification</xsl:text>
        </xsl:element>
        <!-- there is an issue here -->
        <xsl:element name="lastBuildDate">
            <xsl:apply-templates select=".//tei:editionStmt/tei:edition/tei:date/@when"/>
        </xsl:element>
        <xsl:element name="pubDate">
            <xsl:apply-templates select=".//tei:editionStmt/tei:edition/tei:date/@when"/>
        </xsl:element>
        <xsl:element name="ttl">
            <xsl:text>60</xsl:text>
        </xsl:element>
        <xsl:element name="atom:link">
            <xsl:attribute name="href">https://projectjaraid.github.io/RSS/rss-jaraid.xml</xsl:attribute>
            <xsl:attribute name="rel">self</xsl:attribute>
            <xsl:attribute name="type">application/rss+xml</xsl:attribute>
        </xsl:element>
    </xsl:template>
    
    <!-- transform TEI documentation into RSS items -->
    <xsl:template match="tei:change">
        <xsl:element name="item">
            <xsl:attribute name="type" select="'tei'"/>
            <xsl:element name="title">
                <xsl:text>Updated data</xsl:text>
            </xsl:element>
            <!-- <xsl:element name="link"/> -->
            <xsl:element name="description">
                <xsl:value-of select="."/>
                <xsl:text>. </xsl:text>
                <xsl:apply-templates select="./@who"/>
            </xsl:element>
            <xsl:element name="pubDate">
                <!-- this is a template / variable able to translate ISO dates to RFC dates -->
                <xsl:apply-templates select="./@when"/>
            </xsl:element>
            <xsl:element name="guid">
                <xsl:text>http://www.zmo.de/jaraid#item</xsl:text>
                <!-- this is a random address  -->
                <xsl:value-of select="format-number(number(position()),'000')"/>
            </xsl:element>
            <!-- <xsl:element name="author"/> -->
        </xsl:element>
    </xsl:template>

    <xsl:template name="templWebsiteRSS">
        <xsl:copy-of select="document('https://projectjaraid.github.io/RSS/rss-website.xml')//item"/>
        <!-- somehow, I cannot address child nodes. document('..//RSS/rss-website.xml') works. I presume the reason to be that the two source files use different namespaces -->
    </xsl:template>

    <xsl:template match="@who">
        <xsl:variable name="vResp" select="substring-after(.,'#')"/>
        <xsl:text>Responsible editor: </xsl:text>
        <!-- <xsl:value-of select="//tei:persName[@xml:id=substring-after($vResp,'#')]"/> -->

        <xsl:for-each select="//tei:editionStmt//tei:persName[@xml:id = $vResp]">
            <xsl:value-of select="."/>
            <xsl:if test="position()!=last()">
                <xsl:text>, </xsl:text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="@when">
        <xsl:variable name="vDateRFC822">
            <!-- E.g. "Wed, 2 Oct 2012 08:30:00 +0200" -->
            <xsl:value-of select="format-date(.,'[F,*-3], [D1] [MNn,*-3] [Y0001]')"/>
            <!-- this produces the fake timestamp -->
            <xsl:text> 08:30:00 +0200</xsl:text>
        </xsl:variable>
        <xsl:variable name="vDateISO">
            <!-- E.g. "2012-10-02" -->
            <xsl:value-of select="format-date(.,'[Y0001]-[M01]-[D01]')"/>
        </xsl:variable>
        <xsl:value-of select="$vDateRFC822"/>
    </xsl:template>
</xsl:stylesheet>
