<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all"
    >
    <xsl:output name="zmo" method="html" doctype-public="html" omit-xml-declaration="no" encoding="UTF-8" indent="yes"/>

 <!-- This stylesheet integrates with the ZMO's DWT templates through loading all bits of code into iframes -->
 <!-- It produces a series of Html pages for the iframes -->
 <!-- v4e6 is the production version for the website published by the ZMO -->
    
    <!-- <xsl:include href="..//XSLT/HTML indexes v2d templates 120425.xsl"/> -->
    <xsl:include href="..//XSLT/HTML anchors v1b templates.xsl"/>
    <xsl:include href="..//XSLT/HTML indexes v2e templates 120530.xsl"/>
    <xsl:include href="..//XSLT/HTML indexes v4b templates.xsl"/>
    <xsl:include href="..//XSLT/HTML toc v2 templates 120615.xsl"/>
    <xsl:include href="..//XSLT/HTML toc v3a1 templates.xsl"/>
    <xsl:include href="..//XSLT/HTML tables v1a templates 120426.xsl"/>
    <xsl:include href="..//XSLT/HTML tables v4b templates.xsl"/>
    <xsl:include href="..//XSLT/HTML tei v1b templates.xsl"/> <!-- tei v2 already integrates the internal links -->
    <xsl:variable name="vgRoot" select="TEI"/>
    <xsl:variable name="vgOrg" select=".//body//orgName"/>
    <xsl:variable name="vgPers" select=".//body//persName"/>
    <xsl:variable name="vgPlace" select=".//body//cell[@n='5']/placeName"/>
    <xsl:variable name="vgLang" select=".//body//lang"/>
    <xsl:variable name="vgTitle" select=".//body//name"/>
    <xsl:variable name="vgHold" select=".//body//cell[@n='9']//rs/@ref"/>
    <xsl:variable name="sortIjmes" select="'&lt; ʾ,ʿ &lt; a,A &lt; ā, Ā &lt; b,B &lt; c,C &lt; d,D &lt; ḍ, Ḍ &lt; e,é,E,É &lt; f,F &lt; g,G &lt; ġ, Ġ &lt; h,H &lt; ḥ, Ḥ &lt; ḫ, Ḫ &lt; i,I &lt; ī, Ī  &lt; j,J &lt; k,K &lt; ḳ, Ḳ &lt; l,L &lt; m,M &lt; n,N &lt; o,O &lt; p,P &lt; q,Q &lt; r,R &lt; s,S &lt; ṣ, Ṣ &lt; t,T &lt; ṭ, Ṭ &lt; ṯ, Ṯ &lt; u,U &lt; ū, Ū &lt; v,V &lt; w,W &lt; x,X &lt; y,Y &lt; z, Z &lt; ẓ, Ẓ'"/> <!-- this variable specifies the sort order according to the IJMES transliteration of Arabic -->
    <!-- In order to ignore "al-" some substring replacement must be done, I suppose -->
    <xsl:param name="pgURLDiv" select="string('./table-dated-div.html')"/> <!-- this parameter links the indexes back to the main table I could change that to the chronologically sorted etc. -->
    <xsl:param name="pgURL" select="string('./table-dated.html')"/>
    
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="TEI">
        <xsl:result-document href="..//HTML/output/toc.html">
            <xsl:call-template name="templTOC"/>
        </xsl:result-document>
        <xsl:result-document href="..//HTML/output/toc-div.html">
            <xsl:call-template name="templTOCDiv"/>
        </xsl:result-document>
        <xsl:result-document href="..//HTML/output/toc2-div.html">
            <xsl:call-template name="templTOCDiv2"/>
        </xsl:result-document>
        
        <xsl:result-document href="..//HTML/output/abbr.html" format="zmo">
            <html>
            <head>
                <title>
                    <xsl:value-of select="teiHeader//title"/>
                </title>
                <link rel="stylesheet" href="..//CSS/zmo.css" type="text/css"></link>
                <link rel="stylesheet" href="..//CSS/zmo_jaraid.css" type="text/css"></link>
            </head>
            <body>
                <div class="ja-floattop"></div>
                <div class="ja-floatbottom"></div>
               <xsl:call-template name="templBack"/>
                <!-- <xsl:apply-templates select="./text/back/div[@type='abbr']" mode="mSort"> -->
                    <!-- Has no function <xsl:with-param name="pSort" select="div[@type='abbr']"/> -->
                <!-- </xsl:apply-templates>  -->   
            </body>
        </html>
        </xsl:result-document>
        
        <xsl:result-document href="..//HTML/output/table-dated-div.html" format="zmo">
            <!-- main table, chronologic sorting -->
            <html>
                <head>
                    <title>
                        <xsl:value-of select="teiHeader//title"/>
                    </title>
                    <link rel="stylesheet" href="..//CSS/zmo.css" type="text/css"></link>
                    <link rel="stylesheet" href="..//CSS/zmo_jaraid.css" type="text/css"></link>
                </head>
                <body>
                    <div class="ja-floattop"></div>
                    <div class="ja-floatbottom"></div>
                    <xsl:call-template name="templTNavAnchor"/>
                    <xsl:call-template name="templTableDiv">
                        <!-- <xsl:with-param name="pSort1" select="concat(child::cell[@n='1']/date/@when, child::cell[@n='1']/date/@notAfter)"/> -->
                        <xsl:with-param name="pID" select="'t1'"/>
                    </xsl:call-template> 
                </body>
            </html>
        </xsl:result-document>
        <xsl:result-document href="..//HTML/output/table-dated-chron-div.html" format="zmo">
            <!-- main table, chronologic sorting -->
            <html>
                <head>
                    <title>
                        <xsl:value-of select="teiHeader//title"/>
                    </title>
                    <link rel="stylesheet" href="..//CSS/zmo.css" type="text/css"></link>
                    <link rel="stylesheet" href="..//CSS/zmo_jaraid.css" type="text/css"></link>
                </head>
                <body>
                    <div class="ja-floatbottom"></div>
                    <xsl:call-template name="templTNavChr"/>
                    <xsl:call-template name="templTNavAnchor"/>
                    <xsl:call-template name="templTableDiv2">
                        <xsl:with-param name="pSort1" select="concat(child::cell[@n='1']/date/@when, child::cell[@n='1']/date/@notAfter)"/>
                        <xsl:with-param name="pID" select="'t1'"/>
                    </xsl:call-template> 
                </body>
            </html>
        </xsl:result-document>
        <xsl:result-document href="..//HTML/output/table-dated-alpha-div.html" format="zmo">
            <!-- main table, alphabetically sorted, navigation pane -->
            <html>
                <head>
                    <title>
                        <xsl:value-of select="teiHeader//title"/>
                    </title>
                    <link rel="stylesheet" href="..//CSS/zmo.css" type="text/css"></link>
                    <link rel="stylesheet" href="..//CSS/zmo_jaraid.css" type="text/css"></link>
                </head>
                <body>
                    <div class="ja-floatbottom"></div>
                    <xsl:call-template name="templTNavAlph"/>
                    <xsl:call-template name="templTableDiv2">
                        <xsl:with-param name="pSort1" select="'name'"/>
                        <xsl:with-param name="pID" select="'t1'"/>
                    </xsl:call-template> 
                </body>
            </html>
        </xsl:result-document>
        

        <xsl:result-document href="..//HTML/output/table-dated.html" format="zmo">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="teiHeader//title"/>
                    </title>
                    <link rel="stylesheet" href="..//CSS/zmo.css" type="text/css"></link>
                    <link rel="stylesheet" href="..//CSS/zmo_jaraid.css" type="text/css"></link>
                    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
                    <script type="text/javascript" src="..//JS/stickyTableHeader.js"></script>
                </head>
                <body>
                    <xsl:call-template name="templTable">
                    <xsl:with-param name="pID" select="'t1'"/>
                </xsl:call-template> 
                </body>
            </html>
        </xsl:result-document>
        
        <xsl:result-document href="..//HTML/output/table-undated.html" format="zmo">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="teiHeader//title"/>
                    </title>
                    <link rel="stylesheet" href="..//CSS/zmo.css" type="text/css"></link>
                    <link rel="stylesheet" href="..//CSS/zmo_jaraid.css" type="text/css"></link>
                    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
                    <script type="text/javascript" src="..//JS/stickyTableHeader.js"></script>
                </head>
                <body>
                    <xsl:call-template name="templTable">
                        <xsl:with-param name="pID" select="'t2'"/>
                    </xsl:call-template> 
                </body>
            </html>
        </xsl:result-document>
        <xsl:result-document href="..//HTML/output/table-undated-div.html" format="zmo">
            <!-- undated periodicals, sorted by name -->
            <html>
                <head>
                    <title>
                        <xsl:value-of select="teiHeader//title"/>
                    </title>
                    <link rel="stylesheet" href="..//CSS/zmo.css" type="text/css"></link>
                    <link rel="stylesheet" href="..//CSS/zmo_jaraid.css" type="text/css"></link>
                </head>
                <body>
                    <div class="ja-floattop"></div>
                    <div class="ja-floatbottom"></div>
                    <xsl:call-template name="templTableDiv">
                        <!-- <xsl:with-param name="pSort1" select="'name'"/> -->
                        <xsl:with-param name="pID" select="'t2'"/>
                    </xsl:call-template> 
                </body>
            </html>
        </xsl:result-document>
        
        <xsl:result-document href="..//HTML/output/intro.html" format="zmo">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="teiHeader//title"/>
                    </title>
                    <link rel="stylesheet" href="..//CSS/zmo.css" type="text/css"></link>
                    <link rel="stylesheet" href="..//CSS/zmo_jaraid.css" type="text/css"></link>
                </head>
                <body>
                    <div class="ja-floattop"></div>
                    <div class="ja-floatbottom"></div>
                    <xsl:apply-templates select="./text/body"/>           
                    
                </body>
            </html>
        </xsl:result-document>
        
        <xsl:result-document href="..//HTML/output/index-pers.html" format="zmo">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="teiHeader//title"/>
                    </title>
                    <link rel="stylesheet" href="..//CSS/zmo.css" type="text/css"></link>
                    <link rel="stylesheet" href="..//CSS/zmo_jaraid.css" type="text/css"></link>
                    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
                    <script type="text/javascript" src="..//JS/stickyTableHeader.js"></script>
                </head>
                <body>
                    <xsl:call-template name="templPers"/>   
                </body>
            </html>
        </xsl:result-document>
