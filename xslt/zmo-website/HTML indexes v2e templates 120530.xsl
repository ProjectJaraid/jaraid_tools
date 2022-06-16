<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"    
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    >
    <xsl:output method="html"  encoding="UTF-8" indent="yes"/>
    <!-- At the moment the function still counts duplicates. These should be omitted in future releases -->
    <xsl:template name="templIndexTable">
        <xsl:param name="pPath"/>
        <xsl:param name="pURLext"/>
        <xsl:if test="$pPath!=$vgTitle">
        <table class="ja">
            <thead class="ja">
                <tr class="ja">
                    <th class="ja">Name (asc)</th>
                    <th class="ja">Number of Occurrences</th>
                    <th class="ja">Periodical</th>
                </tr>
            </thead>
            <tbody class="ja">
                <xsl:for-each-group select="$pPath" group-by=".">
                    <xsl:sort select="current-grouping-key()"/>
                    <xsl:sort select="count(current-group())" order="descending"/>
                    <tr class="ja">
                        <td class="ja">
                            <xsl:value-of select="current-grouping-key()"/>
                        </td>
                        <td class="ja-no">
                            <xsl:value-of select="count(current-group())"/>
                        </td>
                        <xsl:variable name="vRefVal">
                            <xsl:value-of select="current-grouping-key()"/>
                        </xsl:variable>
                        <td class="ja">
                            <xsl:for-each select="$pPath">
                                <!-- The sort function must declare the position of the value if there are more than one -->
                                    <xsl:sort select="ancestor::row/cell[@n='4']/name[1]"/>
                            <xsl:if test=".=$vRefVal">
                                <xsl:variable name="vAlias">
                                    <!-- name of the publication -->
                                    <xsl:value-of select="ancestor::row//name"/>
                                    <xsl:text> (</xsl:text>
                                    <!-- placeName; they must be excluded if the $pPath is placeName -->
                                    <xsl:if test="current-grouping-key() !=ancestor::row//cell[@n='5']/placeName">
                                    <xsl:for-each select="ancestor::row//cell[@n='5']/placeName">
                                        <xsl:value-of select="."/>
                                        <xsl:text>, </xsl:text>
                                    </xsl:for-each>
                                    </xsl:if>
                                    <!-- date of first publication -->
                                    <xsl:value-of select="ancestor::row//cell[@n='1']/date"/>
                                    <xsl:text>)</xsl:text>
                                </xsl:variable>
                                <xsl:variable name="vURL">  
                                    <!-- external URLs could be added here through a global variable in the main stylesheet -->
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
                            </xsl:for-each></td>
                    </tr>
                </xsl:for-each-group>
            </tbody>
        </table>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>