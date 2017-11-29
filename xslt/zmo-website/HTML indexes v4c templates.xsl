<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"    
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    >
    <xsl:output method="html"  encoding="UTF-8" indent="yes"/>

    
    <!-- At the moment the function still counts duplicates. These should be omitted in future releases -->
    <!-- In the case of holding institutions this template is painfully slow -->
   
    <xsl:template name="templIndexTableDiv">
        <xsl:param name="pPath"/>
        <xsl:param name="pURLext"/>
        <div class="ja-ta">
            <xsl:call-template name="templHeadIndex"/>
   
            <xsl:for-each-group select="$pPath" group-by=".">
                <xsl:sort select="if (substring(current-grouping-key(),1,3)='Al-') then (substring(current-grouping-key(),4)) else (substring(current-grouping-key(),1))" collation="http://saxon.sf.net/collation?rules={encode-for-uri($sortIjmes)}"/>
                <xsl:sort select="count(current-group())" order="descending"/>
                <xsl:variable name="vGroupKey" select="current-grouping-key()"/>
                <!-- This template produces rows for deleted entries, which are not checked for. -->
                <div class="ja-tr">
                    <xsl:call-template name="templAnchor"/>

                    <div class="ja-in1">
                        <xsl:choose>
                            <!-- When an index of holding institutions is produced, this will look up the expanded name instead of the internal referer -->
                            <xsl:when test="$pPath=$vgHold">
                                <p class="ja-td">
                                    <xsl:value-of select="//p[@xml:id=substring-after($vGroupKey,'#')]/choice/abbr"/>
                                    <xsl:text>: </xsl:text>
                                    <xsl:value-of select="//p[@xml:id=substring-after($vGroupKey,'#')]/choice/expan"/>
                                    <!-- In some cases additional information, such as links, is available. this is to be included here.
                                    The problem with the current solution is that values are sorted by the current-grouping key, which is the @ref attribute and neither the abbreviation nor the expansion-->
                                    <xsl:if test="//p[@xml:id=substring-after($vGroupKey,'#')]/ref">
                                        <xsl:text>; available </xsl:text>
                                        <xsl:apply-templates select="//p[@xml:id=substring-after($vGroupKey,'#')]/ref" mode="mCopy"/> <!-- Working:  <xsl:apply-templates select="//p[@xml:id=substring-after($vGroupKey,'#')]/* [not (self::choice or self::note)]" mode="mCopy"/> -->
                                        <xsl:text>.</xsl:text>
                                    </xsl:if>
                                </p>
                            </xsl:when>
                            <xsl:otherwise>
                                <p class="ja-td"><xsl:value-of select="$vGroupKey"/></p>
                            </xsl:otherwise>
                        </xsl:choose>
                        
                    </div>
                    <div class="ja-in2">
                        <p class="ja-td"><xsl:value-of select="count(current-group())"/></p>
                    </div>
                    <xsl:variable name="vRefVal" select="$vGroupKey"/>
                    <div class="ja-in3">
                        <p class="ja-td">
                            <xsl:for-each select="$pPath">
                                <xsl:sort select="if (substring(ancestor::row/cell[@n='4']/name[1],1,3)='Al-') then (substring(ancestor::row/cell[@n='4']/name[1],4)) else (substring(ancestor::row/cell[@n='4']/name[1],1))" collation="http://saxon.sf.net/collation?rules={encode-for-uri($sortIjmes)}"/>  <!-- The sort function must declare the position of the value if there are more than one -->
                                <xsl:if test=".=$vRefVal">
                                    <xsl:variable name="vAlias">
                                        <xsl:value-of select="ancestor::row/cell[@n='4']/name[1]"/>  <!-- name of the publication -->
                                        <xsl:text> (</xsl:text>
                                        <xsl:if test="current-grouping-key() !=ancestor::row//cell[@n='5']/placeName">  <!-- placeName; they must be excluded if the $pPath is placeName -->
                                            <xsl:for-each select="ancestor::row//cell[@n='5']/placeName">
                                                <xsl:value-of select="."/>
                                                <xsl:text>, </xsl:text>
                                            </xsl:for-each>
                                        </xsl:if>
                                        <xsl:value-of select="ancestor::row//cell[@n='1']/date"/>  <!-- date of first publication -->
                                        <xsl:text>)</xsl:text>
                                    </xsl:variable>
                                    <xsl:variable name="vURL">  
                                        <!-- external URLs can be added here through a global variable in the main stylesheet -->
                                        <!-- PROBLEM: This does not account for the two tables being split into two HTML files, whereas I generate unifed indexes -->
                                        <xsl:value-of select="$pURLext"/>
                                        <xsl:text>#</xsl:text>
                                        <xsl:value-of select="ancestor::row/attribute::xml:id"/>
                                    </xsl:variable>
                                    <a href="{$vURL}"><xsl:value-of select="$vAlias"/></a>
                                    <!-- this function is not working reliably at the moment, because it refers to the value in the original xml file and not the output file -->
                                    <!-- <xsl:if test="position()!=last()">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                                <xsl:if test="position()=last()-1">
                                    <xsl:text> and </xsl:text>
                                </xsl:if>
                                <xsl:if test="position()=last()">
                                </xsl:if> -->
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                            </xsl:for-each></p>
                    </div>
                </div>
            </xsl:for-each-group>
            
        </div>   
    </xsl:template>
    
    <!-- This is used for the index of titles only -->
    <xsl:template name="templIndexTitleDiv">
        <xsl:param name="pPath"/>
        <xsl:param name="pURLext"/>
        <div class="ja-ta">
                <xsl:if test="$pPath=$vgTitle">
                    <h2>Index of Periodicals</h2>
                    <div class="ja-th">
                        <div class="ja-in1">Name</div>
                        <div class="ja-in2">&#160;</div>
                        <div class="ja-in3">Place and date</div>
                    </div>
                    <xsl:for-each-group select="$pPath" group-by=".">
                        <xsl:sort select="if (substring(current-grouping-key(),1,3)='Al-') then (substring(current-grouping-key(),4)) else (substring(current-grouping-key(),1))" collation="http://saxon.sf.net/collation?rules={encode-for-uri($sortIjmes)}"/>
                        <xsl:variable name="vRefVal" select="current-grouping-key()"/>
                        <div class="ja-tr">
                            <div class="ja-in1">
                                <p class="ja-td"><xsl:value-of select="$vRefVal"/></p>
                            </div>
                            <div class="ja-in2">&#160;</div>
                            <div class="ja-in3">
                                <p class="ja-td">
                                    <xsl:for-each select="$pPath">
                                        <xsl:sort select="concat(ancestor::row/cell[@n='1']/date/@when, ancestor::row/cell[@n='1']/date/@notAfter)" order="ascending"/>
                                    <xsl:if test=".=$vRefVal">
                                    <xsl:variable name="vAlias">
                                        <!-- placeName -->
                                        <xsl:choose>
                                            <xsl:when test="ancestor::row//cell[@n='5']/placeName">
                                        <xsl:for-each select="ancestor::row//cell[@n='5']/placeName">
                                            <xsl:value-of select="."/>
                                            <xsl:if test="position()!=last()">
                                                <xsl:text>, </xsl:text>
                                            </xsl:if>
                                            <!-- this function still provides a wrong Oxford comma in conjunction with the previous condition
                                            <xsl:if test="position()=last()-1">
                                                <xsl:text> and </xsl:text>
                                            </xsl:if> -->
                                            <xsl:if test="position()=last()">
                                            </xsl:if>
                                        </xsl:for-each>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text>No place</xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                        <!-- date of first publication -->
                                        <xsl:choose>
                                            <xsl:when test="ancestor::row//cell[@n='1']/date">
                                                <xsl:text> (</xsl:text>
                                                <xsl:value-of select="ancestor::row//cell[@n='1']/date"/>  
                                                <xsl:text>)</xsl:text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text>(N.D.)</xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                        
                                    </xsl:variable>
                                    <xsl:variable name="vURL">  
                                        <!-- external URLs could be added here through a global variable in the main stylesheet -->
                                        <xsl:value-of select="$pURLext"/>
                                        <xsl:text>#</xsl:text>
                                        <xsl:value-of select="ancestor::row/attribute::xml:id"/>
                                    </xsl:variable>
                                    <a href="{$vURL}"><xsl:value-of select="$vAlias"/></a>
  
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                    </xsl:for-each></p>
                            </div>
                        </div>
                    </xsl:for-each-group>
                </xsl:if>
        </div>   
    </xsl:template>
    
    <xsl:template name="templHeadIndex">
        <xsl:param name="pPath"/>
        <div>
            <xsl:if test="$pPath=$vgPers">
                <h2>Index of Persons</h2>
            </xsl:if>
            <xsl:if test="$pPath=$vgOrg">
                <h2>Index of Organisations</h2>
            </xsl:if>
            <xsl:if test="$pPath=$vgPlace">
                <h2>Index of Locations</h2>
            </xsl:if>
            <xsl:if test="$pPath=$vgHold">
                <h2>Index of Holding Institutions</h2>
            </xsl:if>
        </div>
        <div class="ja-th">
            <div class="ja-in1">Name</div>
            <div class="ja-in2">#</div>
            <div class="ja-in3">Periodical(s)</div>
        </div> 
    </xsl:template>
    <xsl:template name="templAnchor">
        <xsl:variable name="vGroupKey" select="current-grouping-key()"/>
        <xsl:element name="a">
            <xsl:attribute name="id">
                <xsl:text>xI-</xsl:text>
                <xsl:choose>
                    <xsl:when test="contains($vGroupKey,'#')">
                        <xsl:value-of select="substring-after($vGroupKey,'#')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$vGroupKey"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>