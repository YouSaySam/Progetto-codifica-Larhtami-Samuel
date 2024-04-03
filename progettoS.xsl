<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="html" encoding="UTF-8" indent="yes" />
   <xsl:template match="/">
    <html lang="IT">
        <head>
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>
                <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
            </title>
            <link rel="stylesheet" type="text/css" href="progettoS.css"/>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
            <script src="funzioni.js"></script>
        </head>
        <body>
            <header>
                <ul id="menu">
                    <li class="desc"><a href="">Descrizione</a></li>
                    <xsl:for-each select="//tei:ab">
                        <li><a href="#{concat('pag', @n)}"><xsl:value-of select="@n"/></a></li>
                    </xsl:for-each>
                    <li class="desc"><a href="#pag122">31 dicembre 1943</a></li>
                    <li class="desc"><a href="#pag123">1 gennaio 1944</a></li>
                </ul>
            </header>
            <div id="text">
                <div id="title">
                    <h1 id="main-title">
                        <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='full']"/>
                    </h1>
                    <h2 id="sub-title">
                        <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='sub']"/>
                    </h2>
                </div>

                <!--BIBLIOGRAFIA-->
                <section id="bibliografia">
                    <h2 id="title_biblio">Bibliografia</h2>
                    <p id="paragrafo">
                        <b>Titolo:</b>  <xsl:value-of select="//tei:msItem/tei:title"/><br/>
                        <b>Autore:</b>  <xsl:value-of select="//tei:author"/><br/>
                        <b>Data:</b>  <xsl:value-of select="//tei:docDate"/><br/>
                        <b>Lingua:</b> <xsl:value-of select="//tei:textLang"/><br/>
                        <br/>
                    </p>
                </section>

                <!-- DESCRIZIONE FISICA DEL DIARIO -->
                <section id="descrizione">
                    <h2 id="desc">Descrizione fisica del diario</h2>
                    <p id="paragrafo">
                        <b>Supporto:</b>   <xsl:value-of select="//tei:support"/><br/>
                        <b>Pagine:</b>     <xsl:value-of select="//tei:measure"/><br/>
                        <b>Condizioni:</b> <xsl:value-of select="//tei:condition"/><br/>
                        <b>Autore:</b>     <xsl:value-of select="//tei:handNote"/><br/>
                        <br/>
                    </p>
                </section>
                

                <!-- Pagine del diario -->
                <xsl:for-each select="//tei:ab">
                    <div id="pagine_diario">
                        <h1 id="{concat('pag', @n)}"><xsl:value-of select="@n"/></h1>
                        <br/>
                        <div id="{concat('pag_', @n)}">
                            <div class="immagine_{@n}">
                                <xsl:variable name="imageNumber" select="@n"/>
                                <xsl:apply-templates select="//tei:surface[@n=$imageNumber]"/>
                            </div>
                            <div class="testo_{@n} testo">
                                <xsl:apply-templates select="."/>
                            </div>
                        </div>
                    </div>
                </xsl:for-each>




                <button class="toggle-btn" data-target="persName">Mostra Nomi di Persona</button>
                <button class="toggle-btn" data-target="abbr">Mostra Abbreviazioni</button>
                <button class="toggle-btn" data-target="supplied">Mostra Aggiunte Autore</button>
                <button class="toggle-btn" data-target="sic">Mostra Errori</button>
                <button class="toggle-btn" data-target="corr">Mostra Correzioni</button>
                <button class="toggle-btn" data-target="placeName">Mostra Luoghi</button>
                <button class="toggle-btn" data-target="del">Cancellature</button>

                <div class="content">
                <span class="persName">Nome di Persona</span>
                <span class="abbr">Abbreviazione</span>
                <span class="supplied">Aggiunta Autore</span>
                <span class="sic">Errore</span>
                <span class="corr">Correzione</span>
                <span class="placeName">Luogo</span>
                <span class="del">Elemento cancellato</span>
                </div>
                </div>
                
                
                
        </body>
    </html>
</xsl:template>


    <xsl:template match="tei:graphic">
    <img class="immag" src="{@url}" usemap="#{concat('map_', @n)}" alt="Immagine"/>
    
    </xsl:template>




<!-- Template per l'elemento tei:zone -->
<xsl:template match="tei:zone">
    <area>
        <xsl:attribute name="shape">rect</xsl:attribute>
        <!-- Calcola le coordinate della zona -->
        <xsl:variable name="ulx" select="@ulx"/>
        <xsl:variable name="uly" select="@uly"/>
        <xsl:variable name="lrx" select="@lrx"/>
        <xsl:variable name="lry" select="@lry"/>
        <xsl:attribute name="coords">
            <xsl:value-of select="concat($ulx, ',', $uly, ',', $lrx, ',', $lry)"/>
        </xsl:attribute>

    </area>
</xsl:template>






    <!-- INIZIO RIGA -->
<xsl:template match="tei:lb">
    <xsl:if test="@n != 1">
        <br/>
    </xsl:if>
    <span id="{@facs}" class="riga">
        <xsl:value-of select="@n"/> 
    </span>
</xsl:template>

<!-- CANCELLATURE COMPRENSIBILI -->
<xsl:template match="tei:del">
    <span class="del nascosto">
        <xsl:value-of select="."/>
    </span>
</xsl:template>

<!-- ELEMENTI INCOMPRENSIBILI -->
<xsl:template match="tei:gap">
    <span class="gap nascosto">???</span>
</xsl:template>

<!-- ABBREVIAZIONI -->
<xsl:template match="tei:abbr">
    <span class="abbr">
        <xsl:value-of select="."/>
    </span>
</xsl:template>

<!-- ESPANSIONI ABBREVIAZIONI -->
<xsl:template match="tei:expan">
    <span class="expan nascosto">
        <xsl:value-of select="."/>
    </span>
</xsl:template>

<!-- AGGIUNTE AUTORE DELLA CODIFICA -->
<xsl:template match="tei:supplied">
    <span class="supplied">
        <xsl:value-of select="."/>
    </span>
</xsl:template>

<!-- ORIGINALE (orig) -->
<xsl:template match="tei:orig">
    <span class="orig nascosto">
        <xsl:value-of select="."/>
    </span>
</xsl:template>

<!-- NORMALIZZAZIONE (reg) -->
<xsl:template match="tei:reg">
    <span class="reg">
        <xsl:value-of select="."/>
    </span>
</xsl:template>

<!-- ERRORE (sic) -->
<xsl:template match="tei:sic">
    <span class="sic nascosto">
        <xsl:value-of select="."/>
    </span>
</xsl:template>

<!-- CORREZIONE (corr) -->
<xsl:template match="tei:corr">
    <span class="corr">
        <xsl:value-of select="."/>
    </span>
</xsl:template>

<!-- AGGIUNTE -->
<xsl:template match="tei:add">
    <span class="add">
        <xsl:value-of select="."/>
    </span>
</xsl:template>

<!-- NOMI DI PERSONA -->
<xsl:template match="tei:persName">
    <span class="persName">
        <xsl:value-of select="."/>
    </span>
</xsl:template>

<!-- PUNTEGGIATURA-->
<xsl:template match="tei:pc">
    <span class="pc nascosto">
        <xsl:value-of select="."/>
    </span>
</xsl:template>

<!-- LUOGHI -->
<xsl:template match="tei:placeName">
    <span class="placeName">
        <xsl:value-of select="."/>
    </span>
</xsl:template>

</xsl:stylesheet>
