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

<xsl:template match="tablestructs">

	<TABLE CLASS="DataTable">
    
    	<TR>
        	<TD COLSPAN="2">NABBS Dataset 1966-2016: Data Files and Field Definitions</TD>
        </TR>

        <xsl:for-each select="datatype">
          <TR>
              <TD COLSPAN="2">
                  <TABLE CLASS="NestedDataTable" STYLE="margin-top: 20px;">
                      <TR>
                          <TD COLSPAN="2"><xsl:value-of select="@description"/></TD>
                      </TR>
                  </TABLE>
              </TD>
          </TR>
          
          <xsl:for-each select="filegroup">
          
              <TR>
                  <TD CLASS="indentLevelOne" COLSPAN="2">
                  
                      <TABLE CLASS="NestedDataTable">
                          <TR>
                              <TD>File Name</TD>
                              <TD>Description</TD>
                          </TR>
                          
                          <xsl:for-each select="files">
                            <xsl:choose>
                                <xsl:when test="@description">
                                    <xsl:for-each select="file">
                                        <TR>
                                          <TD><xsl:value-of select="@name"/></TD>
                                          <xsl:if test="position()=1">
                                              <TD ROWSPAN="0"><xsl:value-of select="../@description"/></TD>
                                          </xsl:if>
                                        </TR>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:for-each select="file">
                                        <TR>
                                          <TD><xsl:value-of select="@name"/></TD>
                                          <TD><xsl:value-of select="@description"/></TD>
                                        </TR>
                                    </xsl:for-each>
                                </xsl:otherwise>
                            </xsl:choose>                    
                          </xsl:for-each>
                      
                      </TABLE>
                  
                  </TD>    
              </TR>
              
              <TR>
                  <TD CLASS="indentLevelTwo" COLSPAN="2">
                  
                      <TABLE CLASS="NestedDataTable">
                          <TR>
                              <TD>Field Name</TD>
                              <TD>Field Type</TD>
                              <TD>Field Description</TD>
                          </TR>
                          <xsl:for-each select="fieldset/field">
                              <TR>
                                  <TD><xsl:value-of select="@name"/></TD>
                                  <TD><xsl:value-of select="@datatype"/></TD>
                                  <TD><xsl:value-of select="@description"/></TD>
                              </TR>
                          </xsl:for-each>
                      </TABLE>
                  
                  </TD>
              </TR>
          
          </xsl:for-each>
          
      </xsl:for-each>
      
  </TABLE>

</xsl:template>

</xsl:stylesheet>