<!-- from here on, the templates are extremely slow and need a lot of resources -->
        <xsl:result-document href="..//HTML/output/index-pers-div.html" format="zmo">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="teiHeader//title"/>
                    </title>
                    <link rel="stylesheet" href="..//CSS/zmo.css" type="text/css"></link>
                    <link rel="stylesheet" href="..//CSS/zmo_jaraid.css" type="text/css"></link>
                </head>
                <body>
                    <div class="ja-floattop"></div>
                    <div class="ja-floatbottom"></div>
                    <xsl:call-template name="templPersDiv"/>   
                </body>
            </html>
        </xsl:result-document>

        <xsl:result-document href="..//HTML/output/index-org.html" format="zmo">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="teiHeader//title"/>
                    </title>
                    <link rel="stylesheet" href="..//CSS/zmo.css" type="text/css"></link>
                    <link rel="stylesheet" href="..//CSS/zmo_jaraid.css" type="text/css"></link>
                    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
                    <script type="text/javascript" src="..//JS/stickyTableHeader.js"></script>
                </head>
                <body>
                    <xsl:call-template name="templOrg"/>   
                </body>
            </html>
        </xsl:result-document>
        <xsl:result-document href="..//HTML/output/index-org-div.html" format="zmo">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="teiHeader//title"/>
                    </title>
                    <link rel="stylesheet" href="..//CSS/zmo.css" type="text/css"></link>
                    <link rel="stylesheet" href="..//CSS/zmo_jaraid.css" type="text/css"></link>
                </head>
                <body>
                    <div class="ja-floattop"></div>
                    <div class="ja-floatbottom"></div>
                    <xsl:call-template name="templOrgDiv"/>   
                </body>
            </html>
        </xsl:result-document>
        
        <xsl:result-document href="..//HTML/output/index-loc.html" format="zmo">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="teiHeader//title"/>
                    </title>
                    <link rel="stylesheet" href="..//CSS/zmo.css" type="text/css"></link>
                    <link rel="stylesheet" href="..//CSS/zmo_jaraid.css" type="text/css"></link>
                    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
                    <script type="text/javascript" src="..//JS/stickyTableHeader.js"></script>
                </head>
                <body>
                    <xsl:call-template name="templPlace"/>   
                </body>
            </html>
        </xsl:result-document>
        <xsl:result-document href="..//HTML/output/index-loc-div.html" format="zmo">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="teiHeader//title"/>
                    </title>
                    <link rel="stylesheet" href="..//CSS/zmo.css" type="text/css"></link>
                    <link rel="stylesheet" href="..//CSS/zmo_jaraid.css" type="text/css"></link>
                </head>
                <body>
                    <div class="ja-floattop"></div>
                    <div class="ja-floatbottom"></div>
                    <xsl:call-template name="templPlaceDiv"/>   
                </body>
            </html>
        </xsl:result-document>
        <xsl:result-document href="..//HTML/output/index-lang.html" format="zmo">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="teiHeader//title"/>
                    </title>
                    <link rel="stylesheet" href="..//CSS/zmo.css" type="text/css"></link>
                    <link rel="stylesheet" href="..//CSS/zmo_jaraid.css" type="text/css"></link>
                    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
                    <script type="text/javascript" src="..//JS/stickyTableHeader.js"></script>
                </head>
                <body>
                    <xsl:call-template name="templLang"/>   
                </body>
            </html>
        </xsl:result-document>
        <xsl:result-document href="..//HTML/output/index-title-div.html" format="zmo">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="teiHeader//title"/>
                    </title>
                    <link rel="stylesheet" href="..//CSS/zmo.css" type="text/css"></link>
                    <link rel="stylesheet" href="..//CSS/zmo_jaraid.css" type="text/css"></link>
                </head>
                <body>
                    <div class="ja-floattop"></div>
                    <div class="ja-floatbottom"></div>
                    <xsl:call-template name="templPeriodicalDiv"/>   
                </body>
            </html>
        </xsl:result-document>
        <xsl:result-document href="..//HTML/output/index-hold-div.html" format="zmo">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="teiHeader//title"/>
                    </title>
                    <link rel="stylesheet" href="..//CSS/zmo.css" type="text/css"></link>
                    <link rel="stylesheet" href="..//CSS/zmo_jaraid.css" type="text/css"></link>
                </head>
                <body>
                    <div class="ja-floattop"></div>
                    <div class="ja-floatbottom"></div>
                    <xsl:call-template name="templHoldDiv"/>   
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- This template is dysfunctional
    <xsl:template name="templBack" match="back">
        <xsl:call-template name="templDiv"/>
    </xsl:template> -->
    
    <xsl:template name="templBody" match="body">
        <xsl:call-template name="templDiv"/>
    </xsl:template>
    
    <xsl:template match="back" name="templBack" mode="mSort">
        <xsl:param name="pSort"/>
        <xsl:if test=".//div[@type='abbr']">
                <xsl:element name="div">
                    <xsl:attribute name="id">
                        <xsl:value-of select="'dAbbr'"/>
                    </xsl:attribute>
                    <xsl:if test=".//head">
                        <h2><xsl:value-of select=".//div[@type='abbr']/head"/></h2>
                    </xsl:if>
                    <!-- for-each-group accounts for the possibility of duplicates -->
                    <xsl:for-each-group select=".//div[@type='abbr']/p" group-by=".//abbr">
                        <xsl:sort select="current-grouping-key()"/>
                        <p><xsl:value-of select="current-grouping-key()"/>
                            <xsl:text> = </xsl:text>
                            <xsl:value-of select=".//expan"/>
                            <xsl:apply-templates select="node() [not (self::choice or self::note)]" mode="mCopy"/>
                        </p>
                    </xsl:for-each-group>
                </xsl:element>
        </xsl:if>
    </xsl:template> 
    
    <xsl:template name="templDiv" match="div">
        <xsl:element name="div">
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="@type='table'"/>
                <xsl:when test="parent::node()!=div">
                    <xsl:if test="./head">
                        <h2><xsl:value-of select="./head"/></h2>
                    </xsl:if>
                    <xsl:for-each select="./p">
                        <xsl:call-template name="templP"/>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="./head">
                        <h3><xsl:value-of select="./head"/></h3>
                    </xsl:if>
                    <xsl:for-each select="./p">
                        <xsl:call-template name="templP"/>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
        <xsl:apply-templates select="div"/>
        
    </xsl:template>
    

