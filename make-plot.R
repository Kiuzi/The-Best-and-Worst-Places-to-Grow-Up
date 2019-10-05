library(ggplot2)
library(dplyr)

data<- read.csv("data/Household_Income.csv", header=TRUE, stringsAsFactors=FALSE)

## Making counties and states names lowercase to match the "counties" dataset used for mapping
data$County<-tolower(data$County) 
data$State<-tolower(data$State)  
states <- map_data("state") 
counties <- map_data("county") 
names(counties)[5:6]<-c("State","County") # changing the counties data set column names from region and subregion
# to State and County respectively to match our data set   
newdata<- left_join(counties, data, by = c("State","County"))

### Plotting the graph ###
ditch_the_axes <- theme(    
  axis.text = element_blank(),
  axis.line = element_blank(),
  axis.ticks = element_blank(),
  panel.border = element_blank(),
  panel.grid = element_blank(),
  panel.background = element_blank(),
  axis.title = element_blank(),
  legend.text = element_text(size = 8),
  legend.title = element_text(size= 8),
  legend.justification=c(0,0), legend.position=c(0.85,0)
)

# US States map #
map<- ggplot(data = states, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) + 
  geom_polygon(color = "white", fill = "gray")

# First Option, Colours are selected Manually #
map + geom_polygon(data = newdata, aes(fill= cut_interval(newdata[,8],12)),colour="white",size=0.1) +
  scale_fill_manual( values=rev(c("navyblue", "darkblue","dodgerblue4", "steelblue4",
                                  "paleturquoise4", "darkseagreen", "lightgoldenrod1", "lightgoldenrod2",
                                  "sienna3", "chocolate4", "darkred","brown4")), na.value="gray95")+
  ditch_the_axes 

# Second Option, Colours are the extention of "Spectral" Palette #
map + geom_polygon(data = newdata, aes(fill= cut_interval(newdata[,8],18)), colour="white", size=0.1) +
  scale_fill_manual(values=colorRampPalette(RColorBrewer::brewer.pal(11, "Spectral"))(17), na.value="gray95") +
  ditch_the_axes 

# Third Option, probably the closest graph to the original one; Colours are
# selected from the "Spectral" Palette and were extended manually by adding 4 colours
colour_vec<-as.vector(colorRampPalette(RColorBrewer::brewer.pal(11, "Spectral"))(11))
colour_vec_manual=c("#660000","#990000", colour_vec,"#000099","#000066") 

map + geom_polygon(data = newdata, aes(fill= newdata[,8]), colour="white", size=0.1) +
  scale_fill_gradientn( colours=colour_vec_manual, na.value="gray95",
                        name="Percentage increace \na county causes \nchildren in poor \nfamilies to make, \ncompared with children \nin porr families nationwide") +
  ditch_the_axes 





