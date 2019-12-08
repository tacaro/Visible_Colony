library(tidyverse)

# Function Definitions
col_volumer <- function(a,b,c) {
  # Volume of a half-ellipsoid of axes a,b, and c
  vol = (4/3)*pi*a*b*c
  vol = vol/2
  return(vol)
}

cell_volumer_rod <- function(a,b,c) {
  vol = a*b*c
  return(vol)
}

cell_volumer_cocci <- function(r) {
  vol = (4/3)*pi*(r^3)
  return(vol)
}

# Define parameters of colony needed to be visible:
xax <-  1000 # x axis, y axis, z axis, in µm
yax <-  1000
zax <-  (1/6)*1000

colony_vol = col_volumer(xax, yax, zax) # generate the volume of a half-ellipsoid, circular base, 1/6th as high as wide

colony_data <- read_csv(file.path('bac_data.csv'))
colony_data <- colony_data %>%
  # Calculate cell volumes
  mutate(cell_volume = case_when(shape == 'cocci' ~ cell_volumer_cocci(mjr_axis/2),
                                 shape == 'rod' ~ cell_volumer_rod(mjr_axis, mnr_axis, mnr_axis))) %>%
  # Calculate number of cells required for given volume
  mutate(num_cells_reqd = colony_vol/cell_volume) %>%
  
  # Calculate number of divisions required to reach visible colony
  mutate(divis_reqd = log2(num_cells_reqd)) %>%
  
  # Calculate hours required to reach that many divisions
  mutate(time_reqd_hr = divis_reqd*gen_time_hr)

ggplot(data = colony_data) +
  geom_point(mapping = aes(x = gen_time_hr, y = time_reqd_hr, color = shape, shape = source)) +
  scale_x_log10() +
  scale_y_log10() +
  ggtitle('Incubation time required to observe \n 1mm colony') +
  xlab('Cell Generation Time (hr)') +
  ylab('Required Incubation Time (hr)') +
  theme_bw() +
  scale_color_manual(values=c( "#E69F00", "#56B4E9"))
ggsave('inc_time.png', width = 4, height = 4)

                                 