<!-- as I want to load the results in an iframe, headings should be omitted -->    
    <xsl:template name="templPeriodicalDiv">
        <xsl:call-template name="templIndexTitleDiv">
            <xsl:with-param name="pPath" select="$vgTitle"/>
            <xsl:with-param name="pURLext" select="$pgURLDiv"/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="templPers">
        <!-- <h2>List of Persons</h2> -->
        <xsl:call-template name="templIndexTable">
            <xsl:with-param name="pPath" select="$vgPers"/>
            <xsl:with-param name="pURLext" select="$pgURL"/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="templPersDiv">
        <!-- <h2>List of Persons</h2> -->
        <xsl:call-template name="templIndexTableDiv">
            <xsl:with-param name="pPath" select="$vgPers"/>
            <xsl:with-param name="pURLext" select="$pgURLDiv"/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="templOrg">
        <!-- <h2>List of Organizations</h2> -->
        <xsl:call-template name="templIndexTable">
            <xsl:with-param name="pPath" select="$vgOrg"/>
            <xsl:with-param name="pURLext" select="$pgURL"/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="templOrgDiv">
        <!-- <h2>List of Organizations</h2> -->
        <xsl:call-template name="templIndexTableDiv">
            <xsl:with-param name="pPath" select="$vgOrg"/>
            <xsl:with-param name="pURLext" select="$pgURLDiv"/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="templPlace">
        <!-- <h2>Places of Publication</h2> -->
        <xsl:call-template name="templIndexTable">
            <xsl:with-param name="pPath" select="$vgPlace"/>
            <xsl:with-param name="pURLext" select="$pgURL"/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="templPlaceDiv">
        <!-- <h2>Places of Publication</h2> -->
        <xsl:call-template name="templIndexTableDiv">
            <xsl:with-param name="pPath" select="$vgPlace"/>
            <xsl:with-param name="pURLext" select="$pgURLDiv"/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="templLang">
            <!-- <h2>Places of Publication</h2> -->
            <xsl:call-template name="templIndexTable">
                <xsl:with-param name="pPath" select="$vgLang"/>
                <xsl:with-param name="pURLext" select="$pgURL"/>
            </xsl:call-template>
    </xsl:template>
    <xsl:template name="templHoldDiv">
        <!-- <h2>Places of Publication</h2> -->
        <xsl:call-template name="templIndexTableDiv">
            <xsl:with-param name="pPath" select="$vgHold"/>
            <xsl:with-param name="pURLext" select="$pgURLDiv"/>
        </xsl:call-template>
    </xsl:template>
</xsl:stylesheet>