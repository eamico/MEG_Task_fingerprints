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

#
## Read data and process before plotting
#

getwd()
setwd("D:/Work/San_camillo/MEG_fingerprinting/github/")

dat <- readMat("./data/Fig_2b_data.mat")
dat <- as.data.frame(dat)

names(dat)[1]="SR"
names(dat)[2]="Idiff"
names(dat)[3]="Bands"
names(dat)[4]="Task"

dat$Bands <-factor(dat$Bands,
                   levels = c(1,2,3,4,5),
                   labels = c("Delta", "Theta","Alpha","Beta","Gamma")) 

dat$Task <-factor(dat$Task,
                  levels = c(1,2,3,4,5,6,7),
                  labels = c("REST", "PROSE","ASSR","MMN","PROSE x REST","ASSR x REST","MMN x REST")) 

dat$Idiff=dat$Idiff*100
Zissou3 = c("#3B9AB2", "#78B7C5", "#EBCC2A", "#E1AF00", "#ff98ba")

#
## Plot Figure 2b
#

main_folder = "./Figures/"
width=10
height=5

p1 <- ggplot(data=dat, aes(x=Task, y=SR, fill=Bands)) + 
      geom_bar(stat="identity", position=position_dodge()) + 
      scale_fill_manual(values= Zissou3)

p1 + ylab("SR (%)") + labs(fill = "Band") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.title.x =element_blank()) +
  theme(axis.title.y = element_text(size=11, face ="bold"))  +
  theme(axis.text.x = element_text(size=11, face ="bold", angle = 30, hjust=1))  

ggsave(filename= file.path(main_folder,"Figure2_SR_AEC.svg"), width = width, height = height, device='svg', dpi=900)


p2 <- ggplot(data=dat, aes(x=Task, y=Idiff, fill=Bands)) + 
      geom_bar(stat="identity", position=position_dodge()) + 
      scale_fill_manual(values= Zissou3)

p2 + ylab("Idiff (%)") + labs(fill = "Band") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.title.x =element_blank()) +
  theme(axis.title.y = element_text(size=11, face ="bold"))  +
  theme(axis.text.x = element_text(size=11, face ="bold", angle = 30, hjust=1))  

ggsave(filename= file.path(main_folder,"Figure2_Idiff_AEC.svg"), width = width, height = height, device='svg', dpi=900)
