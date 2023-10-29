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

high_level <- result %>%
  filter(Membership == "gold" | Membership == "diamond") 

high_level %>%
  summarise(
    平均花費 = mean(Spend),
    平均年齡 = mean(Age)
    )

high_level %>%
  select(Gender) %>%
  table()

high_level %>%
  select(Region) %>%
  table()

high_level %>%
  select(Item) %>%
  table()

normal_level <- result %>%
  filter(!(Membership == "gold" | Membership == "diamond"))


normal_level %>%
  summarise(
    平均花費 = mean(Spend),
    平均年齡 = mean(Age)
  )

normal_level %>%
  select(Gender) %>%
  table()

normal_level %>%
  select(Region) %>%
  table()

normal_level %>%
  select(Item) %>%
  table()

male_result <- result %>%
  filter(Gender == "male")

male_result %>%
  summarise(
    平均花費 = mean(Spend),
    平均年齡 = mean(Age)
  )

male_result %>%
  select(Region) %>%
  table()

draw_data <- male_result %>%
  group_by(Item) %>%
  summarise(
    Total = sum(Spend)
  )

ggplot(draw_data, aes(x = Item, y = Total)) +
  geom_bar(stat = "identity") +
  labs(x = "Items", y = "Spend Total") +
  theme_classic()
