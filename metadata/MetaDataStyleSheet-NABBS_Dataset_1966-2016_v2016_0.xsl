<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>

<xsl:template match="/">

	<HTML>
    	<HEAD>
        	<STYLE TYPE="text/css">
				#MainContainer {
					width: 100%;
					background-color: #BECEE6;
				}
				
				.DataTable {
					width: 98%;
					background-color: white;
					margin: 10px;
				}
				
				.DataTable .indentLevelOne {
					padding-left: 20px;
				}
				
				.DataTable .indentLevelTwo {
					padding-left: 40px;
				}
				
				.DataTable .indentLevelThree {
					padding-left: 60px;
				}
				
				.DataTable tr td:first-child {
					width:1px;
					font-weight: bold;
					vertical-align: top;
					white-space: nowrap;
					padding-right: 10px;
				}
				
				.DataTable tr:first-child td {
					text-align: left;
					background-color: #FFFFCC;
				}
				
				.NestedDataTable {
					border-spacing: 0px;
					border-collapse: collapse;
					border: solid;
					border-color: #6495ED;
					font-weight: normal;
				}
				
				.NestedDataTable tr:first-child td {
					font-weight: bold !important;
					background-color: #F0F8FF;
				}
				
				.NestedDataTable tr:first-child td:first-child[colspan="2"] {
					font-weight: bold !important;
					width: 1000px;
				}
				
				.NestedDataTable tr td {
					font-weight: normal !important;
					border: solid;
					border-color: #6495ED;
					white-space: normal !important;
					padding-right: 2px !important;
				}
			</STYLE>
        </HEAD>
    	<BODY>
        	<TABLE ID="MainContainer">
            	<TR>
                	<TD>
        				<xsl:apply-templates/>
                    </TD>
                </TR>
            </TABLE>
        </BODY>
    </HTML>	
    
    
	
</xsl:template>

