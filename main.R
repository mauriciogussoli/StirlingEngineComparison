################################################################################
# Main R script for Stirling engine project
# Mauricio Klein Gussoli
# Stirling Engine Comparison 
################################################################################
### Libraries
library(readxl)
library(tidyverse)

### Importação dos dados coletados pelo Digitizer
dados <- read_excel("dados_comparacao_principal.xlsx", 
                                         sheet = "PeVse"
## Divisão dos motores em HTD,MTD e LTD com diferentes fluidos de trabalho
ggplot(dados)+
  geom_jitter(aes(x = ft, y = pevse), width = 0.2)+
  facet_wrap(~gas)+
  stat_summary(aes(x = ft, y =pevse), 
               fun = mean, 
               geom = 'point', 
               colour = 'red')
## Verificação de motores de diferentes classes de temperatura e geometrias
ggplot(dados)+
  geom_point(aes(x = vse, 
                 y = pevse, 
                 colour = cfg, 
                 shape = ft, 
                 size = cfg), 
             alpha = 0.3)

## Verificação de potencia específica para diferentes pressões com limitações de 0 a 10 bar
ggplot(dados)+
  geom_point(aes(x = pmbar, y = pevse, colour = gas, shape = cfg))+
  coord_cartesian(xlim = c(0,10), 
                  ylim = c(0,5))
                  