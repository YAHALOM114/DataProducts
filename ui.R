#shinyUI(pageWithSidebar(
shinyUI(fluidPage(
      headerPanel("How Much Insulin to Inject?"),
      sidebarPanel(
            sliderInput('carb', "Carbohydrates Eaten?", value = 10, min = 10, max = 150, step = 1,),
            sliderInput('bgl', "Desired BGL?", value = 70, min = 70, max = 120, step = 1,),
            br(),
            a("Documentation:"),p(("This is a simple Insulin calculator. Just follow the steps described under"), strong("Usage"), ("on the right side."), p("For further questions, contact"), a("yahalom114@gmail.com"))
      ),
      mainPanel(h3("Purpose"),
                ("This calculator assists diabetic person to figure out the amount of"),
                   strong("Insulin Units"), ("to inject."),
                h3("Usage"),
                  ("1. Use the upper slider to define the total amount of"), strong("carbohydrates"), ("(in grams), you ate during the last 24 hours."),br(),
                  ("2. Use the lower slider to define the required (your goal)"), strong("Blood Glucose Level (BGL)"), ("for the next morning."), br(),
                  ("3. Read the required (top of chart,red fonts) amount of"), strong("Insulin Units"), ("to achieve your goal"),
            plotOutput("DBGL"),
            h2("Warning",style = "color:blue"),
            ("This calculator is an academic exercise and is based on a specific persons' database"), br(), strong("DO NOT USE THIS CALCULATOR FOR REAL LIFE DECISIONS!!!",style = "color:blue")
            )
            ))