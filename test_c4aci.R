# test_c4aci.R
## nick's test for fitting c4 aci curves

## load things
source("../fitAciC4/R/loadPackages.R") # required packages
source("AciC4_zinny.R")        # implements C4 model
# source("../fitAciC4/R/AciC4.R")        # implements C4 model
# source("../fitAciC4/R/functions.R")    # all fitting functions
source("functions_zinny.R")
source("../fitAciC4/R/fit_ains.R")     # fits following Ainsworth approach
#source("../fitAciC4/check_upper.R")     # fits following Ainsworth approach
source("check_upper_zinny.R")     # fits following Ainsworth approach

## load some data
test_data <- read_xlsx("../fitAciC4/Data/Vin_themeda_Aci_curves_aug22.xlsx")
test_data <- renameLi6800(test_data) # Set column headings
with(test_data, plot(Ci,Photo,col=as.factor(ID))) # Check dataset looks OK. Each curve is identified with individual ID
test_data <- subset(test_data) # Filter out incorrect points

test_data_list <- split(test_data,test_data$ID) # split dataset into individual curves
# function do_the_lot fits the curve, finds the Ci transition point,
# visualises the fit
# then fits the empirical benchmark (rectnagular hyperbola)
# to see how well it can fit in comparison
# apply function to first curve to test
test_data_results <- do_the_lot(test_data_list[[1]])
test_data_results <- do_the_lot(test_data_list[[2]])

## load data from zinny
zinny_data <- read.csv("data/acic4_zinny.csv")
zinny_data <- renameLi6800(zinny_data) # Set column headings
with(zinny_data, plot(Ci,Photo,col=as.factor(ID))) # Check dataset looks OK. Each curve is identified with individual ID
zinny_data <- subset(zinny_data, Ci > 0) # Filter out incorrect points
with(zinny_data, plot(Ci,Photo,col=as.factor(ID))) # Check dataset looks OK. Each curve is identified with individual ID

zinny_data_list <- split(zinny_data,zinny_data$ID) # split dataset into individual curves
# function do_the_lot fits the curve, finds the Ci transition point,
# visualises the fit
# then fits the empirical benchmark (rectnagular hyperbola)
# to see how well it can fit in comparison
# apply function to first curve to test
zinny_data_list[[4]]$Rd[1]
zinny_data_results4 <- do_the_lot(zinny_data_list[[4]])
zinny_data_list[[2]]$Rd[1]
zinny_data_results2 <- do_the_lot(zinny_data_list[[2]])
zinny_data_list[[3]]$Rd[1]
zinny_data_results3 <- do_the_lot(zinny_data_list[[3]])
zinny_data_list[[7]]$Rd[1]
zinny_data_results7 <- do_the_lot(zinny_data_list[[7]])
zinny_data_list[[8]]$Rd[1]
zinny_data_results8 <- do_the_lot(zinny_data_list[[8]])
zinny_data_list[[10]]$Rd[1]
zinny_data_results10 <- do_the_lot(zinny_data_list[[10]])
zinny_data_list[[25]]$Rd[1]
zinny_data_results25 <- do_the_lot(zinny_data_list[[25]])

zinny_data_results2 <- do_the_lot(zinny_data_list[[2]], RdRatio = 0.01)
zinny_data_results1 <- do_the_lot(zinny_data_list[[1]], Rd = 1)

## playing around with zinnys data
RdRatio=0.01
data = zinny_data_list[[2]]
pars <- fitAciC4trans(data,RdRatio)
upper <- check_upper(data,pars,RdRatio)
if (!is.null(upper)) {
  upper$ci_trans <- citrans(data,upper)
  visfit(data,upper)
}


