library(shiny)
library(galileantools)
ui <- fluidPage(
  titlePanel("Galilean demo"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("v", "Platform speed v", min = 0, max = 30, value = 15),
      sliderInput("ux", "u_x", min = -10, max = 30, value = 5),
      sliderInput("uy", "u_y", min = 0, max = 30, value = 12)
    ),
    mainPanel(
      plotOutput("trajx"),
      plotOutput("trajy")
    )
  )
)
server <- function(input, output){
  output$trajx <- renderPlot({
    dat <- simulate_projectile(u0 = c(input$ux, input$uy), v_platform = input$v,
                               t = seq(0,2.5,0.02), noise_sd = 0)
    plot(dat$t, dat$x, type = "l", main = "x(t)")
  })
  output$trajy <- renderPlot({
    dat <- simulate_projectile(u0 = c(input$ux, input$uy), v_platform = input$v,
                               t = seq(0,2.5,0.02), noise_sd = 0)
    plot(dat$t, dat$y, type = "l", main = "y(t)")
  })
}
shinyApp(ui, server)
