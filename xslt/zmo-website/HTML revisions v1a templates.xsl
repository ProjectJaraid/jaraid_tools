<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"    
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    
    >
    <xsl:output  method="html" doctype-public="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:variable name="vgRSS" select="document('..//RSS/rss-jaraid.xml')"/>
    <xsl:variable name="vgDate">
        <xsl:element name="tei:date"> <!-- this is the most important part to make the processor recognise the string as date!!! -->
            <xsl:value-of select="$vgRSS//pubDate"/>
        </xsl:element>
    </xsl:variable>
    <xsl:variable name="pgSortMonth" select="'&lt; Jan &lt; Feb &lt; Mar &lt; Apr &lt; May &lt; Jun &lt; Jul &lt; Aug &lt; Sep &lt; Oct &lt; Nov &lt; Dec'"/>
   
        
        
    
    <xsl:template name="templRssItem">
        <xsl:param name="pExclude"/>
        <xsl:for-each select="$vgRSS//item [not(./@type=$pExclude)]">
            <xsl:sort select="concat(substring(./pubDate,string-length(./pubDate)-18,4),substring(./pubDate,string-length(./pubDate)-22,3),format-number(number(substring(./pubDate,string-length(./pubDate)-25,2)),'00'))" collation="http://saxon.sf.net/collation?rules={encode-for-uri($pgSortMonth)}" order="descending"/>
            <xsl:variable name="vYear" select="substring(./pubDate,string-length(./pubDate)-18,4)"/>
            <xsl:variable name="vMonth" select="substring(./pubDate,string-length(./pubDate)-22,3)"/>
            <xsl:variable name="vMonthDig">
                <xsl:if test="$vMonth='Jan'">01</xsl:if>
                <xsl:if test="$vMonth='Feb'">02</xsl:if>
                <xsl:if test="$vMonth='Mar'">03</xsl:if>
                <xsl:if test="$vMonth='Apr'">04</xsl:if>
                <xsl:if test="$vMonth='May'">05</xsl:if>
                <xsl:if test="$vMonth='Jun'">06</xsl:if>
                <xsl:if test="$vMonth='Jul'">07</xsl:if>
                <xsl:if test="$vMonth='Aug'">08</xsl:if>
                <xsl:if test="$vMonth='Sep'">09</xsl:if>
                <xsl:if test="$vMonth='Oct'">10</xsl:if>
                <xsl:if test="$vMonth='Nov'">11</xsl:if>
                <xsl:if test="$vMonth='Dec'">12</xsl:if>
            </xsl:variable>
            <xsl:variable name="vDay" select="number(substring(./pubDate,string-length(./pubDate)-25,2))"/>
            <xsl:variable name="vDayDig" select="format-number($vDay,'00')"></xsl:variable>
            <xsl:variable name="vDate1" as="xs:date">
                <xsl:value-of select="$vDay"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="$vMonth"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="$vYear"/>
            </xsl:variable>
            <xsl:variable name="vDate">
                <xsl:element name="tei:date"> <!-- this is the most important part to make the processor recognise the string as date!!! -->
                    <xsl:value-of select="concat($vYear,'-',$vMonthDig,'-',$vDayDig)"/>
                </xsl:element>
            </xsl:variable>
            <xsl:variable name="vDateRFC" select="format-date($vDate,'[D1] [MNn, *-3]. [Y0001]' )"/>
            
            
            <div class="ja-tr">
                <div class="ja-in11">
                    <p class="ja-td">
                        <!-- <xsl:value-of select="format-date($vgDate,'[D1] [MNn, *-3]. [Y0001]')"/>-->
                        <xsl:value-of select="$vDateRFC"/>
                    </p>
                    
                </div>
                <div class="ja-in21"><!-- &#160; -->
                    <p class="ja-td">
                        <xsl:if test="./@type='official'">Website</xsl:if>
                        <xsl:if test="./@type='tei'">Data</xsl:if>
                    </p>
                </div>
                <div class="ja-in3">
                    <xsl:if test="./@type='tei'">
                        <p class="ja-td"><xsl:value-of select="substring-before(./description,'Responsible')"/></p>
                        <p class="ja-td">
                            <xsl:text>Responsible</xsl:text>
                            <xsl:value-of select="substring-after(./description,'Responsible')"/></p>
                    </xsl:if>
                    <xsl:if test="./@type!='tei'">
                        <p class="ja-td"><xsl:value-of select="./description"/></p>
                    </xsl:if>
                </div>
            </div>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="templTeiItem">
        <xsl:for-each select=".//tei:revisionDesc/tei:change">
            <xsl:sort select="./@when" order="descending"></xsl:sort>
            <div class="ja-tr">
                <div class="ja-in11">
                    <p class="ja-td">
                        <xsl:value-of select="format-date(./@when,'[D1] [MNn, *-3]. [Y0001]')"/> 
                    </p>
                </div>
                <div class="ja-in21">Data</div>
                <div class="ja-in3">
                    <p class="ja-td"><xsl:value-of select="."/></p>
                    <xsl:apply-templates select="./@who"/>
                </div>
            </div>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="templResp" match="@who">
        <xsl:variable name="vResp" select="."/>
        <p class="ja-td"><xsl:text>Responsible editor: </xsl:text>
        <!-- <xsl:value-of select="//tei:persName[@xml:id=substring-after($vResp,'#')]"/> -->
        
        <xsl:for-each select="//tei:editionStmt//tei:persName[contains($vResp, @xml:id)]">
            <xsl:value-of select="."/>
            <xsl:if test="position()!=last()">
                <xsl:text>, </xsl:text>
            </xsl:if>
        </xsl:for-each>
        </p>
    </xsl:template>
    
    
</xsl:stylesheet>