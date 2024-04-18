<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"    
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    >
    <xsl:output method="html"  encoding="UTF-8" indent="yes"/>
    
    <!-- v3d: reference to new subpage "contributors" as part of templLegend
        - changed the second map to the Simile map -->
    
    <xsl:template name="templTOCDiv">
        <html>
            <xsl:call-template name="templHead"/>
            <body>
                <div id="dTOC">
                    <p><a href="../HTML/index.html" target="_parent" class="rubriksubline">Introduction</a></p>
                    <p><a href="../HTML/tabddchr.html" target="fMain" class="rubriksubline">Chronology of Periodicals</a></p>
                    <p><a href="../HTML/tabud.html" target="fMain" class="rubriksubline">Undated Periodicals</a></p>
                    <xsl:call-template name="templIndexes"/>
                    <xsl:call-template name="templLegend"/>
                    <div class="ja-hidden">
                    <p class="rubriksubline">Experimental features</p>
                    <ul>
                        <li><a href="../Visualization/GoogleGeoChart.html" target="fMain" class="seitennav">Map of Locations</a></li>
                        <!-- <li><a href="../TEI/master-current.xml" target="Window" class="seitennav">XML Source</a></li> -->
                        <li><a href="../HTML/ilgd.html" target="fMain" class="seitennav">Languages other than Arabic</a></li>
                    </ul>
                    </div>
                    <xsl:call-template name="templUpdate"/>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template name="templTOCDiv2">
        <html>
            <xsl:call-template name="templHead"/>
            <body>
                <div id="dTOC">
                    <p><a href="../HTML/index2.html" target="_parent" class="rubriksubline">Introduction</a></p>
                    <p><a href="../HTML/tabddchr.html" target="fMain" class="rubriksubline">Chronology of Periodicals</a></p>
                    <p><a href="../HTML/tabud.html" target="fMain" class="rubriksubline">Undated Periodicals</a></p>
                    <p class="rubriksubline">Indexes</p>
                    <ul>
                        <li><a href="../HTML/iprsd.html" target="fMain" class="seitennav">Persons</a></li>
                        <li><a href="../HTML/iorgd.html" target="fMain" class="seitennav">Organizations</a></li>
                        <li><a href="../HTML/ilocd.html" target="fMain" class="seitennav">Locations</a></li>
                        <li><a href="../HTML/ittld.html" target="fMain" class="seitennav">Periodicals</a></li>
                        <li><a href="../HTML/ilibd.html" target="fMain" class="seitennav">Holding Institutions</a></li>
                    </ul>
                    <xsl:call-template name="templLegend"/>
                    <div class="ja-hidden">
                        <p class="rubriksubline">Experimental features</p>
                        <ul>
                            <li><a href="../Visualization/GoogleGeoChart.html" target="fMain" class="seitennav">Map: GoogleChart</a></li>
                            <li><a href="../Visualization/SimileMap.html" target="fMain" class="seitennav">Map: SIMILE Exhibit</a></li>
                            <li><a href="../Visualization/timeline-2bands.html" target="fMain" class="seitennav">Timeline</a></li>
                            <li><a href="../TEI/master-current.xml" target="Window" class="seitennav">XML Source</a></li>
                            <li><a href="../HTML/ilgd.html" target="fMain" class="seitennav">Languages other than Arabic</a></li>
                        </ul>
                    </div>
                    <xsl:call-template name="templUpdate"/>
                    
                </div>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template name="templHead">
        <head>
            <title>TOC</title>
            <link rel="stylesheet" href="..//CSS/zmo.css" type="text/css"/>
            <link rel="stylesheet" href="..//CSS/zmo_jaraid.css" type="text/css"/>
            <link rel="stylesheet" href="https://projectjaraid.github.io/CSS/ja-hidden visible.css" type="text/css"/>
        </head>
    </xsl:template>
    <xsl:template name="templIndexes">
        <p class="rubriksubline">Indexes</p>
        <ul>
            <li><a href="../HTML/iprsd.html" target="fMain" class="seitennav">Persons</a></li>
            <li><a href="../HTML/iorgd.html" target="fMain" class="seitennav">Organizations</a></li>
            <li><a href="../HTML/ilocd.html" target="fMain" class="seitennav">Locations</a></li>
            <!-- <li><a href="../HTML/ittld.html" target="fMain" class="seitennav">Periodicals</a></li> -->
            <li><a href="../HTML/ilibd.html" target="fMain" class="seitennav">Holding Institutions</a></li>
        </ul>
    </xsl:template>
    <xsl:template name="templLegend">
        <p><a href="../HTML/abbr.html" target="fMain" class="seitennav">Abbreviations of holding institutions</a></p>
        <p><a href="../HTML/intro.html#dAgen" target="fMain" class="seitennav">Legend</a></p>
        <p><a href="../HTML/intro.html#dBibl" target="fMain" class="seitennav">Bibliography</a></p>
        <p><a href="../HTML/contr.html" target="fMain" class="seitennav">Contributors</a></p>
        <p><a href="../HTML/contact.html" target="fMain" class="seitennav">Submit comments</a></p>
    </xsl:template>
    <xsl:template name="templMainContent">
        <p><a href="../HTML/tabdd.html" target="fMain" class="rubriksubline">Chronology of Periodicals</a></p>
        <p><a href="../HTML/tabud.html" target="fMain" class="rubriksubline">Undated Periodicals</a></p>
    </xsl:template>
    
    <xsl:template name="templUpdate">
        <xsl:if test="ancestor::tei:TEI//revisionDesc//item">
            <xsl:variable name="vLastItem" select="((.//revisionDesc//item) [last()])"/>
            <xsl:variable name="vLastDate" select="$vLastItem/date/@when"/>
            <p style="color:red">
                <span>
                    <xsl:attribute name="title">
                        <xsl:value-of select="$vLastItem"/>
                    </xsl:attribute>
                    <xsl:text>Latest Update: </xsl:text><xsl:value-of select="$vLastDate"/>
                </span>
            </p>
        </xsl:if>
        <xsl:if test="ancestor::tei:TEI//revisionDesc/change">
            <xsl:variable name="vLastItem" select=".//revisionDesc/change[max(@when)]"/>
            <xsl:variable name="vLastDate" select="$vLastItem/@when"/>
            <p style="color:red">
                <span>
                    <xsl:attribute name="title">
                        <xsl:value-of select="$vLastItem"/>
                    </xsl:attribute>
                    <a href="../HTML/rev.html" target="fMain">Latest Update: </a>
                    <xsl:value-of select="$vLastDate"/>
                </span>
                <a href="../RSS/rss-jaraid.xml" target="_blank"><img src="..//Media/rss.gif" style="width:10px;height:10px"></img></a>
            </p>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>