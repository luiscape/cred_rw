## Collecting data from CKAN.
library(reshape2)  # to melt data out of the current format

## downloading data ##
# CH070
download.file('http://manage.hdx.rwlabs.org/hdx/api/exporter/indicator/csv/CH070/source/emdat/fromYear/1950/toYear/2014/language/en/CH070_Baseline.csv', destfile = 'data/source/CH070_Baseline.csv', method = 'curl')

# RW002
download.file('http://manage.hdx.rwlabs.org/hdx/api/exporter/indicator/csv/RW002/source/RW/fromYear/1950/toYear/2014/language/en/RW002_RW.csv', destfile = 'data/source/RW002_RW.csv', method = 'curl')


## loading data into R ##
cred <- read.csv('data/source/CH070_Baseline.csv')
rw <- read.csv('data/source/RW002_RW.csv')

# arranging 
cred_molten <- melt(cred)
rw_molten <- melt(rw)
names(cred_molten) <- c('iso3', 'name', 'period', 'value')
names(rw_molten) <- c('iso3', 'name', 'period', 'value')
rw_molten$period <- sub("X", "", rw_molten$period)
cred_molten$period <- sub("X", "", cred_molten$period)

# adding source + creating single dataset
rw_molten$source <- 'ReliefWeb'
cred_molten$source <- 'CRED'
data <- rbind(rw_molten, cred_molten)

# writing CSV
write.csv(data, 'data/data.csv', row.names = F)