ui <- pageWithSidebar(

    # App title ----
    headerPanel(
        "Seven Spots Simulator!"
    ),

    sidebarPanel(
        p("Fill in assumptions below."),
        numericInput("p123", "Probability at spots 1, 2, and 3", 0.4, min = 0, max = 1, step = 0.05),
        numericInput("s123", "Seconds between shots at spots 1, 2, and 3", 5, min = 1, max = 10, step = 0.5),
        numericInput("p4567", "Probability at spots 4, 5, 6, and 7", 0.3, min = 0, max = 1, step = 0.05),
        numericInput("s4567", "Seconds between shots at spots 4, 5, 6, and 7", 7, min = 1, max = 10, step = 0.5),
        actionButton("go", "CLICK HERE TO SIMULATE!!!"),
    ),

    # Main panel for displaying outputs ----
    mainPanel(
        plotOutput(outputId = "mpgPlot")
    )
)
