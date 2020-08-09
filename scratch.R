library(tidyverse)
library(ggimage)

results <-
    tibble(
        spot = 1:7,
        score = c(1, 4, 9, 5, 3, 1, 4)
    )

image_url <- "https://26955tnyu1c2aeak614rqou1-wpengine.netdna-ssl.com/wp-content/uploads/half-court.jpg"

coordinates <-
    tibble(
        spot = 1:7,
        name = c("1st", "2nd", "3rd", "4th", "5th", "6th", "7th"),
        x = c(5, 1.5, 8.5, 1.25, 5, 8.75, 9.5),
        y = c(6.5, 2, 2, 8, 9.5, 8, 9.5)
    )

p <-
    results %>%
    left_join(coordinates, by = "spot") %>%
    mutate(label = paste0(name, ": ", score)) %>%
    ggplot(aes(x, y)) +
    geom_text(aes(label = label), size = 6) +
    theme_void() +
    xlim(0, 10) +
    ylim(0, 10) +
    annotate("text", label = paste0("TOTAL: ", sum(results$score)), x = 1, y = 9.5, size = 7)

ggbackground(p, image_url)

sim_spot <- function(prob, time_betw){
    shots <- floor(60 / time_betw + 1)
    makes <- runif(shots) < prob
    max(ave(makes, cumsum(!makes), FUN = cumsum))
}
