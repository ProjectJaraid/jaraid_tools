<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    >
    <xsl:output name="zmo" method="html" doctype-public="html" omit-xml-declaration="no" exclude-result-prefixes="#all"  encoding="UTF-8" indent="yes"/>

 <!-- This stylesheet integrates with the ZMO's DWT templates through loading all bits of code into iframes -->
 <!-- It produces a series of Html pages for the iframes -->
 <!-- v4e6 is the production version for the website published by the ZMO -->
 <!-- v4e9 introduced new and much shorter URLs for all HTML files in order to reduce the file size  through much shorter internal links -->
 <!-- v4e11 introduced links to the index of holding institutions in the tables through tei v2c -->
 <!-- v4e12 added a new subpage and toc for the contributors -->


    <xsl:include href="/BachUni/projekte/XML/Functions/BachFunctions v3.xsl"/>
    <!-- <xsl:include href="..//XSLT/HTML indexes v2d templates 120425.xsl"/> -->
    <xsl:include href="..//XSLT/HTML anchors v1b templates.xsl"/>
    <xsl:include href="..//XSLT/HTML indexes v2e templates 120530.xsl"/>
    <xsl:include href="..//XSLT/HTML indexes v4c templates.xsl"/>
    <xsl:include href="..//XSLT/HTML toc v2 templates 120615.xsl"/>
    <xsl:include href="..//XSLT/HTML toc v3d templates.xsl"/>
    <xsl:include href="..//XSLT/HTML tables v1a templates 120426.xsl"/>
    <xsl:include href="..//XSLT/HTML tables v6a templates.xsl"/>
    <xsl:include href="..//XSLT/HTML tei v2d templates.xsl"/>
    <xsl:include href="..//XSLT/HTML revisions v1a templates.xsl"/>
    <xsl:variable name="vgRoot" select="TEI"/>
    <xsl:variable name="vgOrg" select=".//body//orgName"/>
    <xsl:variable name="vgPers" select=".//body//persName"/>
    <xsl:variable name="vgPlace" select=".//body//cell[@n='5']/placeName"/>
    <xsl:variable name="vgLang" select=".//body//lang"/>
    <xsl:variable name="vgTitle" select=".//body//name"/>
    <xsl:variable name="vgHold" select=".//body//cell[@n='9']//rs/@ref"/>
   
    <!-- In order to ignore "al-" some substring replacement must be done, I suppose -->
    <!-- this parameter links the indexes back to the main table I could change that to the chronologically sorted etc. -->
    <xsl:param name="pgURLDiv" select="string('./tabddchr.html')"/> 
    <xsl:param name="pgURL" select="string('./tabd.html')"/>
    <!-- this can be used to change the language of output -->
    <xsl:param name="pgLang" select="string('en')"/> 
    
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="TEI">
        <xsl:result-document href="..//HTML/output/toc.html">
            <xsl:call-template name="templTOC"/>
        </xsl:result-document>
        <xsl:result-document href="..//HTML/output/tocd.html">
            <xsl:call-template name="templTOCDiv"/>
        </xsl:result-document>
        <xsl:result-document href="..//HTML/output/tocd2.html">
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
        <xsl:result-document href="..//HTML/output/rev.html" format="zmo">
            <html>
                <xsl:call-template name="templHeadMain"/>
                <body>
                    <div class="ja-floattop"></div>
                    <div class="ja-floatbottom"></div>
                    <h2>History of Changes</h2>
                    <xsl:call-template name="templRssItem">
                        <xsl:with-param name="pExclude" select="'beta'"/>
                    </xsl:call-template>
                </body>
            </html>
        </xsl:result-document>
    
        
        <xsl:result-document href="..//HTML/output/tabdd.html" format="zmo">
            <!-- main table, chronologic sorting -->
            <html>
                <xsl:call-template name="templHeadMain"/>
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
        <xsl:result-document href="..//HTML/output/tabddchr.html" format="zmo">
            <!-- main table, chronologic sorting -->
            <html>
                <xsl:call-template name="templHeadMain"/>
                <body>
                    <div class="ja-floattop"></div>
                    <div class="ja-floatbottom"></div>
                    <xsl:call-template name="templTNavChr"/>
                    <xsl:call-template name="templTableDiv2">
                        <!-- NOT WORKING <xsl:with-param name="pSort1" select="concat(child::cell[@n='1']/date/@when, child::cell[@n='1']/date/@notAfter)"/> -->
                        <!-- SOLVED through including this sort as fall-back option in the template -->
                        <xsl:with-param name="pID" select="'t1'"/>
                    </xsl:call-template> 
                </body>
            </html>
        </xsl:result-document>
        <xsl:result-document href="..//HTML/output/tabddchrNoHoldings.html" format="zmo">
            <!-- main table, chronologic sorting -->
            <html>
                <xsl:call-template name="templHeadMain"/>
                <body>
                    <div class="ja-floattop"></div>
                    <div class="ja-floatbottom"></div>
                    <xsl:call-template name="templTNavChr"/>
                    <xsl:call-template name="templTableDiv2">
                        <!-- NOT WORKING <xsl:with-param name="pSort1" select="concat(child::cell[@n='1']/date/@when, child::cell[@n='1']/date/@notAfter)"/> -->
                        <!-- SOLVED through including this sort as fall-back option in the template -->
                        <xsl:with-param name="pID" select="'t1'"/>
                        <xsl:with-param name="pExcludeHoldings" select="'y'"/>
                    </xsl:call-template> 
                </body>
            </html>
        </xsl:result-document>
        <xsl:result-document href="..//HTML/output/tabddalph.html" format="zmo">
            <!-- main table, alphabetically sorted, navigation pane -->
            <html>
                <xsl:call-template name="templHeadMain"/>
                <body>
                    <div class="ja-floattop"></div>
                    <div class="ja-floatbottom"></div>
                    <xsl:call-template name="templTNavAlph"/>
                    <xsl:call-template name="templTableDiv2">
                        <xsl:with-param name="pSort1" select="'name'"/>
                        <xsl:with-param name="pID" select="'t1'"/>
                    </xsl:call-template> 
                </body>
            </html>
        </xsl:result-document>
        

        <!--<xsl:result-document href="..//HTML/output/tabd.html" format="zmo">
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
        </xsl:result-document>-->
        
       <!-- <xsl:result-document href="..//HTML/output/tabu.html" format="zmo">
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
        </xsl:result-document>-->
        <xsl:result-document href="..//HTML/output/tabud.html" format="zmo">
            <!-- undated periodicals, sorted by name -->
            <html>
                <xsl:call-template name="templHeadMain"/>
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
                <xsl:call-template name="templHeadMain"/>
                <body>
                    <div class="ja-floattop"></div>
                    <div class="ja-floatbottom"></div>
                    <xsl:apply-templates select="./text/body"/>           
                    
                </body>
            </html>
        </xsl:result-document>
        
       <!-- <xsl:result-document href="..//HTML/output/iprs.html" format="zmo">
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
        </xsl:result-document>-->
