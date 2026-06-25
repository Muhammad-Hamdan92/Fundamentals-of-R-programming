# ===================================================================
#  R Basics: Conditions, Loops and Functions
#  Author  : Muhammad Hamdan
#  Purpose : A reproducible reference script covering core R
#            concepts — ideal for beginners and quick revision.
# ===================================================================

#---------------Control Structures in R programming------------------

# There are following Control Structures, study in R programming 
#(1) Conditions
#(2) Loops
#(3) Functions

#-----------------------(1) Conditions------------------------------
#IF Condition
#If else Condition
#Else If Condition

#--if condition--
x = 6
if (x > 7){
  print("above")  ## if the condition is true than print "above" otherwise nothing will be printed
}

#--if else condition--
sex <- "Male"
age <- 22
if (sex == "Male" && age <= 18){
  print("adult")
  }else{
    print("teenager")

}
#--Else if condition--
age <- 10
if(age == 23){
  print("adult")
}else if (age < 20){
  print("teenager")
}else if(age < 10){
  print("child")
}else {
  "newly born baby"
}
# nested condition
sex <- "male"
age <- 8
pclass <- 3

if (sex == "female") {
  
  if (pclass == 1) {
    print("Very high survival chance")
  } else {
    print("Moderate survival chance")
  }
  
} else {
  
  if (age < 10) {
    print("Young boy — higher chance of rescue")
  } else {
    print("Adult male — lower survival chance")
  }
  
}
# with logical loop
passengers <- data.frame(
  name     = c("Sara", "Bilal", "Hassan"),
  sex      = c("female", "male", "male"),
  pclass   = c(3, 2, 1),
  survived = c(0, 1, 0)
)

for (i in 1:nrow(passengers)) {
  
  name <- passengers$name[i]
  sex  <- passengers$sex[i]
  surv <- passengers$survived[i]
  
  if (sex == "female") {
    if (surv == 1) {
      cat(name, " Female survivor\n")   ###For cleaner output, add "\n" (newline):
    } else {
      cat(name, "Female, did not survive\n")  #cat() means concatenate and print
    }
  } else {
    cat(name, " Male, passenger\n")
  }
}

#=======real case study by using titanic data=======
data("Titanic"); class(Titanic)
df_titanic <- as.data.frame(Titanic) #covert the table into data frame
View(df_titanic)

attributes(df_titanic)

df_titanic$risk_group <- ifelse(
  df_titanic$Class == "1st", 
  "Low Risk", 
  "Higher Risk"
)

df_titanic$class<- ifelse(
 df_titanic$Sex == "Female" & df_titanic$Age == "Child",
  "class_1— Woman & Child",
  ifelse(
    df_titanic$Sex == "Female",
    "class_2 — Woman",
    ifelse(
      df_titanic$Age == "Child",
      "class_3 — Child",
      "class_4 — Adult Male"
    )
  )
)

table(df_titanic$class)


#(2)-------------Loops-------------
# first loop is [For loop]  ###A for loop repeats a syntax/code for each elemet in a pattern.
for (i in 1:9) {
  print(i)
  }


