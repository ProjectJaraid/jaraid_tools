<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"    
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    >
    <xsl:output method="html"  encoding="UTF-8" indent="yes"/>

    
    <xsl:template name="templTableDiv">
        <xsl:param name="pID"/>
        <div id="dTables">
            <xsl:for-each select=".//table[@xml:id=$pID]">
                <!-- <h2><xsl:value-of select="./head"/></h2> -->
                    <div class="ja-ta">
                        <xsl:call-template name="templID"/>
                        <xsl:call-template name="templTabHead"/>


                        <!-- representing the data rows -->
                        <xsl:for-each select=".//row[@role='data']">
                                <xsl:sort select="concat(child::cell[@n='1']/date/@when, child::cell[@n='1']/date/@notAfter)"/>
                            <xsl:sort select="if (substring(child::cell[@n='4']/name[1],1,3)='Al-') then (substring(child::cell[@n='4']/name[1],4)) else (substring(child::cell[@n='4']/name[1],1))" collation="http://saxon.sf.net/collation?rules={encode-for-uri($sortIjmes)}"/>
                            <!-- this should eliminate all the Arabic articles -->
                            <!-- reference to schema.org -->
                            
                            <div>
                                <xsl:attribute name="class" select="'ja-tr'"/>
                                <xsl:attribute name="itemscope"/>
                                <xsl:attribute name="itemtype" select="'http://schema.org/Book'"/>
                                <xsl:call-template name="templID"/>
                                <!-- this template creates an anchor based on the year -->
                                <xsl:call-template name="templAnchDate"/>
                                <xsl:call-template name="templCol1"/>
                                <xsl:call-template name="templCol2"/>    
                                <xsl:call-template name="templCol3"/>
                                </div>
                            </xsl:for-each>
                    </div>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    <xsl:template name="templTableDiv2">
        <xsl:param name="pID"/>
        <xsl:param name="pSort1"/>
        <xsl:param name="pSort2"/>
        <xsl:param name="pExcludeHoldings"/>
        <div id="dTables">
            <xsl:for-each select=".//table[@xml:id=$pID]">
                <!-- <h2><xsl:value-of select="./head"/></h2> -->
                <div class="ja-ta">
                    <xsl:call-template name="templID"/>
                    <!-- respresenting the visible header -->
                    <xsl:call-template name="templTabHead"/>
                    
                    <!-- representing the data rows -->
                    <xsl:for-each select=".//row[@role='data']">
                        <xsl:sort select="if (substring((*|*/*)[name()=$pSort1][1],1,3)='Al-') then (substring((*|*/*)[name()=$pSort1][1],4)) else (substring((*|*/*)[name()=$pSort1][1],1))" collation="http://saxon.sf.net/collation?rules={encode-for-uri($sortIjmes)}"/>
                        <xsl:sort select="concat(child::cell[@n='1']/date/@when, child::cell[@n='1']/date/@notAfter)"/>
                        <xsl:choose>
                            <xsl:when test="$pExcludeHoldings='y'">
                                <xsl:if test="./cell[@n='9']=''">
                                    <div class="ja-tr">
                                        <xsl:call-template name="templID"/>
                                        <!-- this template creates an anchor for every five year step -->
                                        <xsl:call-template name="templAnchDate"/>
                                        <xsl:call-template name="templCol1"/>
                                        <xsl:call-template name="templCol2"/>
                                        <xsl:call-template name="templCol3"/>
                                    </div>
                                </xsl:if>
                            </xsl:when>
                            <xsl:otherwise>
                                <div class="ja-tr">
                                    <xsl:call-template name="templID"/>
                                    <!-- this template creates an anchor for every five year step -->
                                    <xsl:call-template name="templAnchDate"/>
                                    <xsl:call-template name="templCol1"/>
                                    <xsl:call-template name="templCol2"/>
                                    <xsl:call-template name="templCol3"/>
                                </div>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    <xsl:template name="templID">
        <xsl:if test="@xml:id">
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:attribute name="n">
            <xsl:value-of select="@n"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template name="templTabHead">
        <div class="ja-th">
            <div class="ja-td1">Date of First Issue</div>
            <div class="ja-td2">Name and Description &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160;&#160;</div>
            <div class="ja-td3">Holding Institution(s)</div>
        </div>
    </xsl:template>
    <xsl:template name="templCol1">
        <xsl:variable name="vDate">
            <xsl:variable name="vLoc" select="./cell[@n='1']/date"/>
            <xsl:variable name="vDateShort" select="string('[Y0001], [MNn,*-3]')"/>
            <xsl:variable name="vDateLong" select="string('[Y0001], [D1] [MNn,*-3]')"/>
            <!-- For exact dates -->
            <xsl:if test="$vLoc/@when">
                <xsl:if test="string-length($vLoc/@when)=4">
                    <xsl:value-of select="$vLoc/@when"/>
                </xsl:if>
                <xsl:if test="string-length($vLoc/@when)=10">
                <xsl:value-of select="format-date($vLoc/@when,$vDateLong, $pgLang,(),())"/>
                </xsl:if>
            </xsl:if>
            <!-- for month ranges -->
            <xsl:if test="$vLoc/@notAfter and $vLoc/@notBefore">
                <xsl:if test="string-length($vLoc/@notAfter)=4">
                    <xsl:value-of select="$vLoc"/>
                </xsl:if>
                <xsl:if test="string-length($vLoc/@notAfter)=10">
                    <xsl:value-of select="format-date($vLoc/@notAfter,$vDateShort, $pgLang,(),())"/>
                </xsl:if>
            </xsl:if>
            <!-- in very rare cases the date is only @notAfter -->
            <xsl:if test="$vLoc/@notAfter and not($vLoc/@notBefore)">
                <xsl:value-of select="$vLoc"/>
            </xsl:if>
        </xsl:variable>
        <div class="ja-td1">
            <p class="ja-td1">
                <span itemprop="datePublished">
                    <xsl:attribute name="datetime" select="$vDate"/>
                    <xsl:value-of select="$vDate"/>
                </span>
            </p>
        </div>
    </xsl:template>
    
    
    <xsl:template name="templCol2">
        <div class="ja-td2">
            <p class="ja-td1">
                <!-- title of the paper -->
                <xsl:apply-templates select="./cell[@n='4']" mode="mCopy"/> 
                <xsl:if test="string(./cell[@n='6']) or string(./cell[@n='5'])">
                    <xsl:text>. Published / edited / printed </xsl:text>
                    <xsl:if test="string(./cell[@n='6'])">
                        <xsl:text>/ owned by </xsl:text>
                        <xsl:if test="./cell[@n='6']/orgName[position()=1]"> <!-- why should "not the first" be the condition? -->
                            <xsl:text>the </xsl:text>
                        </xsl:if>
                        <!-- Publishers -->
                        <xsl:apply-templates select="./cell[@n='6']" mode="mCopy"/> 
                    </xsl:if>
                    <xsl:if test="string(./cell[@n='5'])">
                        <xsl:text> in </xsl:text>
                        <!-- Place of publication -->
                        <xsl:apply-templates select="./cell[@n='5']" mode="mCopy"/>
                    </xsl:if>
                    <xsl:text>.</xsl:text>
                </xsl:if>
            </p>
            <xsl:call-template name="templDetails"/>
        </div>
    </xsl:template>
    <xsl:template name="templCol3">
        <div class="ja-td3">
            <xsl:if test="string(./cell[@n='9'])">
                <p class="ja-replace">available</p>
                <p class="ja-td2">
                    <xsl:text>Holding(s): </xsl:text>
                    <xsl:apply-templates select="./cell[@n='9']" mode="mCopy"/>
                </p>
            </xsl:if>
            <p class="ja-td2"><xsl:text>ID: </xsl:text>
                <xsl:value-of select="@xml:id"/>
            </p>
        </div>
    </xsl:template>
    
    <xsl:template name="templDetails">
        <xsl:if test="string(./cell[@n='3'])">
            <p class="ja-td2"><xsl:text>Date of last publication: </xsl:text>
                <xsl:apply-templates select="./cell[@n='3']" mode="mCopy"/></p>
        </xsl:if>
        <xsl:if test="string(./cell[@n='7'])">
            <p class="ja-td2"><xsl:text>Comments: </xsl:text>
                <xsl:apply-templates select="./cell[@n='7']" mode="mCopy"/></p>
        </xsl:if>
        <xsl:if test="string(./cell[@n='8'])">
            <p class="ja-td2"><xsl:text>Source: </xsl:text>
                <xsl:apply-templates select="./cell[@n='8']" mode="mCopy"/></p>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="templTNavChr">
        <div class="topnav2" id="topnav1">
            <div class="head"><p class="rubriksubline">Sort </p></div>
            <div class="expan"><p class="ja-selected">chronologic</p>
                <p class="ja-link"><a href="tabddalph.html">alphabetic</a></p></div>
            <div class="end">&#160;</div>
        </div>
        <div class="topnav2" id="topnav2">
            <div class="head"><p class="rubriksubline">Jump to </p></div>
            <div class="expan">
                <!--        <div class="marginleft">&#160;</div>
         <div class="marginright">&160;</div> -->
                <a href="#xD-1800"><p class="ja-link decade">1800</p></a>
                <a href="#xD-1860"><p class="ja-link decade">1860</p></a>
                <a href="#xD-1870"><p class="ja-link decade">1870</p></a>
                <a href="#xD-1875"><p class="ja-link five">1875</p></a>
                <a href="#xD-1880"><p class="ja-link decade">1880</p></a>
                <a href="#xD-1885"><p class="ja-link five">1885</p></a>
                <a href="#xD-1890"><p class="ja-link decade">1890</p></a>
                <a href="#xD-1895"><p class="ja-link five">1895</p></a>
                <a href="#xD-1896"><p class="ja-link each">1896</p></a>
                <a href="#xD-1897"><p class="ja-link each">1897</p></a>
                <a href="#xD-1898"><p class="ja-link each">1898</p></a>
                <a href="#xD-1899"><p class="ja-link each">1899</p></a>
                <a href="#xD-1900"><p class="ja-link decade">1900</p></a>
            </div>
            <div class="end">&#160;</div>
        </div>
    </xsl:template>
    <xsl:template name="templTNavAlph">
        <div class="topnav2" id="topnav1">
            <div class="head"><p class="rubriksubline">Sort </p></div>
            <div class="expan"><p class="ja-link"><a href="tabddchr.html">chronologic</a></p>
                <p class="ja-selected">alphabetic</p>
            </div>
            <div class="end">&#160;</div>
        </div>
    </xsl:template>
    
</xsl:stylesheet>