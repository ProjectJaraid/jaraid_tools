<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"    
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:kml="http://earth.google.com/kml/2.0"
    >
    <xsl:output method="text"  version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" />
    
    <!-- this template will produce a structure JSON file to be used for visualisation through MIT's Exhibit widget -->
    
    <xsl:include href="/BachUni/projekte/XML/Functions/BachFunctions v3.xsl"/>
    
    <xsl:strip-space elements="tei:placeName"/>
    
    <xsl:variable name="vgPlace" select=".//tei:body//tei:cell[@n='5']/tei:placeName"/>
    <xsl:param name="pgURL" select="string('./tabd.html')"/>
    <xsl:param name="pgURLDiv" select="string('./tabdd.html')"/>
    <xsl:param name="pgLocations" select="document('..//TEI/locations master TEI.xml')//tei:teiHeader/tei:fileDesc//tei:listPlace"/>
    
    
    <xsl:template match="tei:TEI">
        <xsl:result-document href="..//Visualization/cities.js">
            <xsl:text>{
    "items":[
            </xsl:text>
            <xsl:call-template name="templJSON"/>
            <xsl:text>],
	"types": {
		"City": {
			"pluralLabel": "Cities"
		}
	},
	"properties": {
		"rank": {
			"valueType": "number"
		},
		"periodicals": {
			"valueType": "number"
		}
	}
}</xsl:text>
        </xsl:result-document>
    </xsl:template>       
    
    
    <xsl:template name="templJSON">
        <xsl:param name="pPath" select="$vgPlace"/>
        <xsl:param name="pURLext" select="$pgURLDiv"/>
        <xsl:for-each-group select="$pPath" group-by=".">
            <xsl:sort select="if (substring(current-grouping-key(),1,3)='Al-') then (substring(current-grouping-key(),4)) else (substring(current-grouping-key(),1))" collation="http://saxon.sf.net/collation?rules={encode-for-uri($sortIjmes)}"/>
            <xsl:variable name="vLoc" select="normalize-space(current-grouping-key())"/>
            <xsl:text>{
            </xsl:text>
            <xsl:text>"label":"</xsl:text>
                <xsl:value-of select="$vLoc"/>
            <xsl:text>",
            </xsl:text>   
            <!-- <xsl:attribute name="xml:id">
                    <xsl:value-of select="document('..//TEI/locations master TEI.xml')//tei:teiHeader/tei:fileDesc//tei:listPlace/tei:place[child::tei:placeName[@type='orig']=$vGroupKey]/@xml:id"/>
                </xsl:attribute> -->
            <xsl:text>"type":"</xsl:text><xsl:value-of select="$pgLocations/tei:place[child::tei:placeName[@type='orig']=$vLoc]/@type"/><xsl:text>",
            </xsl:text>
            <xsl:text>"latlng":"</xsl:text><xsl:value-of select="$pgLocations/tei:place[child::tei:placeName[@type='orig']=$vLoc]/tei:location/tei:geo"/>
            <xsl:text>",
            </xsl:text>
            <xsl:text>"periodicals":"</xsl:text>
                <xsl:value-of select="count(current-group())"/>
            <xsl:text>"</xsl:text><xsl:text>,
            </xsl:text>
            <xsl:text>"links":
            [ </xsl:text>
            <xsl:variable name="vRefVal" select="$vLoc"/>
            <xsl:for-each select="$pPath[.=$vLoc]">
                <xsl:sort select="if (substring(ancestor::tei:row/tei:cell[@n='4']/tei:name[1],1,3)='Al-') then (substring(ancestor::tei:row/tei:cell[@n='4']/tei:name[1],4)) else (substring(ancestor::tei:row/tei:cell[@n='4']/tei:name[1],1))" collation="http://saxon.sf.net/collation?rules={encode-for-uri($sortIjmes)}"/>
                    <xsl:variable name="vAlias">
                        <xsl:value-of select="ancestor::tei:row/tei:cell[@n='4']/tei:name[1]"/>
                        <xsl:text> (</xsl:text>
                        <xsl:value-of select="ancestor::tei:row//tei:cell[@n='1']/tei:date"/>
                        <xsl:text>)</xsl:text>
                    </xsl:variable>
                    <xsl:variable name="vURL">
                        <xsl:value-of select="$pURLext"/>
                        <xsl:text>#</xsl:text>
                        <xsl:value-of select="ancestor::tei:row/attribute::xml:id"/>
                    </xsl:variable>
                    <xsl:text>{"url":"</xsl:text><xsl:value-of select="$vURL"/><xsl:text>",</xsl:text>
                    <xsl:text>"alias":"</xsl:text><xsl:value-of select="normalize-space($vAlias)"/><xsl:text>"}</xsl:text>
                    <xsl:if test="position()!=last()">
                        <xsl:text>,
                        </xsl:text>
                    </xsl:if>
            </xsl:for-each>
            <xsl:text>]</xsl:text>
            <xsl:text>}</xsl:text>
            <xsl:if test="position()!=last()">
                <xsl:text>,
                </xsl:text>
            </xsl:if>
        </xsl:for-each-group>
    </xsl:template>
    
    <xsl:template name="templID">
        <xsl:param name="pApiUrl" select="'http://api.geonames.org/search?name='"/>
        <xsl:param name="pApiOptions" select="'&amp;maxRows=1&amp;style=SHORT&amp;lang=en&amp;username=demo'"/>
        <xsl:variable name="vDocName">
            <xsl:value-of select="$pApiUrl"/>
            <xsl:value-of select="current-grouping-key()"/>
            <xsl:value-of select="$pApiOptions"/>
        </xsl:variable>
        <xsl:attribute name="xml:id">
            <xsl:text>loc</xsl:text>
            <xsl:value-of select="document($vDocName)/geonames/geoname[1]/geonameId"/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template name="templGeoNames">
        <xsl:param name="pApiUrl" select="'http://api.geonames.org/search?name='"/>
        <xsl:param name="pApiOptions" select="'&amp;maxRows=1&amp;style=SHORT&amp;lang=en&amp;username=demo'"/>
        <xsl:variable name="vDocName">
            <xsl:value-of select="$pApiUrl"/>
            <xsl:value-of select="current-grouping-key()"/>
            <xsl:value-of select="$pApiOptions"/>
        </xsl:variable>
        <xsl:value-of select="document($vDocName)/geonames/geoname[1]/lng"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="document($vDocName)/geonames/geoname[1]/lat"/>

    </xsl:template>
    
</xsl:stylesheet>