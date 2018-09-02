freduse MDUR
rename MDUR mdur 
tsmktim time, start(1976m1) 
tsset time 
tsline mdur 
graph rename mdur 
ac mdur 
regress mdur L1.mdur if time >= tm(1977m1), r //restricts number observations 
estimates store ar1 
regress mdur L(1/2).mdur if time >= tm(1977m1), r  //restricts number of observations 
estimates store ar2 
regress mdur L(1/3).mdur if time >= tm(1977m1), r //restricts number of observations
estimates store ar3
regress mdur l(1/4).mdur if time >= tm(1977m1), r //restricts number of observations 
estimates store ar4 
regress mdur l(1/5).mdur if time >= tm(1977m1), r 
estimates store ar5
regress mdur L(1/6).mdur if time >= tm(1977m1), r 
estimates store ar6 
regress mdur L(1/7).mdur if time >= tm(1977m1), r 
estimates store ar7 
regress mdur L(1/8).mdur if time >= tm(1977m1), r 
estimates store ar8 
regress mdur L(1/9).mdur if time >= tm(1977m1), r 
estimates store ar9 
regress mdur L(1/10).mdur if time >= tm(1977m1), r 
estimates store ar10 
regress mdur L(1/11).mdur if time >= tm(1977m1), r 
estimates store ar11 
regress mdur L(1/12).mdur if time >= tm(1977m1), r 
estimates store ar12 
estimates stats ar1 ar2 ar3 ar4 ar5 ar6 ar7 ar8 ar9 ar10 ar11 ar12 //model choice AIC and BIC -- chooses ar8
testparm L(1/8).mdur
testparm L(2/8).mdur
testparm L(3/8).mdur
testparm L(4/8).mdur 
testparm L(5/8).mdur
testparm L(6/8).mdur
testparm L(7/8).mdur // looks like this lag could be dropped (could reject at 5 or 10 percent level) use ar8 model 
regress mdur L(1/8).mdur, r //fix this /// should be ar(8)?
estimates store model1 
tsappend, add(6) 
forecast create ar1
forecast estimates model1 
forecast solve, simulate(errors, statistic(stddev, prefix(sd_)) reps(1000))
list time f_mdur sd_mdur if time>=tm(2017m3) 
gen pff = f_mdur if time >= tm(2017m3) 
gen pffL = pff - (1.282*sd_mdur) // 80%
gen pffU = pff + (1.282*sd_mdur) // 80%
tsline mdur pff pffL pffU if time>=tm(2010m1), lpattern(solid solid shortdash shortdash) 
graph rename forecast1 
gen pffL2 = pff - (0.675*sd_mdur) //50%
gen pffU2 = pff + (0.675*sd_mdur) //50%
tsline mdur pff pffL2 pffU2 if time >= tm(2010m1), lpattern(solid solid shortdash shortdash) 
graph rename forecast2 
list time pff pffL pffU pffL2 pffU2 if time >= tm(2017m3) 


//test ar(6) and ar(8) models 



