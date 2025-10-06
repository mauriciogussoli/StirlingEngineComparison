################################################################################
# Main R script for Stirling engine project
# Mauricio Klein Gussoli
# Stirling Engine Comparison 
################################################################################
### Libraries
library(readxl)
library(tidyverse)

### Import data collected from Digitizer The data collected has its origin in the
## literature. They are mainly (if not total)from experimental papers. Then, all
## the data is collected with a digitizer software, specially the power and speed
## of rotation of the engine. Also, the geometric and the parameters of the tests
## are collected for the analysis. Depending on the paper, the engine is the
## same, but the parameters of pressure, temperature, working fluid, etc, are
## different
StirlingEngineData <- read_excel("StirlingEngineData.xlsx", 
                                 col_types = c("text", "text", "text", 
                                               "text", "numeric", "numeric", "numeric", 
                                               "numeric", "numeric", "numeric", 
                                               "numeric", "numeric", "numeric", 
                                               "numeric"))
### Manipulating data of StirlingEngineData
## Generating new useful columns
# Calculate the ratio Tc/Th and Th/Tc
StirlingEngineData <- StirlingEngineData %>% 
  mutate(tcth = tcK/thK) %>% 
  mutate(thtc = tcth^(-1), .after = 'tcth')
# Classify into low, medium and high temperature
StirlingEngineData <- StirlingEngineData %>% 
  mutate(ft = if_else(StirlingEngineData$tcth > 0.7, "LTD", 
                      if_else(StirlingEngineData$tcth > 0.4, "MTD", "HTD")))
# Calculate specific power (Pe/Vse [W/cm3])
StirlingEngineData <- StirlingEngineData %>% 
  mutate(pevse = peW/vse, .after = 'nrpm')

# Calculating averages w/ summarise
SEDaverages <- StirlingEngineData %>% 
  group_by(motor) %>% 
  summarise(peW = mean(peW), 
            nrpm = mean(nrpm), 
            pevse = mean(pevse), 
            maxpevse = max(pevse),
            tcth = mean(tcth))
  
SEDaverages <- SEDaverages %>%  
  mutate(ft = if_else(SEDaverages$tcth > 0.7, "LTD", 
                      if_else(SEDaverages$tcth > 0.4, "MTD", "HTD")))


 


### Summaries for different engine configuration (alpha, beta, gamma)
alphaSE <- StirlingEngineData %>%
  filter(cfg == "a") %>%
  summary(alphaSE)
betaSE <- StirlingEngineData %>% 
  filter(cfg == "b") %>% 
  summary(betaSE)
gammaSE <- StirlingEngineData %>% 
  filter(cfg == "g") %>% 
  summary(gammaSE)

# ## Engines classified in HTD,MTD and LTD with different working fluids
# ggplot(StirlingEngineData)+
#   geom_jitter(aes(x = ft, y = pevse), width = 0.2)+
#   facet_wrap(~gas)+
#   stat_summary(aes(x = ft, y =pevse), 
#                fun = mean, 
#                geom = 'point', 
#                colour = 'red')
# ## Engines of different cfg and geometries for fixed vse
# ggplot(StirlingEngineData)+
#   geom_point(aes(x = vse, 
#                  y = pevse, 
#                  colour = cfg, 
#                  shape = ft, 
#                  size = cfg), 
#              alpha = 0.3)
# ## Specific power for different working fluid and geometries
# ggplot(StirlingEngineData)+
#   geom_point(aes(x = pmbar, y = pevse, colour = gas, shape = cfg))+
#   coord_cartesian(xlim = c(0,10), 
#                   ylim = c(0,5))