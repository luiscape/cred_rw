## Plotting functions
library(ggplot2)

# loading data
data <- read.csv('data/data.csv')


## plotting ##
# creating sparklines 
spark_plot <- ggplot(data, aes(period, value, color = source)) + theme_bw() +
    geom_line(stat = 'identity', size = 1) +
    facet_wrap(~ iso3, scale = "free_y") +
    theme(panel.border = element_rect(linetype = 0),
          strip.background = element_rect(colour = "white", fill = "white"),
          panel.background = element_rect(colour = "white"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks = element_blank(),
          legend.title = element_blank(),
          legend.key = element_blank()) +
    ylab("") + xlab("")


ggsave('plot/spark_plot.png', spark_plot, heigh = 10.5, width = 16.39, units = 'in')


## comparing totals ##
# relifeweb
rw_total <- data[data$source == 'rw', ]
year_list <- unique(rw_total$period)
for (i in 1:length(unique(rw_total$period))) {
    it <- rw_total[rw_total$period == year_list[i], ]
    total <- data.frame(iso3 = 'WLD',
                        name = 'World',
                        period = year_list[i],
                        value = sum(it$value),
                        source = 'ReliefWeb'
                        )
    rw_total <- rbind(rw_total, total)
}

# cred
cred_total <- data[data$source == 'cred', ]
year_list <- unique(cred_total$period)
for (i in 1:length(unique(cred_total$period))) {
    it <- cred_total[cred_total$period == year_list[i], ]
    total <- data.frame(iso3 = 'WLD',
                        name = 'World',
                        period = year_list[i],
                        value = sum(it$value, na.rm = T),
                        source = 'CRED'
    )
    cred_total <- rbind(cred_total, total)
}

data_total <- rbind(rw_total, cred_total)

## plotting ##
world <- data_total[data_total$iso3 == 'WLD', ]

world_spark_plot <- ggplot(world, aes(period, value, color = source)) + theme_bw() +
    geom_line(stat = 'identity', size = 1.3) +
    ylab("") + xlab("") +
    theme(panel.border = element_rect(linetype = 0),
          strip.background = element_rect(colour = "white", fill = "white"),
          panel.background = element_rect(colour = "white"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          legend.title = element_blank(),
          legend.key = element_blank())
    
ggsave('plot/world_spark_plot.png', world_spark_plot, width = 9.11, height = 3, units = 'in')


world_spark_plot_scale <- ggplot(world, aes(period, value, color = source)) + theme_bw() +
    geom_line(stat = 'identity', size = 1.3) +
    facet_wrap(~ source, scale = 'free_y') +
    ylab("") + xlab("") +
    theme(panel.border = element_rect(linetype = 0),
          strip.background = element_rect(colour = "white", fill = "white"),
          panel.background = element_rect(colour = "white"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          legend.title = element_blank(),
          legend.key = element_blank())
    

ggsave('plot/world_spark_plot_scale.png', world_spark_plot_scale, width = 9.11, height = 3, units = 'in')

