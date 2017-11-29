<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"    
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    >
    <xsl:output method="html"  encoding="UTF-8" indent="yes"/>
    
    <xsl:template name="templTOC">
        <xsl:variable name="vLastItemDate" select="((.//revisionDesc//item) [last()])"/>
        <html>
            <head>
                <title>TOC</title>
                <link rel="stylesheet" href="..//CSS/zmo.css" type="text/css"/>
                <link rel="stylesheet" href="..//CSS/zmo_jaraid.css" type="text/css"/>
            </head>
            <body>
                <div id="dTOC">
                    <p><a href="../HTML/intro.html" target="fMain" class="rubriksubline">Introduction</a></p>
                    <p class="rubriksubline">Tables</p>
                    <ul>
                        <li><a href="../HTML/table-dated.html" target="fMain" class="seitennav">Chronologic Table of Periodicals</a></li>
                        <li><a href="../HTML/table-undated.html" target="fMain" class="seitennav">Undated Periodicals</a></li>
                    </ul>
                    <p class="rubriksubline">Indexes</p>
                    <ul>
                        <li><a href="../HTML/index-pers.html" target="fMain" class="seitennav">Persons</a></li>
                        <li><a href="../HTML/index-org.html" target="fMain" class="seitennav">Organizations</a></li>
                        <li><a href="../HTML/index-loc.html" target="fMain" class="seitennav">Locations</a></li>
                        <!-- <li><a href="../HTML/index-lang.html" target="fMain" class="seitennav">Languages other than Arabic</a></li> -->
                    </ul>
                    <p><a href="../HTML/abbr.html" target="fMain" class="seitennav">Abbreviations of holding institutions</a></p>
                    <p><a href="../HTML/intro.html#dAgen" target="fMain" class="seitennav">Legend</a></p>
                    <p><a href="../HTML/intro.html#dBibl" target="fMain" class="seitennav">Bibliography</a></p>
                    <p><a href="../HTML/contact.html" target="fMain" class="seitennav">Submit comments</a></p>
                    <!-- <p><a href="../TEI/master-current.xml" target="window" class="seitennav">Source file</a></p> --> 
                    <p style="color:red">
                        <span>
                            <xsl:attribute name="title">
                                <xsl:value-of select="$vLastItemDate"/>
                            </xsl:attribute>
                        <xsl:text>Last Update: </xsl:text><xsl:value-of select="$vLastItemDate/date/@when"/>
                        </span>
                    </p>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>