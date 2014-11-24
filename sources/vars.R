selectInput(
  inputId = 'variables',
  label = 'Choose Variable',
  choices = c(
    'Air temperature, min' = 'AirTC_Max',   #col 26
    'Air temperature, mean' = 'AirTC_Avg',  #col 25
    'Air temperature, max' = 'AirTC_Min',   #col 27
    'PAR, mean' = 'PAR_Den_Avg',            #col 28
    'PAR, total' = 'PAR_Tot_Tot',           #col 29
    'Wind speed, min' = 'WS_ms_Min',        #col 20
    'Wind speed, mean' = 'WS_ms_Avg',       #col 17
    'Wind speed, max' = 'WS_ms_Max',        #col 18
    'Wind direction D1' = 'WindDir_D1_WVT', #col 23
    'Wind direction SD1' = 'WindDir_SD1_WVT', #col 24
    'Precipitation' = 'Rain_mm_Tot',        #col 16
    'Soil temperature, min' = 'T_1_Avg',    #col 5
    'Soil temperature, mean' = 'T_2_Avg',   #col 8
    'Soil temperature, max' = 'T_3_Avg',    #col 11
    'Soil volumetric water content, min' = 'VWC_1_Avg',   #col 3
    'Soil volumetric water content, mean' = 'VWC_2_Avg',  #col 6
    'Soil volumentric water content, max' = 'VWC_3_Avg',  #col 9
    'Soil electrical conductivity, min' = 'EC_1_Avg',     #col 4
    'Soil electrical conductivity, mean' = 'EC_2_Avg',    #col 7
    'Soil electrical conductivity, max' = 'EC_3_Avg',     #col 10
    'Leaf wetness dry landcover, mean' = 'LWMDry_Tot',    #col 13
    'Leaf wetness mesic landcover, mean' = 'LWMCon_Tot',  #col 14
    'Leaf wetness wet landcover, mean' = 'LWMWet_Tot'     #col 15
  ),
  selected = c('AirTC_Min','AirTC_Avg','AirTC_Max'),
  multiple = TRUE,
  selectize = TRUE
)