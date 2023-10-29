library(tidyverse)

product_list <- read.csv("product_list.csv")
product_list <- product_list %>%
  separate(Item, into=c("Product", "Item"), sep = "_", convert = TRUE)

client_list <- read.csv("client_list.csv")
salesdata <- read.csv("salesdata.csv")

client_list <- client_list %>% select(!(X))
salesdata <- salesdata %>% select(!(X))

result <- salesdata %>%
  left_join(client_list, by = "Client") %>%
  left_join(product_list, by = "Product")

result <- result %>%
  mutate(Spend = UnitPrice * Quantity)
