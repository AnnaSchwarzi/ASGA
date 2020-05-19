################################################################################
# Shiny UI-Home
#
# (c) 2019 Kiewisz
# This code is licensed under GPL V3.0 license (see LICENSE.txt for details)
#
# Author: Robert Kiewisz
# Created: 2020-05-17
################################################################################


# Shiny UI-Home  ---------------------------------------------------------------
fluidPage(
  includeCSS("www/css/style.css"),
  
  useShinyalert(),
  
  navbarPage(title = "ASGA V0.3-beta",
             collapsible = TRUE,
             inverse = TRUE,
             position = "fixed-top",
             id = "innavbar",
             selected = "Home",
             footer = footnoteUI("footnore"),
             tabPanel("GetStarted",
                      GetStarted_UI("Home")
             ),
             
             tabPanel("Home",
                      fluidRow(
                        homeUI("Home")
                      )
             ), 
             
             tabPanel("Wiki",
                      fluidRow()
             ),
             
             tabPanel("About",
                      fluidRow()
             )
  )
)