<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all"
    >
    <xsl:output method="html" omit-xml-declaration="no" encoding="UTF-8" indent="yes"/>
    
    <!-- v1b: production version submitted to the ZMO -->
    
<!-- tei:persName -->
    <xsl:template match="persName" mode="mCopy">
        <!-- formatting could be changed / abandoned -->
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="persName[not(@ref)]" mode="mSpan">
        <span class="ja-unknown">
            <xsl:apply-templates/>
            <span class="ja-hidden">
                <xsl:text>DON'T KNOW THIS PERSON</xsl:text>
            </span>
        </span>
    </xsl:template>
    <xsl:template match="persName[starts-with(@ref,'#')]" mode="mSpan">
        <span class="ja-known">
            <xsl:apply-templates/>
            <span class="ja-hidden">
                <xsl:for-each select="//person[@xml:id=substring-after(current()/@ref,'#')]">
                    <xsl:value-of select="persName"/>
                    <xsl:text>: b. </xsl:text>
                    <xsl:value-of select="birth/@when"/>
                    <xsl:text>: d. </xsl:text>
                    <xsl:value-of select="death/@when"/>
                </xsl:for-each>
            </span>
        </span>
    </xsl:template>

<!-- tei:rs links -->
    <xsl:template match="rs[starts-with(@ref,'#')]" name="templLink" mode="mCopy">
        <span class="ja-intlink">
            <xsl:apply-templates mode="mCopy"/>
            <span class="ja-hidden">
                <xsl:for-each select="//p[@xml:id=substring-after(current()/@ref,'#')]//expan">
                    <xsl:value-of select="."/>
                </xsl:for-each>
            </span>
        </span>
    </xsl:template>
<!-- tei:ref links -->
    <xsl:template match="ref" mode="mCopy">
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="./@target"/>
            </xsl:attribute>
            <xsl:attribute name="target">
                <xsl:text>_blank</xsl:text>
            </xsl:attribute>
            <xsl:if test=".=''">
                <xsl:text> (online)</xsl:text>
            </xsl:if>
            <xsl:apply-templates mode="mCopy"/>
        </xsl:element>
    </xsl:template>

<!-- tei:del -->
    <xsl:template match="del" mode="mCopy">
    </xsl:template>
    <xsl:template match="del" mode="mSpan">
    </xsl:template>
    <xsl:template match="del">
        <xsl:text> DELETED </xsl:text>
    </xsl:template>
    
    <!-- tei:orgName -->
    <xsl:template match="orgName" mode="mCopy">
        <xsl:copy-of select="."/>
    </xsl:template> 
    <xsl:template match="orgName" mode="mSpan">
        <xsl:copy-of select="."/>
    </xsl:template> 
    <!-- tei:placeName -->
    <xsl:template match="placeName" mode="mCopy">
        <xsl:copy-of select="."/>
    </xsl:template> 
    <xsl:template match="placeName" mode="mSpan">
        <xsl:copy-of select="."/>
    </xsl:template>  
    <!-- tei:name -->
    <xsl:template match="name" mode="mCopy">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="name" mode="mSpan">
        <xsl:copy-of select="."/>
    </xsl:template>
    <!-- tei:date -->
    <xsl:template match="date" mode="mCopy">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="date" mode="mSpan">
        <xsl:copy-of select="."/>
    </xsl:template>
    <!-- tei:p -->
    <xsl:template name="templP" match="p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    <!-- <xsl:template match="p" mode="mCopy">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="p" mode="mSpan">
        <xsl:copy-of select="."/>
    </xsl:template> -->
    <!-- tei:head -->
    <xsl:template match="head" mode="mCopy">
    </xsl:template>    
    <xsl:template match="head" mode="mSpan">
    </xsl:template>
    
    <!-- tei:rend -->
    <xsl:template match="hi">
        <xsl:if test=".[@rend='italic']">
            <i>
                <xsl:value-of select="."/>
            </i>
        </xsl:if>
    </xsl:template>

    
</xsl:stylesheet>