<!-- from here on, the templates are extremely slow and need a lot of resources -->
        <xsl:result-document href="..//HTML/output/iprsd.html" format="zmo">
            <html>
                <xsl:call-template name="templHeadMain"/>
                <body>
                    <div class="ja-floattop"></div>
                    <div class="ja-floatbottom"></div>
                    <xsl:call-template name="templPersDiv"/>   
                </body>
            </html>
        </xsl:result-document>

       <!-- <xsl:result-document href="..//HTML/output/iorg.html" format="zmo">
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
        </xsl:result-document>-->
        <xsl:result-document href="..//HTML/output/iorgd.html" format="zmo">
            <html>
                <xsl:call-template name="templHeadMain"/>
                <body>
                    <div class="ja-floattop"></div>
                    <div class="ja-floatbottom"></div>
                    <xsl:call-template name="templOrgDiv"/>   
                </body>
            </html>
        </xsl:result-document>
        
       <!-- <xsl:result-document href="..//HTML/output/iloc.html" format="zmo">
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
        </xsl:result-document>-->
        <xsl:result-document href="..//HTML/output/ilocd.html" format="zmo">
            <html>
                <xsl:call-template name="templHeadMain"/>
                <body>
                    <div class="ja-floattop"></div>
                    <div class="ja-floatbottom"></div>
                    <xsl:call-template name="templPlaceDiv"/>   
                </body>
            </html>
        </xsl:result-document>
        <xsl:result-document href="..//HTML/output/ilgd.html" format="zmo">
            <html>
                <xsl:call-template name="templHeadMain"/>
                <body>
                    <div class="ja-floattop"></div>
                    <div class="ja-floatbottom"></div>
                    <xsl:call-template name="templLangDiv"/>   
                </body>
            </html>
        </xsl:result-document>
        <!--<xsl:result-document href="..//HTML/output/ilg.html" format="zmo">
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
        </xsl:result-document>-->
        <xsl:result-document href="..//HTML/output/ittld.html" format="zmo">
            <html>
                <xsl:call-template name="templHeadMain"/>
                <body>
                    <div class="ja-floattop"></div>
                    <div class="ja-floatbottom"></div>
                    <xsl:call-template name="templPeriodicalDiv"/>   
                </body>
            </html>
        </xsl:result-document>
        <xsl:result-document href="..//HTML/output/ilibd.html" format="zmo">
            <html>
                <xsl:call-template name="templHeadMain"/>
                <body>
                    <div class="ja-floattop"></div>
                    <div class="ja-floatbottom"></div>
                    <xsl:call-template name="templHoldDiv"/>   
                </body>
            </html>
        </xsl:result-document>
        <xsl:result-document href="..//HTML/output/contr.html" format="zmo">
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
                    <div>
                        <h2>Contributors</h2>
                    <xsl:for-each select=".//editionStmt/respStmt/persName">
                        <xsl:sort select="./surname"/>
                        <p><xsl:value-of select="concat(./forename,' ',./surname)"/></p>
                    </xsl:for-each>
                    </div>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    
    <xsl:template name="templHeadMain">
        <head>
            <title>
                <xsl:value-of select="teiHeader//title"/>
            </title>
            <link rel="stylesheet" href="..//CSS/zmo.css" type="text/css"></link>
            <link rel="stylesheet" href="..//CSS/zmo_jaraid.css" type="text/css"></link>
            <link rel="stylesheet" href="..//CSS/topnav.css" type="text/css"/>
        </head>
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
                        <xsl:sort select="current-grouping-key()" collation="http://saxon.sf.net/collation?rules={encode-for-uri($sortIjmes)}"/>
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
    <xsl:template name="templLangDiv">
        <!-- <h2>Places of Publication</h2> -->
        <xsl:call-template name="templIndexTableDiv">
            <xsl:with-param name="pPath" select="$vgLang"/>
            <xsl:with-param name="pURLext" select="$pgURLDiv"/>
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