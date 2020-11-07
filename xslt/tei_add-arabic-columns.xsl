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
    <xsl:include href="/BachUni/BachBibliothek/GitHub/OpenArabicPE/tools/xslt/functions_arabic-transcription.xsl"/>
    
    <xsl:param name="p_id-change" select="generate-id(//tei:change[last()])"/>
    <xsl:param name="p_url-authority" select="'../../jaraid_source/authority-files/jaraid_authority-file.TEIP5.xml'"/>
    <xsl:variable name="v_file-entities-master" select="doc($p_url-authority)"/>
    
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- identity transform -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="tei:row">
        <xsl:copy>
            <!-- reproduce the current content -->
            <xsl:apply-templates select="@* | node()"/>
            <!-- add rows for Arabic -->
            <!-- titles -->
            <xsl:apply-templates select="tei:cell[@n = 4]" mode="m_add-arabic"/>
            <!-- persons, organisations -->
            <xsl:apply-templates select="tei:cell[@n = 6]" mode="m_add-arabic"/>
            <!-- places -->
            <xsl:apply-templates select="tei:cell[@n = 5]" mode="m_add-arabic"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:cell" mode="m_add-arabic">
        <xsl:copy>
            <!-- document change -->
            <xsl:attribute name="change" select="concat('#',$p_id-change)"/>
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
                    <xsl:apply-templates select="tei:persName" mode="m_add-arabic"/>
                    <!-- the following is not yet implemented -->
<!--                    <xsl:apply-templates select="tei:orgName" mode="m_add-arabic"/>-->
                </xsl:when>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:persName | tei:placeName" mode="m_add-arabic">
        <xsl:copy-of select="pj:entity-names_get-version-from-authority-file(., $v_file-entities-master, 'ar')"/>
    </xsl:template>
    <xsl:template match="tei:name" mode="m_add-arabic">
        <xsl:element name="title">
            <xsl:attribute name="level" select="'j'"/>
            <xsl:attribute name="xml:lang" select="'ar'"/>
            <xsl:value-of select="oape:string-transliterate-ijmes-to-arabic(.)"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:function name="pj:entity-names_get-version-from-authority-file">
        <xsl:param name="p_name"/>
        <xsl:param name="p_authority-file"/>
        <xsl:param name="p_target-lang"/>
        <xsl:variable name="v_authority" select="'jaraid'"/>
        <xsl:variable name="v_type" select="replace($p_name/@ref, 'jaraid:(\w+):\d+', '$1')"/>
        <xsl:variable name="v_id" select="replace($p_name/@ref, 'jaraid:\w+:(\d+)', '$1')"/>
        <xsl:variable name="v_entity">
            <xsl:choose>
                <xsl:when test="$v_type = 'pers'">
                    <xsl:copy-of select="$p_authority-file/descendant::tei:person[tei:idno[@type = $v_authority] = $v_id]"/>
                </xsl:when>
                <xsl:when test="$v_type = 'place'">
                    <xsl:copy-of select="$p_authority-file/descendant::tei:place[tei:idno[@type = $v_authority] = $v_id]"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="v_entity-name">
            <xsl:choose>
                <xsl:when test="$v_type = 'pers'">
                    <xsl:copy-of select="$v_entity/descendant::tei:persName[@xml:lang = $p_target-lang][1]"/>
                </xsl:when>
                <xsl:when test="$v_type = 'place'">
                    <xsl:copy-of select="$v_entity/descendant::tei:placeName[@xml:lang = $p_target-lang][1]"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <!-- output -->
        <xsl:apply-templates select="$v_entity-name" mode="m_copy-from-authority-file"/>
    </xsl:function>
    
    <xsl:template match="tei:persName | tei:orgName | tei:placeName" mode="m_copy-from-authority-file">
        <xsl:variable name="v_authority" select="'jaraid'"/>
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="m_copy-from-authority-file"/>
            <xsl:attribute name="ref">
                <xsl:choose>
                    <xsl:when test="self::tei:persName">
                        <xsl:value-of select="concat($v_authority, ':pers:', parent::node()/tei:idno[@type = $v_authority])"/>
                    </xsl:when>
                    <xsl:when test="self::tei:placeName">
                        <xsl:value-of select="concat($v_authority, ':place:', parent::node()/tei:idno[@type = $v_authority])"/>
                    </xsl:when>
                    <xsl:when test="self::tei:orgName">
                        <xsl:value-of select="concat($v_authority, ':org:', parent::node()/tei:idno[@type = $v_authority])"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates mode="m_copy-from-authority-file"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="node() | @*" mode="m_copy-from-authority-file">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" mode="m_copy-from-authority-file"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@xml:id | @change" mode="m_copy-from-authority-file"/>
</xsl:stylesheet>