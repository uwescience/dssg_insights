# Useful functions

percForm <- function(x){
  return(round(x))
}

plot_fun <- function(df1, df2, mylevels, divergent = T, lk_levels = 5, pal = c('#b2182b','#ef8a62','#d1e5f0','#67a9cf','#2166ac')) {
  if(divergent == T) {
    h_total <- df1 %>%
      group_by(question) %>%
      summarise(total=percForm(sum(value)))
    
    if(lk_levels == 4) {
      pal <- c('#ef8a62','#d1e5f0','#67a9cf','#2166ac')
      legend.pal <- pal
    } else {
      legend.pal = pal
    }
    
    ggplot() + geom_bar(data=df1, aes(x = question, y=value, fill=col), width=.5, position="stack", stat="identity") +
      geom_bar(data=df2, aes(x = question, y=-value, fill=col), width=.5, position="stack", stat="identity") +
      geom_hline(yintercept = 0, color =c("grey")) +
      # geom_text(data = h_total, aes(x = question, y = total,label = paste0(total,'%')), size = 6 , position = position_stack(vjust = 1.2)) +
      scale_fill_identity("", labels = mylevels, breaks=legend.pal, guide = 'legend') +
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) +
      coord_flip() +
      labs(title='', y="",x="") +
      theme(plot.title = element_blank()) +
      theme(legend.position = "bottom") +
      theme(
        panel.background = element_blank(),
        panel.grid.major = element_line(colour="#969696", size=0.3,linetype = "dashed"),
        panel.grid.major.x = element_blank(),
        axis.ticks.y=element_blank())
    
  } else {
    
    if(lk_levels == 4) {
      pal <- c('#ef8a62','#d1e5f0','#67a9cf','#2166ac')
      legend.pal <- pal
    } else {
      legend.pal = pal
    }
    
    ggplot() + geom_bar(data=df1, aes(x = question, y=value, fill=col), width=.5, position="stack", stat="identity") +
      # geom_bar(data=lows, aes(x = question, y=-value, fill=col), width=.5, position="stack", stat="identity") +
      geom_hline(yintercept = 0, color =c("grey")) +
      #geom_text(data = high, aes(x = question, y = value,label = paste0(value,'%')), size = 6 , position = position_stack(vjust = 0)) +
      scale_fill_identity("", labels = mylevels, breaks=legend.pal, guide = 'legend') +
      scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) +
      coord_flip() +
      labs(title='', y="",x="") +
      theme(plot.title = element_blank()) +
      theme(legend.position = "bottom") +
      theme(
        panel.background = element_blank(),
        panel.grid.major = element_line(colour="#969696", size=0.3,linetype = "dashed"),
        panel.grid.major.x = element_blank(),
        axis.ticks.y=element_blank())
  }
}

data_mung <- function(df, r1,r2) {
  qs <- c(
    names(df)[r1:r2]
  )
  
  l <- list()
  
  for(i in qs) {
    l[[i]] <- df %>%
      select(response = i) %>%
      group_by(response) %>%
      summarise(num=length(response)) %>%
      mutate(total =sum(num),
             perc = num/total) %>%
      mutate(question = i) %>%
      gather(val_type, val, c('num', 'total','perc')) %>%
      unite(response_type, response, val_type) %>%
      spread(response_type, val)
  }
  l
}

likert_df <- function(df, id, mymin = -100, mymax = 100, lk_levels = 5, pal = c('#b2182b','#ef8a62','#d1e5f0','#67a9cf','#2166ac') ) {
  tab<-df_plot
  
  numlevels<-length(tab[1,])-1
  point1<-2
  point2<-((numlevels)/2)+1
  point3<-point2+1
  point4<-point3+1
  point5<-numlevels+1
  
  point1;point2;point3;point4;point5;mymin;mymax
  
  tab2<-tab
  
  numlevels<-length(tab[1,])-1
  temp.rows<-nrow(tab2)
  
  if(lk_levels == 4) {
    pal <- c('#ef8a62','#d1e5f0','#67a9cf','#2166ac')
    legend.pal <- pal
  } else {
    legend.pal = pal
  }
  
  tab3<-melt(tab2,id=id)
  tab3$col<-rep(pal,each=temp.rows)
  tab3$value<-tab3$value*100
  tab3
}

