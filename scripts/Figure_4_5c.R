# load libraries ----------------------------------------------------------
library(tidyverse)
library(stringr)
library(prismatic) #package to view colors in console output
library(Cairo) #for export type
library(scales)
library(extrafont) #additional fonts
library(wesanderson)
library(R.matlab)

# Set working directory
getwd()
setwd("D:/Work/San_camillo/MEG_fingerprinting/github/")



## Polar plots for Edgewise subject fingerprint ICC

# load data ---------------------------------------------------------------
#data <- readMat("./data/Fig_4-5c/alpha_polar_rest1_rest2.mat")
#data <- readMat("./data/Fig_4-5c/alpha_polar_prose_task1_task2.mat")
#data <- readMat("./data/Fig_4-5c/alpha_polar_ASSR_task1_task2.mat")
data <- readMat("./data/Fig_4-5c/alpha_polar_MMN_task1_task2.mat")

# Colormap
cmap_matlab <- "./data/Template/zissou_cmap.txt"
zissou_matlab <- readLines(cmap_matlab)


# data manipulation -------------------------------------------------------
data<-as.data.frame(data)

names(data)[1]="network"
names(data)[2]="inter"
names(data)[3]="intra"

data$network <-factor(data$network,
                      levels = c(1,2,3,4,5,6,7),
                      labels = c("VIS", "SM","DA","VA","L","FP","DMN")) 



# Plot Polar Plots -------------------------------------------------------
ggplot(data) +
  
  #make custom panel grid
  geom_hline(yintercept = 0, color = "black")  +
  geom_hline(yintercept = 0.25, color = "black")  +
  geom_hline(yintercept = 0.5, color = "black") +
  geom_hline(yintercept = 0.75, color = "black") +
  geom_hline(yintercept = 1, color = "black") +
  
  
  geom_col(aes(
    x = network, #is numeric
    y = intra, #is numeric
    fill = inter), #is a factor
    position = "dodge",
    show.legend = TRUE,
    alpha = 1) +
  
  #scale y axis so bars don't start in the center
  scale_y_continuous(limits = c(-0.5, 1.25),
                     expand = c(0,0))+
  
  scale_fill_gradientn(limits= c(0.25 ,1), "Average Inter-network ICC",
                       colours = zissou_matlab, breaks=c(0.25,0.5,0.75,1))+
  
  #annotate custom scale inside plot
  annotate(x="",y=c(0.33,0.58,0.83,1.08), label=c("0.25","0.5","0.75","1"),size=4,geom="text", angle='-15') +
  annotate(x="",y=c(1.25), label=c("Intra-network ICC"),size=4,geom="text", angle='-15') +
  
  coord_polar() +
  theme_minimal()+
  
  theme(axis.title = element_blank(),
        axis.ticks = element_blank(),
        axis.text.y = element_blank(),
        axis.text.x = element_text(color = "gray12",
                                   size = 12),
        panel.background = element_rect(fill = "white",
                                        color = "white"),
        panel.grid = element_blank(),
        panel.grid.major.x = element_blank(),
        text = element_text(color = "gray12",
                            family = "Bell MT"),
        plot.title = element_text(face = "bold",
                                  size = 25,
                                  hjust = 0.05),
        plot.subtitle = element_text(size = 14,
                                     hjust = 0.05),
        plot.caption = element_text(size = 10,
                                    hjust = .5))+
  
  guides(fill = guide_colourbar(barwidth = 0.5,
                                barheight = 15, 
                                title.position = "top",
                                title.hjust = .7))
