################################################################################
# Main R script for Stirling engine project
# Mauricio Klein Gussoli
# Stirling Engine Comparison 
################################################################################
### Libraries
library(readxl)
library(tidyverse)

### Importação dos dados coletados pelo Digitizer
dados_comparacao_principal <- read_excel("dados_comparacao_principal.xlsx", 
                                         sheet = "PeVse comparaçao")
View(dados_comparacao_principal)
