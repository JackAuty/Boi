Boi_hist <- function(df, column){
  if(is.data.frame(df)){
    print("dataframe provided")
    df<-as.data.frame(df[,column])
    colnames(df)<-"P_value"
    
  }
  
  if(missing(column)){
    print("vector provided")
    df<-data.frame(df)
    colnames(df)<-"P_value"
    
  }
  bins <- seq(0, 1, by = 0.025)
  
  significant_count<- sum(df$P_value < 0.05)
  
  df$P_value_label <- factor(df$P_value < 0.05, levels = c(TRUE, FALSE))
  
  # Calculate the histogram data first to get counts within the bins
  hist_data <- ggplot(df, aes(x = P_value)) +
    geom_histogram(
      breaks = bins,
      aes(y = ..count..),
      color = "black",
      stat = "bin"
    )
  
  # Extract the count values and find the maximum count
  counts <- ggplot_build(hist_data)$data[[1]]$count
  
  
  ylim<- max(counts)
  
  plot<-ggplot(df, aes(x=P_value, fill = P_value_label))+
    geom_histogram(
      breaks = bins
    )+
    scale_fill_manual(
      values = c("TRUE" = "#99009999", "FALSE" ="#00999999"),
      labels = c("TRUE" = "Significant", "FALSE" ="Non-Significant"),
    )+
    scale_x_continuous(expand = c(0,0), limits=c(0,1))+
    scale_y_continuous(expand = c(0,0), limits=c(0,1.2*ylim))+
    labs(
      x="P value",
      y= "Count"
    )+    
    annotation_custom(
      grob = textGrob(paste0("Count of significant p-values: ", 
                             significant_count), gp = gpar(fontsize = 10)),
      xmin = 0, xmax = 1, ymin = -0.4*ylim, ymax = -0.4*ylim
    ) +
    theme_classic()+
    theme(
      legend.position = "bottom",
      legend.background = element_rect(fill = "transparent", color = NA),
      legend.title = element_blank(),
      legend.text = element_text(size = 14, face = "bold"),
      plot.margin = margin(c(10, 10, 30, 10)))+
    
    coord_cartesian(clip = 'off')
  
  return(plot)
}
