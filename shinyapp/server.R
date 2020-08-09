library(shiny)
library(tidyverse)
library(ggimage)

# data pre-processing
image_url <- "https://26955tnyu1c2aeak614rqou1-wpengine.netdna-ssl.com/wp-content/uploads/half-court.jpg"

coordinates <-
    tibble(
        spot = 1:7,
        name = c("1st", "2nd", "3rd", "4th", "5th", "6th", "7th"),
        x = c(5, 1.5, 8.5, 1.25, 5, 8.75, 9.5),
        y = c(6.5, 2, 2, 8, 9.5, 8, 9.5)
    )

sim_spot <- function(prob, time_betw){
    shots <- floor(60 / time_betw + 1)
    makes <- runif(shots) < prob
    max(ave(makes, cumsum(!makes), FUN = cumsum))
}

# server logic
server <- function(input, output) {

    getResults <- eventReactive(input$go, {
        tibble(
            spot = 1:7,
            prob = c(rep(input$p123, 3), rep(input$p4567, 4)),
            time_betw = c(rep(input$s123, 3), rep(input$s4567, 4))
        ) %>%
            mutate(score = map2_int(prob, time_betw, sim_spot))
    })

    output$mpgPlot <- renderPlot({
        results <- getResults()
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
    })

}
