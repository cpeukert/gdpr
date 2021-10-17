*******************************
**** Peukert/Bechtold/Batikas/Kretschmer
**** Regulatory Spillovers and Data Governance: Evidence from the GDPR
**** Replication Package for Marketing Science. STATA 16.1/SE
*******************************

cd "/Users/cpeuke/Dropbox/Projekte/GDPR/replication package/data/"
global texpath "/Users/cpeuke/Dropbox/Projekte/GDPR/replication package/output/"

use  "gdpr_website.dta",clear

*******************************
**** Figure 2 
*******************************

use  "gdpr_website.dta",clear

	keep if exclude==0
	collapse (mean) log_requests3, by(date square)

	twoway ///
	(connected log_requests3 date if square==1, ytitle("") lcolor(black) mcolor(black) lpattern(solid)) ///
	, ylabel(, grid) xlabel(#6,grid) ///
	xline(21329, lcolor(black) lpattern(dash)) name(requests3_square1,replace) xtitle("")  scheme(s1color) ///
	legend(off) 
	graph export "$texpath/figures/figure2_1.pdf", replace

	twoway ///
	(connected log_requests3 date if square==2, ytitle("") lcolor(black) mcolor(black) lpattern(solid)) ///
	, ylabel(, grid) xlabel(#6,grid) ///
	xline(21329, lcolor(black) lpattern(dash)) name(requests3_square2,replace) xtitle("")  scheme(s1color) ///
	legend(off)
	graph export "$texpath/figures/figure2_2.pdf", replace

	twoway ///
	(connected log_requests3 date if square==3, ytitle("") lcolor(black) mcolor(black) lpattern(solid)) ///
	, ylabel(, grid) xlabel(#6,grid) ///
	xline(21329, lcolor(black) lpattern(dash)) name(requests3_square3,replace) xtitle("")  scheme(s1color) ///
	legend(off)
	graph export "$texpath/figures/figure2_3.pdf", replace	
	
	
	twoway ///
	(connected log_requests3 date if square==4, ytitle("")  lcolor(black) mcolor(black) lpattern(solid)) ///
	, ylabel(, grid) xlabel(#6,grid) ///
	xline(21329, lcolor(black) lpattern(dash)) name(requests3_square4,replace) xtitle("")  scheme(s1color) ///
	legend(off)
	graph export "$texpath/figures/figure2_4.pdf", replace



*******************************
**** Table 4
*******************************

use  "gdpr_website.dta",clear

	qui: eststo m1r: reghdfe log_requests3 c.trend#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) if eu_location==1 & exclude==0, absorb(h) vce(cluster h) nocons level(90)
	estadd ysumm

	qui: eststo m2r: reghdfe log_requests3 c.trend#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) if eu_location==0 & exclude==0, absorb(h) vce(cluster h) nocons  level(90)
	estadd ysumm

	qui: eststo m1c: reghdfe log_cookies3 c.trend#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) if eu_location==1 & exclude==0, absorb(h) vce(cluster h) nocons level(90)
	estadd ysumm

	qui: eststo m2c: reghdfe log_cookies3 c.trend#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) if eu_location==0 & exclude==0, absorb(h) vce(cluster h) nocons level(90)
	estadd ysumm

	esttab m1r m2r m1c m2c using "$texpath/tables/table4.tex",  ///
	nocons keep(c.after*) /// 
	mtitles("EU-Firm" "NonEU-Firm" "EU-Firm" "NonEU-Firm")  ///
	mgroups("Requests" "Cookies", pattern(1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
	b(%6.4f) se alignment(rrrrrr) compress replace label nonotes star(* 0.10 ** 0.05 *** 0.01) booktabs ///
	scalars("r2_a $\overline{R^2}$" "ymean Mean DV") nocons


*******************************
**** Figure 3
*******************************

use  "gdpr_website.dta",clear

	keep if exclude==0
	collapse (mean) log_cookies3, by(date square)

	twoway ///
	(connected log_cookies3 date if square==1,yaxis(1) ytitle("",axis(1)) lcolor(black) mcolor(black) lpattern(solid)) ///
	, ylabel(, grid) xlabel(#6,grid) ///
	xline(21329, lcolor(black) lpattern(dash)) name(cookies3_square1,replace) xtitle("")  scheme(s1color) ///
	legend(off)
	graph export "$texpath/figures/figure3_1.pdf", replace

	twoway ///
	(connected log_cookies3 date if square==2,yaxis(1) ytitle("",axis(1)) lcolor(black) mcolor(black) lpattern(solid)) ///
	, ylabel(, grid) xlabel(#6,grid) ///
	xline(21329, lcolor(black) lpattern(dash)) name(cookies3_square2,replace) xtitle("")  scheme(s1color) ///
	legend(off)
	graph export "$texpath/figures/figure3_2.pdf", replace

	twoway ///
	(connected log_cookies3 date if square==3,yaxis(1) ytitle("",axis(1)) lcolor(black) mcolor(black) lpattern(solid)) ///
	, ylabel(, grid) xlabel(#6,grid) ///
	xline(21329, lcolor(black) lpattern(dash)) name(cookies3_square3,replace) xtitle("")  scheme(s1color) ///
	legend(off)
	graph export "$texpath/figures/figure3_3.pdf", replace	
	
	
	twoway ///
	(connected log_cookies3 date if square==4,yaxis(1) ytitle("",axis(1)) lcolor(black) mcolor(black) lpattern(solid)) ///
	, ylabel(, grid) xlabel(#6,grid) ///
	xline(21329, lcolor(black) lpattern(dash)) name(cookies3_square4,replace) xtitle("")  scheme(s1color) ///
	legend(off)
	graph export "$texpath/figures/figure3_4.pdf", replace	
		
	


*******************************
**** Figure 4
*******************************

use  "gdpr_website.dta",clear

	keep if exclude==0
	collapse (mean) irequests3_fb log_requests3_nonfb, by(date square)

	twoway ///
	(connected irequests3_fb date if square==1, yaxis(1) ytitle("EU-EU",axis(1)) lcolor(black) mcolor(black) lpattern(dash) msymbol(X)) ///
	(connected log_requests3_nonfb date if square==1, yaxis(2) ytitle("EU-EU",axis(2)) lcolor(black) mcolor(black) lpattern(solid)) ///
	, ylabel(, grid) xlabel(#6,grid) ///
	xline(21260 21329, lcolor(black) lpattern(dash)) name(irequests3_fb_square1,replace) xtitle("")  scheme(s1color) ///
	legend(off)
	graph export "$texpath/figures/figure4_1.pdf", replace

	twoway ///
	(connected irequests3_fb date if square==2, yaxis(1) ytitle("EU-EU",axis(1)) color(black) mcolor(black) lpattern(dash) msymbol(X)) ///
	(connected log_requests3_nonfb date if square==2, yaxis(2) ytitle("EU-EU",axis(2)) lcolor(black) mcolor(black) lpattern(solid)) ///
	, ylabel(, grid) xlabel(#6,grid) ///
	xline(21260 21329, lcolor(black) lpattern(dash)) name(irequests3_fb_square2,replace) xtitle("")  scheme(s1color) ///
	legend(off)
	graph export "$texpath/figures/figure4_2.pdf", replace

	twoway ///
	(connected irequests3_fb date if square==3, yaxis(1) ytitle("EU-EU",axis(1)) color(black) mcolor(black) lpattern(dash) msymbol(X)) ///
	(connected log_requests3_nonfb date if square==3, yaxis(2) ytitle("EU-EU",axis(2)) lcolor(black) mcolor(black) lpattern(solid)) ///
	, ylabel(, grid) xlabel(#6,grid) ///
	xline(21260 21329, lcolor(black) lpattern(dash)) name(irequests3_fb_square3,replace) xtitle("")  scheme(s1color) ///
	legend(off)
	graph export "$texpath/figures/figure4_3.pdf", replace	
	
	
	twoway ///
	(connected irequests3_fb date if square==4, yaxis(1) ytitle("EU-EU",axis(1)) color(black) mcolor(black) lpattern(dash) msymbol(X)) ///
	(connected log_requests3_nonfb date if square==4, yaxis(2) ytitle("EU-EU",axis(2)) lcolor(black) mcolor(black) lpattern(solid)) ///
	, ylabel(, grid) xlabel(#6,grid) ///
	xline(21260 21329, lcolor(black) lpattern(dash)) name(irequests3_fb_square4,replace) xtitle("")  scheme(s1color) ///
	legend(off)
	graph export "$texpath/figures/figure4_4.pdf", replace	


*******************************
**** Table 5
*******************************

use  "gdpr_website.dta",clear

	eststo m1r: reghdfe log_requests3 c.trend#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience)#c.top if eu_location==1 & exclude==0, absorb(h) vce(cluster h) nocons
	estadd ysumm

	eststo m2r: reghdfe log_requests3 c.trend#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience)#c.top if eu_location==0 & exclude==0, absorb(h) vce(cluster h) nocons
	estadd ysumm

	eststo m1c: reghdfe log_cookies3 c.trend#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience)#c.top if eu_location==1 & exclude==0, absorb(h) vce(cluster h) nocons
	estadd ysumm

	eststo m2c: reghdfe log_cookies3 c.trend#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience)#c.top if eu_location==0 & exclude==0, absorb(h) vce(cluster h) nocons
	estadd ysumm

	esttab m1r m2r m1c m2c using "$texpath/tables/table5.tex",  ///
	nocons keep(c.after*) /// 
	mtitles("EU-Firm" "NonEU-Firm" "EU-Firm" "NonEU-Firm")  ///
	mgroups("Requests" "Cookies", pattern(1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
	b(%6.4f) se alignment(rrrrrr) compress replace label nonotes star(* 0.10 ** 0.05 *** 0.01) booktabs ///
	scalars("r2_a $\overline{R^2}$" "ymean Mean DV") nocons
	
	
*******************************
**** Table 6
*******************************

use "gdpr_vendors.dta",clear

	keep if exclude==0
	merge m:1 tracker using "policies_before.dta"
	drop if _merge==2
	gen m=_merge==3
	bys tracker_firm: egen temp=max(m)
	keep if temp==1
	collapse (max) col* use* shr* retention (sum) websites websites_cookie (mean) totalwebsites, by(tracker_firm date)
	gen ms_websites_firm=(websites/totalwebsites)*100
	gen ms_websites_cookie_firm=(websites_cookie/totalwebsites)*100
	
	gen after=date>=td(25may2018)
	su date
	gen trend=(date-`r(min)'+1)/100
	egen tf=group(tracker_firm)
	
	gen log_websites=log(1+websites)
	gen log_websites_cookie=log(1+websites_cookie)
	
	gen pers=.
	gen col_personal=col_pii==1 //| col_sensitive==1
	gen shr_personal=shr_pii==1 //| shr_sensitive==1
	
	label variable after "Post"
	label variable trend "Trend"
	label variable col_pers "Collect Personal"
	label variable shr_pers "Share Personal"

	eststo m1: areg log_websites c.trend##c.col_personal c.after c.after#c.col_personal,absorb(tf) vce(cluster tf)
	estadd ysumm
	
	eststo m2: areg log_websites c.trend##c.col_personal c.after c.after#c.col_personal c.trend##c.shr_personal c.after#c.shr_personal,absorb(tf) vce(cluster tf)
	estadd ysumm
	
	eststo m3: areg log_websites (c.trend##c.col_personal c.after c.after#c.col_personal)##c.shr_personal,absorb(tf) vce(cluster tf)
	estadd ysumm
	
	
	esttab m1 m2 m3 using "$texpath/tables/table6.tex",  ///
	keep(after c.after#* ) /// 
	nomtitles ///
	b(%8.6f) se alignment(rrrrrr) compress replace label nonotes star(* 0.10 ** 0.05 *** 0.01) booktabs ///
	scalars("r2_a $\overline{R^2}$" "ymean Mean DV") nocons	


*******************************
**** Table 7
*******************************	
	
use "gdpr_vendors.dta",clear	
	
	preserve
		collapse (sum) ms_websites_firm=ms_websites  , by(tracker_firm date) fast
		gen ms_websites_firm2=ms_websites_firm^2
		
		collapse (sum) hhi=ms_websites_firm2, by(date) fast
		
		gen after=date>=td(25may2018)
		su date
		gen trend=(date-`r(min)'+1)/100
		su date if after==1
		gen trend_after=(date-`r(min)'+1)/100


		eststo m_requests: reg hhi trend after c.trend_after#c.after, robust
		su hhi if after==0,meanonly
		estadd scalar ymean_before=`r(mean)'	
	restore
	
	preserve
		drop if tracker_firm=="google"
		collapse (sum) ms_websites_firm=ms_websites  , by(tracker_firm date) fast
		gen ms_websites_firm2=ms_websites_firm^2

		
		collapse (sum) hhi=ms_websites_firm2, by(date) fast
		
		gen after=date>=td(25may2018)
		su date
		gen trend=(date-`r(min)'+1)/100
		su date if after==1
		gen trend_after=(date-`r(min)'+1)/100


		eststo m_requests_g: reg hhi trend after c.trend_after#c.after, robust
		su hhi if after==0,meanonly
		estadd scalar ymean_before=`r(mean)'				
		
	restore
		

	esttab m_requests m_requests_g using "$texpath/tables/table7.tex",  ///
	nocons keep(after) /// 
	mtitles("HHI All" "HHI w/o Google")  ///
	b(%10.3f) se alignment(rrrrrr) compress replace label nonotes star(* 0.10 ** 0.05 *** 0.01) booktabs ///
		scalars("ymean_before Pre-GDPR Mean") nocons		
	
	
*******************************
**** Figure 5
*******************************		
	
use "gdpr_vendors.dta",clear		

	bys tracker_firm date: keep if _n==1
	gen after=date>=td(25may2018)	

	bys tracker_firm after: egen avg_ms=mean(ms_websites_firm)
	bys tracker_firm after: keep if _n==1
	bys tracker_firm: gen dms=avg_ms-avg_ms[_n-1]
			
	keep if after==1
	gen minus=dms<0
	gen absd=abs(dms)
	drop if dms==.

	egen rank_plus=rank(absd) if minus==0
	egen rank_minus=rank(absd) if minus==1
	su rank_plus
	replace rank_plus=`r(max)'-rank_plus+1
	su rank_minus
	replace rank_minus=`r(max)'-rank_minus+1

	keep tracker_firm rank_plus rank_minus 

	merge 1:m tracker_firm using "gdpr_vendors.dta"
	keep date tracker_firm ms_websites_firm rank_plus rank_minus 

	bys tracker_firm date: keep if _n==1
	gen byte basedate = 1 if date == td(15may2018) 
	bysort tracker_firm  (basedate) : gen ms_firm_change = (ms_websites_firm - ms_websites_firm[1])
	sort tracker_firm date

	twoway (connected ms_firm_change date if rank_plus==1)  (connected ms_firm_change date if rank_plus==2) (connected ms_firm_change date if rank_plus==3)  (connected ms_firm_change date if rank_plus==4)  (connected ms_firm_change date if rank_plus==5)  , scheme(s1mono)  ytitle("Percentage point increase in market share") yline(0) xtitle("") xline(`=td(25may2018)', lpattern(dash)) legend(label(1 "Google") label(2 "digicert_trust_seal") label(3 "consensu.org") label(4 "Cloudflare") label(5 "Bing_ads"))  
	graph export "$texpath/figures/figure5_1.pdf", replace	

	twoway (connected ms_firm_change date if rank_minus==1)  (connected ms_firm_change date if rank_minus==2) (connected ms_firm_change date if rank_minus==3)  (connected ms_firm_change date if rank_minus==4)  (connected ms_firm_change date if rank_minus==5)  , scheme(s1mono)  ytitle("Percentage point increase in market share") yline(0) xtitle("") xline(`=td(25may2018)', lpattern(dash)) legend(label(1 "Adtech") label(2 "Liveramp") label(3 "symcb.com") label(4 "Brightroll") label(5 "Appnexus"))   

	graph export "$texpath/figures/figure5_2.pdf", replace	
	
	
*******************************
**** Table 8
*******************************

use "gdpr_vendors.dta",clear


	gen after=date>=td(25may2018)
	gen log_websites=log(1+tracker_firm_websites)
	gen google=tracker_firm=="google"
	gen nongoogle=1-google
	bys tracker_firm date: keep if _n==1	
	
	su date
	di `r(min)'
	gen trend=(date-`r(min)'+1)/100
	su date if after==1
	gen trend_after=(date-`r(min)'+1)/100
		
	egen tf=group(tracker_firm)
	
	label variable after "Post"
	label variable google "Google"
	label variable nongoogle "NonGoogle"


	global spec "c.trend c.trend_after#c.after c.after"

		
	eststo w_google: reghdfe log_websites (${spec})#c.google (${spec})#c.nongoogle,  absorb(tf) vce(cluster tf) nocons
		su log_websites if google==1 & after==0,meanonly
		estadd scalar ymean_google=`r(mean)'
		su log_websites if nongoogle==1 & after==0,meanonly
		estadd scalar ymean_nongoogle=`r(mean)'		
		
	eststo ms_google: reghdfe ms_websites_firm (${spec})#c.google (${spec})#c.nongoogle,  absorb(tf) vce(cluster tf) nocons
	estadd ysumm
		su ms_websites_firm if google==1 & after==0,meanonly
		estadd scalar ymean_google=`r(mean)'
		su ms_websites_firm if nongoogle==1 & after==0,meanonly
		estadd scalar ymean_nongoogle=`r(mean)'			
	
	esttab w_google ms_google using "$texpath/tables/table8.tex",  ///
	nocons keep(c.after*) ///
	mtitles("No. Websites" "Market Shares") ///
	b(%6.4f) se alignment(rrrrrr) compress replace label nonotes star(* 0.10 ** 0.05 *** 0.01) booktabs ///
		scalars("r2_a $\overline{R^2}$" "ymean_google Pre-GDPR Google" "ymean_nongoogle Pre-GDPR NonGoogle") nocons
		
*******************************
**** Table 9
*******************************

use "gdpr_vendors_cat.dta",clear
	
foreach i in 0 4 6 9 11  {	
		eststo gw`i': reghdfe log_websites c.google c.nongoogle c.trend#(c.google c.nongoogle) c.trend_after#c.after#(c.google c.nongoogle) c.after#(c.google c.nongoogle) if category_id==`i', absorb(tf) vce(cluster tf) nocons
		su log_websites if google==1 & after==0 & category_id==`i',meanonly
		estadd scalar ymean_google=`r(mean)'
		su log_websites if nongoogle==1 & after==0 & category_id==`i',meanonly
		estadd scalar ymean_nongoogle=`r(mean)'
	}

	esttab  gw0 gw4 gw6 gw9 gw11  using "$texpath/tables/table9.tex",  ///
	mtitles("Video" "Advertising" "Analytics" "CDN/API" "Other") ///
	keep(c.after#*) /// 
	b(%8.6g) se alignment(rrrrrr) compress replace label nonotes star(* 0.10 ** 0.05 *** 0.01) booktabs ///
	scalars("r2_a $\overline{R^2}$" "ymean_google Pre-GDPR Google" "ymean_nongoogle Pre-GDPR NonGoogle") nocons		

*******************************
**** Table 10
*******************************

use "gdpr_vendors_cat.dta",clear
	

	foreach i in 0 4 6 9 11  {		
		eststo gm`i': reghdfe ms_websites_firm c.google c.nongoogle c.trend#(c.google c.nongoogle) c.trend_after#c.after#(c.google c.nongoogle) c.after#(c.google c.nongoogle) if category_id==`i', absorb(tf) vce(cluster tf) nocons
		su ms_websites_firm if google==1 & after==0 & category_id==`i',meanonly
		estadd scalar ymean_google=`r(mean)'
		su ms_websites_firm if nongoogle==1 & after==0 & category_id==`i',meanonly
		estadd scalar ymean_nongoogle=`r(mean)'
	}

	esttab  gm0 gm4 gm6 gm9 gm11  using "$texpath/tables/table10.tex",  ///
	mtitles("Video" "Advertising" "Analytics" "CDN/API" "Other") ///
	keep(c.after#*) /// 
	b(%8.6g) se alignment(rrrrrr) compress replace label nonotes star(* 0.10 ** 0.05 *** 0.01) booktabs ///
	scalars("r2_a $\overline{R^2}$" "ymean_google Pre-GDPR Google" "ymean_nongoogle Pre-GDPR NonGoogle") nocons				

	

