<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"    
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    >
    <xsl:output method="html"  encoding="UTF-8" indent="yes"/>
    
    <!-- This stylesheet creates milestones/ anchors for every decade to be used for a navigation pane. As I produce static HTML pages, these anchors must be coded into the page and cannot be produced by a script evaluating the content of this webpage. -->
    <!-- At some future point an automatic integer should be added to the end of the anchor to generat unique IDs. At the moment every year 1900 will produce "xD-1900" -->
    
    <xsl:template name="templAnchDate"> 
        <xsl:for-each select=".//ancestor-or-self::row[@role='data']">
        <!-- <xsl:sort select="concat(child::cell[@n='1']/date/@when, child::cell[@n='1']/date/@notAfter)"/> -->
           
            <xsl:variable name="vDate" select="concat(child::cell[@n='1']/date/@when, child::cell[@n='1']/date/@notAfter)"/>
            
            <!-- <xsl:variable name="vDate10">
                <xsl:if test="substring($vDate,4,1)='0'">
                  <xsl:value-of select="$vDate"/>
                </xsl:if>
            </xsl:variable>
            <xsl:variable name="vDate5">
                <xsl:if test="substring($vDate,4,1)='5'">
                    <xsl:value-of select="$vDate"/>
                </xsl:if>
            </xsl:variable>

            <xsl:if test="string($vDate)=string($vDate10) or string($vDate5)"> -->
            <xsl:element name="a">
                <xsl:attribute name="id">
                    <xsl:text>xD-</xsl:text>
                    <xsl:value-of select="substring($vDate,1,4)"/>
                </xsl:attribute>
                
            </xsl:element>
            <!-- </xsl:if> -->
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="templTNavAnchor">
        <xsl:param name="pURL">
            <xsl:text>#xD-</xsl:text>
        </xsl:param>
        <div id="sidenav2">
            <div class="ja-pic">&#160;</div>
            <div>
                <p class="rubriksubline">Jump to: </p>
                <p class="ja-link decade"><a href="{$pURL}1800">1800</a></p>
                <p class="ja-link decade"><a href="{$pURL}1860">1860</a></p>
                <p class="ja-link decade"><a href="{$pURL}1870">1870</a></p>
                <p class="ja-link five"><a href="{$pURL}1875">1875</a></p>
                <p class="ja-link decade"><a href="{$pURL}1880">1880</a></p>
                <p class="ja-link five"><a href="{$pURL}1885">1885</a></p>
                <p class="ja-link decade"><a href="{$pURL}1890">1890</a></p>
                <p class="ja-link five"><a href="{$pURL}1895">1895</a></p>
                <p class="ja-link each"><a href="{$pURL}1896">1896</a></p>
                <p class="ja-link each"><a href="{$pURL}1897">1897</a></p>
                <p class="ja-link each"><a href="{$pURL}1898">1898</a></p>
                <p class="ja-link each"><a href="{$pURL}1899">1899</a></p>
                <p class="ja-link decade"><a href="{$pURL}1900">1900</a></p>
            </div>
        </div>
    </xsl:template>


<!--     <xsl:template name="templAnchLoc">
        <xsl:for-each select="self::placeName">
            <xsl:element name="a">
                <xsl:attribute name="id">
                    <xsl:text>xL-</xsl:text>
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="templAnchPers">
        <xsl:for-each select="persName">
            <xsl:element name="a">
                <xsl:attribute name="id">
                    <xsl:text>xP-</xsl:text>
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="templAnchOrg">
        <xsl:for-each select="orgName">
            <xsl:element name="a">
                <xsl:attribute name="id">
                    <xsl:text>xO-</xsl:text>
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:element>
        </xsl:for-each>
    </xsl:template> -->

</xsl:stylesheet>