################################################################################
# Main R script for Stirling engine project
# Mauricio Klein Gussoli
# Stirling Engine Comparison 
################################################################################
### Libraries
library(readxl)
library(tidyverse)

### Import data collected from Digitizer
dados <- read_excel("dados_comparacao_principal.xlsx", 
                                         sheet = "PeVse")
## Engines classified in HTD,MTD and LTD with different working fluids
ggplot(dados)+
  geom_jitter(aes(x = ft, y = pevse), width = 0.2)+
  facet_wrap(~gas)+
  stat_summary(aes(x = ft, y =pevse), 
               fun = mean, 
               geom = 'point', 
               colour = 'red')
## Engines of different cfg and geometries for fixed vse
ggplot(dados)+
  geom_point(aes(x = vse, 
                 y = pevse, 
                 colour = cfg, 
                 shape = ft, 
                 size = cfg), 
             alpha = 0.3)
## Specific power for different working fluid and geometries
ggplot(dados)+
  geom_point(aes(x = pmbar, y = pevse, colour = gas, shape = cfg))+
  coord_cartesian(xlim = c(0,10), 
                  ylim = c(0,5))