<xsl:template match="metadata">

	<TABLE CLASS="DataTable">
    	<TR>
        	<TD COLSPAN="2">Citation</TD>
        </TR>
        <TR>
        	<TD>Title:</TD>
            <TD><xsl:value-of select="idinfo/citation/citeinfo/title"/></TD>
        </TR>
        <TR>
        	<TD>Originators:</TD>
            <TD>
                <xsl:for-each select="idinfo/citation/citeinfo/origin">
                    <xsl:value-of select="."/><BR />
                </xsl:for-each>
            </TD>
        </TR>
        <TR>
        	<TD>Publisher:</TD>
            <TD><xsl:value-of select="idinfo/citation/citeinfo/pubinfo/publish"/></TD>
        </TR>
        <TR>
        	<TD>Publication Place:</TD>
            <TD><xsl:value-of select="idinfo/citation/citeinfo/pubinfo/pubplace"/></TD>
        </TR>
        <TR>
        	<TD>Publication Date:</TD>
            <TD><xsl:value-of select="idinfo/citation/citeinfo/pubdate"/></TD>
        </TR>
        <TR>
        	<TD>Data Type:</TD>
            <TD><xsl:value-of select="idinfo/citation/citeinfo/geoform"/></TD>
        </TR>
        <TR>
        	<TD>Data Location:</TD>
            <TD><xsl:value-of select="idinfo/citation/citeinfo/onlink"/></TD>
        </TR>
    </TABLE>

	<TABLE CLASS="DataTable">
    	<TR>
        	<TD COLSPAN="2">Description</TD>
        </TR>
        <TR>
        	<TD>Abstract:</TD>
            <TD><xsl:value-of select="idinfo/descript/abstract"/></TD>
        </TR>
        <TR>
        	<TD>Purpose:</TD>
            <TD><xsl:value-of select="idinfo/descript/purpose"/></TD>
        </TR>
    </TABLE>

	<TABLE CLASS="DataTable">
    	<TR>
        	<TD COLSPAN="2">Point Of Contact</TD>
        </TR>
        <TR>
        	<TD>Person:</TD>
            <TD><xsl:value-of select="idinfo/ptcontac/cntinfo/cntperp/cntper"/></TD>
        </TR>
        <TR>
        	<TD>Organization:</TD>
            <TD><xsl:value-of select="idinfo/ptcontac/cntinfo/cntperp/cntorg"/></TD>
        </TR>
        <TR>
        	<TD>Phone:</TD>
            <TD><xsl:value-of select="idinfo/ptcontac/cntinfo/cntvoice"/></TD>
        </TR>
        <TR>
        	<TD>Email:</TD>
            <TD><xsl:value-of select="idinfo/ptcontac/cntinfo/cntemail"/></TD>
        </TR>
        <TR>
        	<TD>Address type:</TD>
            <TD><xsl:value-of select="idinfo/ptcontac/cntinfo/cntaddr/addrtype"/></TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelOne">Address:</TD>
            <TD><xsl:value-of select="idinfo/ptcontac/cntinfo/cntaddr/address"/></TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelOne">City:</TD>
            <TD><xsl:value-of select="idinfo/ptcontac/cntinfo/cntaddr/city"/></TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelOne">State or Province:</TD>
            <TD><xsl:value-of select="idinfo/ptcontac/cntinfo/cntaddr/state"/></TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelOne">Postal code:</TD>
            <TD><xsl:value-of select="idinfo/ptcontac/cntinfo/cntaddr/postal"/></TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelOne">Country:</TD>
            <TD><xsl:value-of select="idinfo/ptcontac/cntinfo/cntaddr/country"/></TD>
        </TR>
    </TABLE>
    
    <TABLE CLASS="DataTable">
    	<TR>
        	<TD COLSPAN="2">Data Type</TD>
        </TR>
        <TR>
        	<TD>Data type:</TD>
            <TD><xsl:value-of select="idinfo/citation/citeinfo/geoform"/></TD>
        </TR>
    </TABLE>

	<TABLE CLASS="DataTable">
    	<TR>
        	<TD COLSPAN="2">Time Period of Data</TD>
        </TR>
        <TR>
        	<TD>Beginning Date:</TD>
            <TD><xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/begdate"/></TD>
        </TR>
        <TR>
        	<TD>Ending Date:</TD>
            <TD><xsl:value-of select="idinfo/timeperd/timeinfo/rngdates/enddate"/></TD>
        </TR>
        <TR>
        	<TD>Currentness reference:</TD>
            <TD><xsl:value-of select="idinfo/timeperd/current"/></TD>
        </TR>
    </TABLE>

	<TABLE CLASS="DataTable">
    	<TR>
        	<TD COLSPAN="2">Status</TD>
        </TR>
        <TR>
        	<TD>Data status:</TD>
            <TD><xsl:value-of select="idinfo/status/progress"/></TD>
        </TR>
        <TR>
        	<TD>Update frequency:</TD>
            <TD><xsl:value-of select="idinfo/status/update"/></TD>
        </TR>
    </TABLE>

	<TABLE CLASS="DataTable">
    	<TR>
        	<TD COLSPAN="2">Key Words</TD>
        </TR>
        <TR>
        	<TD COLSPAN="2">Theme:</TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelOne">Keywords:</TD>
            <TD>
            	<xsl:for-each select="idinfo/keywords/theme/themekey">
                	<xsl:value-of select="."/>
                    <xsl:if test="not(position()=last())">,</xsl:if>
                </xsl:for-each>
            </TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelOne">Keywords Thesaurus:</TD>
            <TD>
            	<xsl:for-each select="idinfo/keywords/theme/themekt">
                	<xsl:value-of select="."/>
                    <xsl:if test="not(position()=last())">,</xsl:if>
                </xsl:for-each>
            </TD>
        </TR>
        <TR>
        	<TD COLSPAN="2">Place:</TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelOne">Keywords:</TD>
            <TD>
            	<xsl:for-each select="idinfo/keywords/place/placekey">
                	<xsl:value-of select="."/>
                    <xsl:if test="not(position()=last())">,</xsl:if>
                </xsl:for-each>
            </TD>
        </TR>
        <TR>
            <TD CLASS="indentLevelOne">Keywords Thesaurus:</TD>
            <TD>
            	<xsl:for-each select="idinfo/keywords/place/placekt">
                	<xsl:value-of select="."/>
                    <xsl:if test="not(position()=last())">,</xsl:if>
                </xsl:for-each>
            </TD>
        </TR>
    </TABLE>

	<TABLE CLASS="DataTable">
    	<TR>
        	<TD COLSPAN="2">Taxonomy</TD>
        </TR>
        <TR>
        	<TD COLSPAN="2">Keywords:</TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelOne" COLSPAN="2">Taxonomic:</TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelTwo">Keywords:</TD>
            <TD>
            	<xsl:for-each select="idinfo/taxonomy/keywtax/taxonkey">
                	<xsl:value-of select="."/>
                    <xsl:if test="not(position()=last())">,</xsl:if>
                </xsl:for-each>
            </TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelTwo">Keywords thesaurus:</TD>
            <TD>
            	<xsl:for-each select="idinfo/taxonomy/keywtax/taxonkt">
                	<xsl:value-of select="."/>
                    <xsl:if test="not(position()=last())">,</xsl:if>
                </xsl:for-each>
            </TD>
        </TR>
        <TR>
        	<TD COLSPAN="2">Taxonomic system:</TD>
        </TR>
        <xsl:for-each select="idinfo/taxonomy/taxonsys/classsys/classcit/citeinfo">
            <TR>
                <TD CLASS="indentLevelOne" COLSPAN="2">Classification system or authority:</TD>
            </TR>
            <TR>
                <TD CLASS="indentLevelTwo" COLSPAN="2">Classification system citation:</TD>
            </TR>
            <TR>
                <TD CLASS="indentLevelThree">Title:</TD>
                <TD><xsl:value-of select="title"/></TD>
            </TR>
            <TR>
                <TD CLASS="indentLevelThree">Originators:</TD>
                <TD><xsl:value-of select="origin"/></TD>
            </TR>
            <TR>
                <TD CLASS="indentLevelThree">Publisher:</TD>
                <TD><xsl:value-of select="pubinfo/publish"/></TD>
            </TR>
            <TR>
                <TD CLASS="indentLevelThree">Publication place:</TD>
                <TD><xsl:value-of select="pubinfo/pubplace"/></TD>
            </TR>
            <TR>
                <TD CLASS="indentLevelThree">Publication date:</TD>
                <TD><xsl:value-of select="pubdate"/></TD>
            </TR>
            <TR>
                <TD CLASS="indentLevelThree">Data type:</TD>
                <TD><xsl:value-of select="geoform"/></TD>
            </TR>
            <TR>
                <TD CLASS="indentLevelThree">Data location:</TD>
                <TD><xsl:value-of select="onlink"/></TD>
            </TR>
        </xsl:for-each>
        <TR>
            <TD CLASS="indentLevelOne">Taxonomic procedures:</TD>
            <TD><xsl:value-of select="idinfo/taxonomy/taxonsys/taxonpro"/></TD>
        </TR>
        <TR>
            <TD CLASS="indentLevelOne">Taxonomic completeness:</TD>
            <TD><xsl:value-of select="idinfo/taxonomy/taxonsys/taxoncom"/></TD>
        </TR>
        <TR>
            <TD>General taxonomic coverage:</TD>
            <TD><xsl:value-of select="idinfo/taxonomy/taxongen"/></TD>
        </TR>
    </TABLE>

	<TABLE CLASS="DataTable">
    	<TR>
        	<TD COLSPAN="2">Data Access Constraints</TD>
        </TR>
        <TR>
        	<TD>Access constraints:</TD>
            <TD><xsl:value-of select="idinfo/accconst"/></TD>
        </TR>
        <TR>
        	<TD>Use constraints:</TD>
            <TD><xsl:value-of select="idinfo/useconst"/></TD>
        </TR>
    </TABLE>

	<TABLE CLASS="DataTable">
    	<TR>
        	<TD COLSPAN="2">Spatial Domain</TD>
        </TR>
        <TR>
        	<TD COLSPAN="2">Bounding Coordinates</TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelOne">Description of geographic extent: </TD>
            <TD><xsl:value-of select="idinfo/spdom/descgeog"/></TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelOne" COLSPAN="2">In Unprojected Coodinates (geographic)</TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelTwo" COLSPAN="2">
            	
                <TABLE CLASS="NestedDataTable">
                	<TR>
                    	<TD>Boundary</TD>
                        <TD>Coordinate</TD>
                    </TR>
                    <TR>
                    	<TD>West</TD>
                        <TD><xsl:value-of select="idinfo/spdom/bounding/westbc"/> (longitude)</TD>
                    </TR>
                    <TR>
                    	<TD>East</TD>
                        <TD><xsl:value-of select="idinfo/spdom/bounding/eastbc"/> (longitude)</TD>
                    </TR>
                    <TR>
                    	<TD>North</TD>
                        <TD><xsl:value-of select="idinfo/spdom/bounding/northbc"/> (latitude)</TD>
                    </TR>
                    <TR>
                    	<TD>South</TD>
                        <TD><xsl:value-of select="idinfo/spdom/bounding/southbc"/> (latitude)</TD>
                    </TR>
                </TABLE>
                
            </TD>
        </TR>
    </TABLE>

	<TABLE CLASS="DataTable">
    	<TR>
        	<TD COLSPAN="2">Overview</TD>
        </TR>
        <TR>
        	<TD COLSPAN="2"><xsl:value-of select="eainfo/overview/eaover"/></TD>
        </TR>
        <TR>
            <TD></TD>
            <TD><xsl:value-of select="eainfo/overview/eadetcit"/></TD>
        </TR>
        <TR>
        	<TD>Direct spatial reference method:</TD>
            <TD><xsl:value-of select="spdoinfo/direct"/></TD>
        </TR>
        
    </TABLE>

	<TABLE CLASS="DataTable">
    	<TR>
        	<TD COLSPAN="2">General</TD>
        </TR>
        <TR>
        	<TD>Logical consistency report:</TD>
            <TD><xsl:value-of select="dataqual/logic"/></TD>
        </TR>
        <TR>
        	<TD>Completeness report:</TD>
            <TD><xsl:value-of select="dataqual/complete"/></TD>
        </TR>
    </TABLE>

	<TABLE CLASS="DataTable">
    	<TR>
        	<TD COLSPAN="2">Attribute Accuracy</TD>
        </TR>
        <TR>
        	<TD>Attribute accuracy report:</TD>
            <TD><xsl:value-of select="dataqual/attracc/attraccr"/></TD>
        </TR>
    </TABLE>

	<TABLE CLASS="DataTable">
    	<TR>
        	<TD COLSPAN="2">Positional Accuracy</TD>
        </TR>
        <TR>
        	<TD>Horizontal accuracy report:</TD>
            <TD><xsl:value-of select="dataqual/posacc/horizpa/horizpar"/></TD>
        </TR>
        <TR>
        	<TD>Vertical accuracy report:</TD>
            <TD><xsl:value-of select="dataqual/posacc/vertacc/vertaccr"/></TD>
        </TR>
    </TABLE>

	<TABLE CLASS="DataTable">
    	<TR>
        	<TD COLSPAN="2">Methodology</TD>
        </TR>
        <TR>
            <TD COLSPAN="2">Methodology information</TD>
        </TR>
        <xsl:for-each select="dataqual/lineage/method">
            <TR>
                <TD CLASS="indentLevelOne" COLSPAN="2">Method <xsl:value-of select="position()" /></TD>
            </TR>
            <TR>
                <TD CLASS="indentLevelTwo">Methodology type:</TD>
                <TD><xsl:value-of select="methtype"/></TD>
            </TR>
            <TR>
                <TD CLASS="indentLevelTwo">Methodology description:</TD>
                <TD><xsl:value-of select="methdesc"/></TD>
            </TR>
            <TR>
                <TD CLASS="indentLevelTwo" COLSPAN="2">Citation:</TD>
            </TR>
            <TR>
                <TD CLASS="indentLevelThree">Title:</TD>
                <TD><xsl:value-of select="methcite/citeinfo/title"/></TD>
            </TR>
            <TR>
                <TD CLASS="indentLevelThree">Originators:</TD>
                <TD><xsl:value-of select="methcite/citeinfo/origin"/></TD>
            </TR>
            <TR>
                <TD CLASS="indentLevelThree">Publication date:</TD>
                <TD><xsl:value-of select="methcite/citeinfo/pubdate"/></TD>
            </TR>
            <TR>
                <TD CLASS="indentLevelThree">Data type:</TD>
                <TD><xsl:value-of select="methcite/citeinfo/geoform"/></TD>
            </TR>
            <TR>
                <TD CLASS="indentLevelThree">Data location:</TD>
                <TD><xsl:value-of select="methcite/citeinfo/onlink"/></TD>
            </TR>
        </xsl:for-each>
    </TABLE>

	<TABLE CLASS="DataTable">
    	<TR>
        	<TD COLSPAN="2">Process Steps</TD>
        </TR>
        <TR>
            <TD COLSPAN="2">Process step information</TD>
        </TR>
        <xsl:for-each select="dataqual/lineage/procstep">
        	<TR>
                <TD CLASS="indentLevelOne" COLSPAN="2">Process Step <xsl:value-of select="position()" /></TD>
            </TR>
            <TR>
                <TD CLASS="indentLevelTwo">Process description:</TD>
                <TD><xsl:value-of select="procdesc"/></TD>
            </TR>
            <TR>
                <TD CLASS="indentLevelTwo">Process date:</TD>
                <TD><xsl:value-of select="procdate"/></TD>
            </TR>
        </xsl:for-each>
    </TABLE>

	<TABLE CLASS="DataTable">
    	<TR>
        	<TD COLSPAN="2">General</TD>
        </TR>
        <TR>
            <TD>Distribution liability:</TD>
            <TD><xsl:value-of select="distinfo/distliab"/></TD>
        </TR>
    </TABLE>
    
    <TABLE CLASS="DataTable">
    	<TR>
        	<TD COLSPAN="2">Distribution Point Of Contact</TD>
        </TR>
        <TR>
        	<TD>Person:</TD>
            <TD><xsl:value-of select="distinfo/distrib/cntinfo/cntperp/cntper"/></TD>
        </TR>
        <TR>
        	<TD>Organization:</TD>
            <TD><xsl:value-of select="distinfo/distrib/cntinfo/cntperp/cntorg"/></TD>
        </TR>
        <TR>
        	<TD>Phone:</TD>
            <TD><xsl:value-of select="distinfo/distrib/cntinfo/cntvoice"/></TD>
        </TR>
        <TR>
        	<TD>Email:</TD>
            <TD><xsl:value-of select="distinfo/distrib/cntinfo/cntemail"/></TD>
        </TR>
        <TR>
        	<TD>Address type:</TD>
            <TD><xsl:value-of select="distinfo/distrib/cntinfo/cntaddr/addrtype"/></TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelOne">Address:</TD>
            <TD><xsl:value-of select="distinfo/distrib/cntinfo/cntaddr/address"/></TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelOne">City:</TD>
            <TD><xsl:value-of select="distinfo/distrib/cntinfo/cntaddr/city"/></TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelOne">State or Province:</TD>
            <TD><xsl:value-of select="distinfo/distrib/cntinfo/cntaddr/state"/></TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelOne">Postal code:</TD>
            <TD><xsl:value-of select="distinfo/distrib/cntinfo/cntaddr/postal"/></TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelOne">Country:</TD>
            <TD><xsl:value-of select="distinfo/distrib/cntinfo/cntaddr/country"/></TD>
        </TR>
    </TABLE>
    
    <TABLE CLASS="DataTable">
    	<TR>
        	<TD COLSPAN="2">Metadata Point Of Contact</TD>
        </TR>
        <TR>
        	<TD>Person:</TD>
            <TD><xsl:value-of select="metainfo/metc/cntinfo/cntperp/cntper"/></TD>
        </TR>
        <TR>
        	<TD>Organization:</TD>
            <TD><xsl:value-of select="metainfo/metc/cntinfo/cntperp/cntorg"/></TD>
        </TR>
        <TR>
        	<TD>Phone:</TD>
            <TD><xsl:value-of select="metainfo/metc/cntinfo/cntvoice"/></TD>
        </TR>
        <TR>
        	<TD>Email:</TD>
            <TD><xsl:value-of select="metainfo/metc/cntinfo/cntemail"/></TD>
        </TR>
        <TR>
        	<TD>Address type:</TD>
            <TD><xsl:value-of select="metainfo/metc/cntinfo/cntaddr/addrtype"/></TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelOne">Address:</TD>
            <TD><xsl:value-of select="metainfo/metc/cntinfo/cntaddr/address"/></TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelOne">City:</TD>
            <TD><xsl:value-of select="metainfo/metc/cntinfo/cntaddr/city"/></TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelOne">State or Province:</TD>
            <TD><xsl:value-of select="metainfo/metc/cntinfo/cntaddr/state"/></TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelOne">Postal code:</TD>
            <TD><xsl:value-of select="metainfo/metc/cntinfo/cntaddr/postal"/></TD>
        </TR>
        <TR>
        	<TD CLASS="indentLevelOne">Country:</TD>
            <TD><xsl:value-of select="metainfo/metc/cntinfo/cntaddr/country"/></TD>
        </TR>
    </TABLE>
    
    <TABLE CLASS="DataTable">
    	<TR>
        	<TD COLSPAN="2">Metadata Standards</TD>
        </TR>
        <TR>
            <TD>Standard name:</TD>
            <TD><xsl:value-of select="metainfo/metstdn"/></TD>
        </TR>
        <TR>
            <TD>Standard version:</TD>
            <TD><xsl:value-of select="metainfo/metstdv"/></TD>
        </TR>
    </TABLE>

</xsl:template>

</xsl:stylesheet>