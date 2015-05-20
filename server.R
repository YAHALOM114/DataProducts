#setwd("F:/Data Science Specialization/9 Developing Data Products/Project")
d<-read.csv("BGdata.csv")
d1<- d[,-c(2,4:6)]#removing: Calories Prot Fat Fiber
library(caret)
set.seed(1111)
Model1<- train(BGL~., data=d1, method="glm")
b_fix<- summary(Model1)$coefficients[1,1]
b_ins<- summary(Model1)$coefficients[2,1]
b_carb<- summary(Model1)$coefficients[3,1]
CARB <- c(11:150)
I70<- (70-b_fix-b_carb*CARB)/b_ins
I80<- (80-b_fix-b_carb*CARB)/b_ins
I90<- (90-b_fix-b_carb*CARB)/b_ins
I100<- (100-b_fix-b_carb*CARB)/b_ins
I110<- (110-b_fix-b_carb*CARB)/b_ins
shinyServer(
      function(input, output) {
            output$DBGL <- renderPlot({
                  plot(CARB, I70, xlim=c(0,180), ylim=c(-5,75),type= "l", col=2, main="Blood Glucose Level (BGL)", xlab="Carbohydrates [gr]", ylab="Insulin [units]")
                  lines(CARB, I80, col=3)
                  lines(CARB, I90, col=4)
                  lines(CARB, I100, col=5)
                  lines(CARB, I110, col=6)
                  text(c(rep(173,5)),c(seq(70,30,-10),75),labels=c((7:11)*10, "BGL [mg/dl]"), col=c(2:6,1))
                  
                  carb <- input$carb
                  bgl<- input$bgl
                  if (!(carb==10 & bgl==70)){
                  ins <- (bgl-b_fix-b_carb*carb)/b_ins
                  points(carb,ins,pch="+")
                  lines(c(carb, carb), c(0, ins),col="black",lwd=1, lty=3)
                  text(carb-3, -3, paste("CARB=",carb))
                  
                  lines(c(0, carb), c(ins, ins),col="black",lwd=1, lty=3)
                  
                  par(cex=2)
                  text(70, 70, paste("Reqired Isulin =", round(ins, 0),("Units")),font=4, col=2)} 
            }) 
      }
)
