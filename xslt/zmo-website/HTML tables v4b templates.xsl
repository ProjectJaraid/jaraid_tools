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
                        <xsl:attribute name="id">
                            <xsl:value-of select="@xml:id"/>
                        </xsl:attribute>                
                        <xsl:attribute name="n">
                            <xsl:value-of select="@n"/>
                        </xsl:attribute>
                        <div class="ja-th">
                            <div class="ja-td1">Date of First Issue</div>
                            <div class="ja-td2">Name and Description &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160;&#160;</div>
                            <div class="ja-td3">Holding Institution(s)</div>
                        </div>


                        <!-- representing the data rows -->
                        <xsl:for-each select=".//row[@role='data']">
                                <xsl:sort select="concat(child::cell[@n='1']/date/@when, child::cell[@n='1']/date/@notAfter)"/>
                            <xsl:sort select="child::cell[@n='4']/name[1]" order="ascending" />
                            <!-- collation="http://saxon.sf.net/collation?ignore-modifiers=yes" should ignore all accents etc. -->
                                <!-- <xsl:sort select="@xml:id" data-type="number" order="ascending"/> -->
                            <div class="ja-tr">
                                    <xsl:if test="@xml:id">
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="@xml:id"/>
                                        </xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="n">
                                        <xsl:value-of select="@n"/>
                                    </xsl:attribute>
                                <!-- this template creates an anchor for every five year step -->
                                    <xsl:call-template name="templAnchDate"/>
                                    <div class="ja-td1">
                                        <p class="ja-td1">
                                            <xsl:value-of select="./cell[@n='1']"/>
                                            <xsl:if test="string(./cell[@n='2'])">
                                            <xsl:text>, </xsl:text>
                                            <xsl:value-of select="./cell[@n='2']"/>
                                            </xsl:if>
                                        </p>
                                    </div>
                                    <div class="ja-td2">
                                        <p class="ja-td1">
                                        <xsl:apply-templates select="./cell[@n='4']" mode="mCopy"/> <!-- title of the paper -->
                                        <xsl:if test="string(./cell[@n='6']) or string(./cell[@n='5'])">
                                            <xsl:text>. Published / edited / printed </xsl:text>
                                        <xsl:if test="string(./cell[@n='6'])">
                                            <xsl:text>/ owned by </xsl:text>
                                                <xsl:if test="./cell[@n='6']/orgName[position()=1]"> <!-- why should "not the first" be the condition? -->
                                                    <xsl:text>the </xsl:text>
                                                </xsl:if>
                                            <xsl:apply-templates select="./cell[@n='6']" mode="mCopy"/> <!-- Publishers -->
                                        </xsl:if>
                                        <xsl:if test="string(./cell[@n='5'])">
                                            <xsl:text> in </xsl:text>
                                            <xsl:apply-templates select="./cell[@n='5']" mode="mCopy"/> <!-- Place of publication -->
                                        </xsl:if>
                                            <xsl:text>.</xsl:text>
                                        </xsl:if>
                                        </p>
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
                                        
                                    <!-- <xsl:call-template name="templRowsDiv"/> -->
                                    </div>
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
        <div id="dTables">
            <xsl:for-each select=".//table[@xml:id=$pID]">
                <!-- <h2><xsl:value-of select="./head"/></h2> -->
                <div class="ja-ta">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>                
                    <xsl:attribute name="n">
                        <xsl:value-of select="@n"/>
                    </xsl:attribute>
                    <!-- respresenting the visible header -->
                    <div class="ja-th">
                        <div class="ja-td1">Date of First Issue</div>
                        <div class="ja-td2">Name and Description &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160;&#160;</div>
                        <div class="ja-td3">Holding Institution(s)</div>
                    </div>
                    
                    <!-- representing the data rows -->
                    <xsl:for-each select=".//row[@role='data']">
                        <xsl:sort select="(*|*/*)[name()=$pSort1][1]" order="ascending" />
                        <!-- <xsl:sort select="child::cell[@n='4']/name[1]" order="ascending"/> --> 
                        <!-- <xsl:sort select="@xml:id" data-type="number" order="ascending"/> -->
                        <div class="ja-tr">
                            <xsl:if test="@xml:id">
                                <xsl:attribute name="id">
                                    <xsl:value-of select="@xml:id"/>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:attribute name="n">
                                <xsl:value-of select="@n"/>
                            </xsl:attribute>
                       <!-- this template creates an anchor for every five year step -->
                            <xsl:call-template name="templAnchDate"/>
                            <div class="ja-td1">
                                <p class="ja-td1">
                                    <xsl:value-of select="./cell[@n='1']"/>
                                    <xsl:if test="string(./cell[@n='2'])">
                                        <xsl:text>, </xsl:text>
                                        <xsl:value-of select="./cell[@n='2']"/>
                                    </xsl:if>
                                </p>
                            </div>
                            <div class="ja-td2">
                                <p class="ja-td1">
                                    <xsl:apply-templates select="./cell[@n='4']" mode="mCopy"/> <!-- title of the paper -->
                                    <xsl:if test="string(./cell[@n='6']) or string(./cell[@n='5'])">
                                    <xsl:text>. Published / edited / printed </xsl:text>
                                    <xsl:if test="string(./cell[@n='6'])">
                                        <xsl:text>/ owned by </xsl:text>
                                        <xsl:if test="./cell[@n='6']/orgName[position()=1]">
                                            <xsl:text>the </xsl:text>
                                        </xsl:if>
                                        <xsl:apply-templates select="./cell[@n='6']" mode="mCopy"/> <!-- Publishers -->
                                    </xsl:if>
                                    <xsl:if test="string(./cell[@n='5'])">
                                        <xsl:text> in </xsl:text>
                                        <xsl:apply-templates select="./cell[@n='5']" mode="mCopy"/> <!-- Place of publication -->
                                    </xsl:if>
                                    <xsl:text>.</xsl:text>
                                    </xsl:if>
                                </p>
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
                                
                                <!-- <xsl:call-template name="templRowsDiv"/> -->
                            </div>
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
                        </div>
                    </xsl:for-each>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    <xsl:template name="templTNavChr">
        <div class="ja-floatl">
            <p class="rubriksubline">Sort: </p>
            <p class="ja-selected">chronologic</p>
            <p class="ja-link"><a href="../HTML/table-dated-alpha-div.html">alphabetic</a></p>
        </div>
        <div class="ja-floattop"></div>
    </xsl:template>
    <xsl:template name="templTNavAlph">
        <div class="ja-floatl">
            <p class="rubriksubline">Sort: </p>
            <p class="ja-link"><a href="../HTML/table-dated-chron-div.html">chronologic</a></p>
            <p class="ja-selected">alphabetic</p>
        </div>
        <div class="ja-floattop"></div>
    </xsl:template>
    
</xsl:stylesheet>