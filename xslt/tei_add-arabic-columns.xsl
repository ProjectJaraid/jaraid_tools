<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:pj="https://projectjaraid.github.io/ns"
    xmlns:oape="https://openarabicpe.github.io/ns" 
    xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs pj"
    version="3.0">
    <xsl:output encoding="UTF-8" indent="no" omit-xml-declaration="no" method="xml"/>
    <xsl:include href="functions.xsl"/>
    
    <xsl:param name="p_string-separator" select="' / '" as="xs:string"/>
    
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- identity transform -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="tei:row[@role = 'data']">
        <xsl:copy>
            <!-- reproduce the current content -->
            <!-- IMPORTANT: in order for the automatically generated columns not being stacked ad infitum, they must be overwritten -->
            <xsl:apply-templates select="@* | node()"/>
            <!-- add rows for Arabic -->
            <!-- titles -->
            <!-- if Arabic titles are already present, they shall not be replaced -->
            <xsl:if test="not(tei:cell[@n = 10]/node())">
                <xsl:apply-templates select="tei:cell[@n = 4]" mode="m_add-arabic"/>
            </xsl:if>
            <!-- persons, organisations -->
            <xsl:apply-templates select="tei:cell[@n = 6]" mode="m_add-arabic"/>
            <!-- places -->
            <xsl:apply-templates select="tei:cell[@n = 5]" mode="m_add-arabic"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- previously generated Arabic columns shall be overwritten -->
    <xsl:template match="tei:row[@role = 'data']/tei:cell[@n = (11, 12)]"/>
    
    <xsl:template match="tei:row[@role = 'data']/tei:cell" mode="m_add-arabic">
        <xsl:copy>
            <!-- document change -->
            <!-- NOTE: as this XSLT is used by a GitHub action, it is frequently run and will infest the master files with <change> nodes. I, therefore removed the documentation -->
            <!-- <xsl:attribute name="change" select="concat('#',$p_id-change)"/> -->
            <!-- add new column numbers -->
            <xsl:choose>
                <!-- titles -->
                <xsl:when test="@n = 4">
                    <xsl:attribute name="n" select="10"/>
                    <xsl:apply-templates select="tei:name" mode="m_add-arabic"/>
                </xsl:when>
                <!-- places -->
                <xsl:when test="@n = 5">
                    <xsl:attribute name="n" select="12"/>
                    <xsl:apply-templates select="tei:placeName" mode="m_add-arabic"/>
                </xsl:when>
                <!-- persons, organisations -->
                <xsl:when test="@n = 6">
                    <xsl:attribute name="n" select="11"/>
                    <xsl:apply-templates mode="m_add-arabic"/>
<!--                    <xsl:apply-templates select="tei:orgName" mode="m_add-arabic"/>-->
                    <!--<xsl:apply-templates select="tei:persName" mode="m_add-arabic"/>-->
                </xsl:when>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:persName | tei:placeName | tei:orgName" mode="m_add-arabic">
        <xsl:copy-of select="pj:entity-names_get-version-from-authority-file(., $v_file-entities-master, 'jaraid', 'ar')"/>
        <xsl:if test="following-sibling::tei:persName | following-sibling::tei:orgName | following-sibling::tei:placeName">
            <xsl:value-of select="$p_string-separator"/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:name" mode="m_add-arabic">
        <xsl:element name="title">
            <xsl:attribute name="level" select="'j'"/>
            <xsl:attribute name="xml:lang" select="'ar'"/>
            <xsl:value-of select="oape:string-transliterate-ijmes-to-arabic(.)"/>
        </xsl:element>
    </xsl:template>
    <!-- all other nodes should be supressed -->
    <xsl:template match="node()" mode="m_add-arabic"/>
    
    
    
    <!-- generate documentation of change -->
    <!-- NOTE: as this XSLT is used by a GitHub action, it is frequently run and will infest the master files with <change> nodes. I, therefore removed the documentation -->
    <!-- <xsl:template match="tei:revisionDesc" priority="100">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:element name="change">
                <xsl:attribute name="when"
                    select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>
                <xsl:attribute name="who" select="concat('#', $p_id-editor)"/>
                <xsl:attribute name="xml:id" select="$p_id-change"/>
                <xsl:attribute name="xml:lang" select="'en'"/>
                <xsl:text>Updated Arabic content of rows 11 and 12 based on recent changes to the authority file</xsl:text>
            </xsl:element>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template> -->
</xsl:stylesheet>