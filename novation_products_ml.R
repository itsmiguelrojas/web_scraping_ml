# Cargar librerías
library(kableExtra)
library(rvest)
library(tidyverse)

# Cargar página
ml_url <- read_html('https://electronica.mercadolibre.com.co/audio-equipos-dj-accesorios/novation_Desde_51')
tmp <- html_nodes(ml_url, 'li.ui-search-layout__item')

# Nombre del producto
product_name <- html_nodes(tmp, 'h2.ui-search-item__title')
product_name <- html_text(product_name)

# Precio
price <- html_nodes(tmp, '.ui-search-item__group .ui-search-price--size-medium .price-tag-fraction')
price <- html_text(price)
price <- as.numeric(gsub('\\.','',price))

# Imagen
image <- html_nodes(tmp, 'img')
image <- html_attr(image,'data-src')

# Link al producto
link <- html_nodes(tmp,'.ui-search-item__group.ui-search-item__group--title a')
link <- html_attr(link,'href')

# Crear dataframe
novation <- data.frame(
  product_name,
  price,
  image,
  link
)

# Crear tabla
novation %>%
  mutate(image = paste("<img width=\"100\" style=\"margin:0.5em\" src=\"",image,"\">",sep='')) %>%
  mutate(product_name = paste("<a target=\"_blank\" href=\"",link,"\">",product_name,"</a>",sep="")) %>%
  select(product_name,price,image) %>%
  kable(format = 'html', longtable = T, escape = F, align = 'c') %>%
  kable_material_dark(c('striped','hover'))