## Library
library(RColorBrewer)
library(gplots)
library(R.matlab)
library(tidyr)
library(dplyr)
library(ggplot2)
library(ggpubr)
library(ggpol)
library("wesanderson")
library(svglite)
library(ggridges)

#
## Read data for Ridgeline plot Figure 3.
#

getwd()
setwd("D:/Work/San_camillo/MEG_fingerprinting/github/")

dat <- readMat("./data/Fig_3_data.mat")
dat <- as.data.frame(dat)

names(dat)[1]="values"
names(dat)[2]="Iscore"
names(dat)[3]="Bands"
names(dat)[4]="Tasks"

dat$Bands <-factor(dat$Bands,
                   levels = c(1,2,3,4,5),
                   labels = c("Delta","Theta","Alpha", "Beta","Gamma")) 

dat$Iscore <-factor(dat$Iscore,
                    levels = c(1,2),
                    labels = c("ISelf", "IOthers")) 

dat$Tasks <-factor(dat$Tasks, levels= c(1,2,3,4),
                   c("REST","PROSE","ASSR","MMN"))

#
## Subset for ALPHA/BETA frequency bands for main manuscript Figure 3.
#

sub_mat=subset(dat, dat$Bands=='Alpha' | dat$Bands=='Beta')

#
## Plot Figure 3
#

main_folder = "./Figures/"
width=10
height=5

ggplot(sub_mat, aes(values, fill=Iscore, colour=Iscore)) + 
      geom_density(alpha = 0.4, lwd=0.8, adjust=0.5)

thm <- theme_minimal() + theme(text = element_text(size = 16))

ggplot(sub_mat) +
  geom_density_ridges2(aes(x=values, y=Tasks, group= interaction(Iscore,Tasks), fill=Iscore), alpha = 0.7, scale=0.7) +
  ylab(NULL) +
  facet_wrap(~Bands)+
  theme_ridges(grid = TRUE)

ggsave(filename= file.path(main_folder,"Figure3.svg"), width = width, height = height, device='svg', dpi=900)

