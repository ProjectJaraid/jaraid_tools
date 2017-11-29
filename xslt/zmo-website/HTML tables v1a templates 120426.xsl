<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"    
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    >
    <xsl:output method="html"  encoding="UTF-8" indent="yes"/>
    
    <xsl:template name="templTable">
        <xsl:param name="pID"/>
        <!-- <xsl:param name="pSort1" select="concat(cell[@n='1']/date/@when, cell[@n='1']/date/@notAfter)"/> -->
        <!-- <xsl:param name="pSort2"/> -->
        <div id="dTables">
            <xsl:for-each select=".//table[@xml:id=$pID]">
                <div>
                    <!-- <h2><xsl:value-of select="./head"/></h2> -->
                    <table class="ja">
                        <xsl:attribute name="id">
                            <xsl:value-of select="@xml:id"/>
                        </xsl:attribute>                
                        <xsl:attribute name="n">
                            <xsl:value-of select="@n"/>
                        </xsl:attribute>
                        <thead class="ja">
                            <!-- The data comes from the label row -->
                            <tr class="ja">
                                <xsl:if test=".//row[@role='label']">
                                    <xsl:for-each select=".//row[@role='label']/cell">
                                        <th class="ja"><xsl:value-of select="."/></th>
                                    </xsl:for-each>
                                    <th class="ja">ID</th>
                                </xsl:if>
                            </tr>
                        </thead>
                        <tbody class="ja">
                            <!-- representing the data rows -->
                            <xsl:for-each select=".//row[@role='data']">
                                <xsl:sort select="concat(cell[@n='1']/date/@when, cell[@n='1']/date/@notAfter)" order="ascending"/>
                                <xsl:sort select="@xml:id" data-type="number" order="ascending"/>
                                <tr class="ja">
                                    <xsl:if test="@xml:id">
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="@xml:id"/>
                                        </xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="n">
                                        <xsl:value-of select="@n"/>
                                    </xsl:attribute>
                                    <xsl:call-template name="templRows"/>
                                    <td class="ja">
                                        <xsl:value-of select="@xml:id"/>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </tbody>
                    </table>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    <xsl:template name="templRows">
        <xsl:for-each select="cell">
            <!-- cell 9 should be sorted alphabetically -->
            <td class="ja">
                <xsl:apply-templates mode="mCopy"/>
            </td>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>