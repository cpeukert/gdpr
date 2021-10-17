*******************************
**** Peukert/Bechtold/Batikas/Kretschmer
**** Regulatory Spillovers and Data Governance: Evidence from the GDPR
**** Replication Package for Marketing Science. STATA 16.1/SE
*******************************

cd "/Users/cpeuke/Dropbox/Projekte/GDPR/replication package/data/"
global texpath "/Users/cpeuke/Dropbox/Projekte/GDPR/replication package/output/"

*******************************
**** Table A.1
*******************************

use  "gdpr_website.dta",clear

	eststo m1r: reghdfe logx_requests3 c.trend#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) if eu_location==1 & exclude==0, absorb(h) vce(cluster h) nocons level(90)
	estadd ysumm

	eststo m2r: reghdfe logx_requests3 c.trend#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) if eu_location==0 & exclude==0, absorb(h) vce(cluster h) nocons level(90)
	estadd ysumm

	eststo m1c: reghdfe logx_cookies3 c.trend#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) if eu_location==1 & exclude==0, absorb(h) vce(cluster h) nocons level(90)
	estadd ysumm

	eststo m2c: reghdfe logx_cookies3 c.trend#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) if eu_location==0 & exclude==0, absorb(h) vce(cluster h) nocons level(90)
	estadd ysumm

	esttab m1r m2r m1c m2c using "$texpath/tables/tableA1.tex",  ///
	nocons keep(c.after*) /// 
	mtitles("EU-Firm" "NonEU-Firm" "EU-Firm" "NonEU-Firm")  ///
	mgroups("Requests" "Cookies", pattern(1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
	b(%6.4f) se alignment(rrrrrr) compress replace label nonotes star(* 0.10 ** 0.05 *** 0.01) booktabs ///
	scalars("r2_a $\overline{R^2}$" "ymean Mean DV") nocons

*******************************
**** Table A.2
*******************************

use  "gdpr_website.dta",clear	
	
	eststo m1a: reghdfe log_requests3 c.trend#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) if exclude==0 & general==1 & eu_location==1, absorb(h) vce(cluster h)
	estadd ysumm

	eststo m1b: reghdfe log_requests3 c.trend#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) if exclude==0 & general==1 & eu_location==0, absorb(h) vce(cluster h)
	estadd ysumm


	eststo m2a: reghdfe log_requests3 c.trend#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) if exclude==0 & general==0 & eu_location==1, absorb(h) vce(cluster h)
	estadd ysumm

	eststo m2b: reghdfe log_requests3 c.trend#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) if exclude==0 & general==0 & eu_location==0, absorb(h) vce(cluster h)
	estadd ysumm

	eststo m3a: reghdfe log_requests3 c.trend#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) if exclude==0 & general==. & eu_location==1, absorb(h) vce(cluster h)
	estadd ysumm

	eststo m3b: reghdfe log_requests3 c.trend#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) if exclude==0 & general==. & eu_location==0, absorb(h) vce(cluster h)
	estadd ysumm

	esttab m1a m1b m2a m2b m3a m3b using "$texpath/tables/tableA2.tex",  ///
	nocons keep(c.after*) /// 
	mtitles("\shortstack[c]{EU-\\Firm}" "\shortstack[c]{nonEU-\\Firm}" "\shortstack[c]{EU-\\Firm}" "\shortstack[c]{nonEU-\\Firm}" "\shortstack[c]{EU-\\Firm}" "\shortstack[c]{nonEU-\\Firm}")  ///
	mgroups("General" "Specific" "Missing Category", pattern(1 0 1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
	b(%6.4f) se alignment(rrrrrr) compress replace label nonotes star(* 0.10 ** 0.05 *** 0.01) booktabs ///
	scalars("r2_a $\overline{R^2}$" "ymean Mean DV") nocons
	
*******************************
**** Table A.3
*******************************

use  "gdpr_website.dta",clear	

	eststo m1r: reghdfe log_requests3 c.trend#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) [pweight=oneoverrank] if eu_location==1 & exclude==0, absorb(h) vce(cluster h) nocons 
	estadd ysumm

	eststo m2r: reghdfe log_requests3 c.trend#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) [pweight=oneoverrank]  if eu_location==0 & exclude==0, absorb(h) vce(cluster h) nocons
	estadd ysumm


	eststo m1c: reghdfe log_cookies3 c.trend#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) [pweight=oneoverrank] if eu_location==1 & exclude==0, absorb(h) vce(cluster h) nocons
	estadd ysumm

	eststo m2c: reghdfe log_cookies3 c.trend#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) [pweight=oneoverrank] if eu_location==0 & exclude==0, absorb(h) vce(cluster h) nocons
	estadd ysumm


	esttab m1r m2r m1c m2c using "$texpath/tables/tableA3.tex",  ///
	nocons keep(c.after*) /// 
	mtitles("EU-Firm" "NonEU-Firm" "EU-Firm" "NonEU-Firm")  ///
	mgroups("Requests" "Cookies", pattern(1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
	b(%6.4f) se alignment(rrrrrr) compress replace label nonotes star(* 0.10 ** 0.05 *** 0.01) booktabs ///
	scalars("r2_a $\overline{R^2}$" "ymean Mean DV") nocons
	
*******************************
**** Table A.4
*******************************

use  "gdpr_website.dta",clear

	eststo m1: reghdfe log_requests3 c.trend#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) if eu_location==1, absorb(h) vce(cluster h) nocons
	estadd ysumm

	eststo m2: reghdfe log_requests3 c.trend#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) if eu_location==0, absorb(h) vce(cluster h) nocons
	estadd ysumm

	eststo m3: reghdfe log_cookies3 c.trend#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) if eu_location==1, absorb(h) vce(cluster h) nocons
	estadd ysumm

	eststo m4: reghdfe log_cookies3 c.trend#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) if eu_location==0, absorb(h) vce(cluster h) nocons
	estadd ysumm

	esttab m1 m2 m3 m4 using "$texpath/tables/tableA4.tex",  ///
	nocons keep(c.after*) /// 
	mtitles("EU-Firm" "NonEU-Firm" "EU-Firm" "NonEU-Firm")  ///
	mgroups("Requests" "Cookies", pattern(1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
	b(%6.4f) se alignment(rrrrrr) compress replace label nonotes star(* 0.10 ** 0.05 *** 0.01) booktabs ///
	scalars("r2_a $\overline{R^2}$" "ymean Mean DV") nocons
	
	
*******************************
**** Table A.5, A.6, A.7
*******************************

use "policies_panel.dta",clear
	gen col_personal=col_pii==1 | col_sensitive==1
	gen shr_personal=shr_pii==1 | shr_sensitive==1

	egen t=group(tracker)
	bys tracker: keep if _N==2
	
	gen re_disclosed=retention>0 & retention!=.
	
	
	bys tracker: egen sd=sd(col_undisclosed)
	gen col_always_disclosed=col_undisclosed==0 & sd==0
	drop sd
	bys tracker: egen sd=sd(shr_undisclosed)
	gen shr_always_disclosed=shr_undisclosed==0 & sd==0
	drop sd
	bys tracker: egen sd=sd(re_disclosed)
	gen re_always_disclosed=re_disclosed==1 & sd==0
	drop sd	
	
	sort tracker after
	bys tracker: gen temp=col_undisclosed[_n-1]-col_undisclosed==1
	bys tracker: egen col_after_disclosed=max(temp)
	drop temp
	bys tracker: gen temp=shr_undisclosed[_n-1]-shr_undisclosed==1
	bys tracker: egen shr_after_disclosed=max(temp)
	drop temp
	bys tracker: gen temp=re_disclosed[_n-1]-re_disclosed==-1
	bys tracker: egen re_after_disclosed=max(temp)
	drop temp	

	label variable after "Post"
	label variable col_personal "Collection"

	
	gen col_disclosed=1-col_undisclosed
	gen shr_disclosed=1-shr_undisclosed
	gen re_law=retention==1
	replace re_law=. if retention==.
	gen after_re_always_disclosed=after*c.re_after_disclosed
	
	label variable after_re_always_disclosed "Always disclosed"
	
	eststo col1: areg col_disclosed after,absorb(t) vce(cluster t)
	estadd ysumm
	eststo col2: areg col_personal after if col_always_disclosed==1,absorb(t) vce(cluster t)
	estadd ysumm
	eststo col3: areg col_personal after if col_after_disclosed==1,absorb(t) vce(cluster t)
	estadd ysumm

	eststo shr1: areg shr_disclosed after,absorb(t) vce(cluster t)
	estadd ysumm
	eststo shr2: areg shr_personal after if shr_always_disclosed==1,absorb(t) vce(cluster t)
	estadd ysumm
	eststo shr3: areg shr_personal c.after##c.col_personal if shr_always_disclosed==1,absorb(t) vce(cluster t)
	estadd ysumm
	eststo shr4: areg shr_personal after if shr_after_disclosed==1,absorb(t) vce(cluster t)
	estadd ysumm
	eststo shr5: areg shr_personal c.after##c.col_personal if shr_after_disclosed==1,absorb(t) vce(cluster t)
	estadd ysumm
	
	eststo re1: areg re_disclosed after,absorb(t) vce(cluster t)
	estadd ysumm
	eststo re2: areg re_law after after_re_always_disclosed,absorb(t) vce(cluster t)
	estadd ysumm
	eststo re3: areg retention_months after if re_always_disclosed==1,absorb(t) vce(cluster t)
	estadd ysumm	
	
	
	esttab col1 col2 col3 using "$texpath/tables/tableA5.tex",  ///
	mtitles ("Disclosure" "Always disclosed" "Disclosed after") ///
	mgroups("Any collection" "Collection of personal data", pattern(1 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
	keep(after) /// 
	b(%8.6f) se alignment(rrrrrr) compress replace label nonotes star(* 0.10 ** 0.05 *** 0.01) booktabs ///
	scalars("r2_a $\overline{R^2}$" "ymean Mean DV") nocons
	
	esttab shr1 shr2 shr3 shr4 shr5 using "$texpath/tables/tableA6.tex",  ///
	mtitles ("Disclosure" "Always disclosed" "Always disclosed" "Disclosed after"  "Disclosed after") ///
	mgroups("Any sharing" "Sharing of personal data", pattern(1 1 0 0 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
	b(%8.6f) se alignment(rrrrrr) compress replace label nonotes star(* 0.10 ** 0.05 *** 0.01) booktabs ///
	scalars("r2_a $\overline{R^2}$" "ymean Mean DV") nocons
	
	esttab re1 re2 re3 using "$texpath/tables/tableA7.tex",  ///
	mtitles("Any policy" "As required by law" "In Months") ///
	 mgroups("Disclosure of Data Retention"  "Data Retention" , pattern(1 0 1) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
	b(%8.6f) se alignment(rrrrrr) compress replace label nonotes star(* 0.10 ** 0.05 *** 0.01) booktabs ///
	scalars("r2_a $\overline{R^2}$" "ymean Mean DV") nocons		
	
*******************************
**** Table A.8
*******************************	

use  "gdpr_website.dta",clear

	eststo m1: reghdfe log_requests3 c.trend#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) if exclude==0 & multi_tld==1, absorb(h md) vce(cluster h)
	estadd ysumm
	eststo m2a: reghdfe log_requests3 c.trend#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) if exclude==0 & multi_tld==0 & eu_location==1, absorb(h) vce(cluster h)
	estadd ysumm
	eststo m2b: reghdfe log_requests3 c.trend#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) if exclude==0 & multi_tld==0 & eu_location==0, absorb(h) vce(cluster h)
	estadd ysumm
	eststo m3: reghdfe log_requests3 c.trend#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) if exclude==0, absorb(h md) vce(cluster h)
	estadd ysumm

	esttab m1 m2a m2b m3  using "$texpath/tables/tableA8.tex",  ///
	nocons keep(c.after*) /// 
	mtitles("Multi TLD" "EU-Firm" "NonEU-Firm" "All")  ///
	mgroups("" "One TLD" "", pattern(1 1 0 1) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
	b(%6.4f) se alignment(rrrrrr) compress replace label nonotes star(* 0.10 ** 0.05 *** 0.01) booktabs ///
	scalars("r2_a $\overline{R^2}$" "ymean Mean DV") nocons

*******************************
**** Table A.9
*******************************		
	
use  "gdpr_website.dta",clear

	eststo m1: reghdfe log_requests3 c.trend#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) if exclude==0 & intl_tld==1 & eu_location==1, absorb(h) vce(cluster h)
	estadd ysumm
	eststo m2: reghdfe log_requests3 c.trend#(c.eu_audience c.noneu_audience) c.trend_after#c.after#(c.eu_audience c.noneu_audience) c.after#(c.eu_audience c.noneu_audience) if exclude==0 & intl_tld==1 & eu_location==0, absorb(h) vce(cluster h)
	estadd ysumm

	esttab m1 m2 using "$texpath/tables/tableA9.tex",  ///
	nocons keep(c.after*) /// 
	mtitles("EU-Firm" "NonEU-Firm")  ///
	mgroups("Only Intl. TLDs" , pattern(1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
	b(%6.4f) se alignment(rrrrrr) compress replace label nonotes star(* 0.10 ** 0.05 *** 0.01) booktabs ///
	scalars("r2_a $\overline{R^2}$" "ymean Mean DV") nocons	
	
	
use "gdpr_website_wtm.dta",clear
	ren month m
	replace m=m+"-01"
	gen month=mofd(date(m,"YMD"))
	format month %tm

	gen eu=country=="eu"
	gen after=month>=tm(2018m6)
	su month
	gen trend=(month-`r(min)'+1)/100

	label variable trend "Trend"
	label variable after "Post"
	label variable eu "EU"

	gen log_thirdparty=log(1+thirdparty)

	egen s=group(site)

	bys site: gen n=_N
	keep if n==28 // make balanced panel as in main dataset of the paper

	eststo rm1: reghdfe log_thirdparty c.trend c.after if eu==1, absorb(s) vce(cluster s)
	estadd ysumm
	eststo rm10: reghdfe log_thirdparty  c.trend c.after if eu==0, absorb(s) vce(cluster s)
	estadd ysumm
	eststo m1: reghdfe log_thirdparty trend after eu c.trend#c.eu c.after#c.eu, absorb(s) vce(cluster s)
	estadd ysumm
	lincom after+c.after#c.eu

	esttab rm1 rm10 m1 using "$texpath/tables/tableA10.tex",  ///
	nocons keep(trend after c.trend#* c.after*) /// 
	mtitles("EU" "US" "EU+US")  ///
	b(%6.4f) se alignment(rrrrrr) compress replace label nonotes star(* 0.10 ** 0.05 *** 0.01) booktabs ///
	scalars("r2_a $\overline{R^2}$" "ymean Mean DV") nocons
	
	
*******************************
**** Table A.11
*******************************	

use "gdpr_vendors_cat_head.dta",clear	

	foreach i in 0 4 6 9 11  {	
		eststo gw`i': reghdfe log_websites c.google c.nongoogle c.trend#(c.google c.nongoogle) c.trend_after#c.after#(c.google c.nongoogle) c.after#(c.google c.nongoogle) if category_id==`i', absorb(tf) vce(cluster tf) nocons
		su log_websites if google==1 & after==0 & category_id==`i',meanonly
		estadd scalar ymean_google=`r(mean)'
		su log_websites if nongoogle==1 & after==0 & category_id==`i',meanonly
		estadd scalar ymean_nongoogle=`r(mean)'
	}

	esttab  gw0 gw4 gw6 gw9 gw11  using "$texpath/tables/tableA11.tex",  ///
	mtitles("Video" "Advertising" "Analytics" "CDN/API" "Other") ///
	keep(c.after#*) /// 
	b(%8.6g) se alignment(rrrrrr) compress replace label nonotes star(* 0.10 ** 0.05 *** 0.01) booktabs ///
	scalars("r2_a $\overline{R^2}$" "ymean_google Pre-GDPR Google" "ymean_nongoogle Pre-GDPR NonGoogle") nocons		
	
	
*******************************
**** Table A.12
*******************************	

use "gdpr_vendors_cat_head.dta",clear	


	foreach i in 0 4 6 9 11  {		
		eststo gm`i': reghdfe ms_websites_firm c.google c.nongoogle c.trend#(c.google c.nongoogle) c.trend_after#c.after#(c.google c.nongoogle) c.after#(c.google c.nongoogle) if category_id==`i', absorb(tracker_firm) vce(cluster tracker_firm) nocons
		su ms_websites_firm if google==1 & after==0 & category_id==`i',meanonly
		estadd scalar ymean_google=`r(mean)'
		su ms_websites_firm if nongoogle==1 & after==0 & category_id==`i',meanonly
		estadd scalar ymean_nongoogle=`r(mean)'
	}

	esttab  gm0 gm4 gm6 gm9 gm11  using "$texpath/tables/tableA12.tex",  ///
	mtitles("Video" "Advertising" "Analytics" "CDN/API" "Other") ///
	keep(c.after#*) /// 
	b(%8.6g) se alignment(rrrrrr) compress replace label nonotes star(* 0.10 ** 0.05 *** 0.01) booktabs ///
	scalars("r2_a $\overline{R^2}$" "ymean_google Pre-GDPR Google" "ymean_nongoogle Pre-GDPR NonGoogle") nocons				
	

*******************************
**** Figure A.1
*******************************

preserve

	clear
	set obs 4
	gen square=_n
	expand 3
	sort square
	bys square: gen firm=_n
	expand 5
	sort square firm
	bys square firm: gen audience=_n
	gen b=.
	gen cu=.
	gen cl=.
	save "specgraph.dta",replace
	
restore

use  "gdpr_website.dta",clear

forvalues firm=1(1)3 {

	forvalues audience=1(1)4 {

		reghdfe log_requests3 c.trend#(c.eu_a`audience' c.neu_a`audience') c.after#(c.eu_a`audience' c.neu_a`audience') if eu_l`firm'==1 & exclude==0, absorb(h) vce(cluster h) nocons
		local c_`audience'`firm'1=_b[c.after#c.eu_a`audience']
		local se_`audience'`firm'1=_se[c.after#c.eu_a`audience']
		local c_`audience'`firm'3=_b[c.after#c.neu_a`audience']
		local se_`audience'`firm'3=_se[c.after#c.neu_a`audience']
		reghdfe log_requests3 c.trend#(c.eu_a`audience' c.neu_a`audience') c.after#(c.eu_a`audience' c.neu_a`audience') if eu_l`firm'==0 & exclude==0, absorb(h) vce(cluster h) nocons
		local c_`audience'`firm'2=_b[c.after#c.eu_a`audience']
		local se_`audience'`firm'2=_se[c.after#c.eu_a`audience']
		local c_`audience'`firm'4=_b[c.after#c.neu_a`audience']
		local se_`audience'`firm'4=_se[c.after#c.neu_a`audience']
		
		preserve

			use "specgraph.dta",clear
			replace b=`c_`audience'`firm'1' if audience==`audience' & firm==`firm' & square==1
			replace cu=`c_`audience'`firm'1'+1.65*`se_`audience'`firm'1' if audience==`audience' & firm==`firm' & square==1
			replace cl=`c_`audience'`firm'1'-1.65*`se_`audience'`firm'1' if audience==`audience' & firm==`firm' & square==1
			replace b=`c_`audience'`firm'3' if audience==`audience' & firm==`firm' & square==3
			replace cu=`c_`audience'`firm'3'+1.65*`se_`audience'`firm'3' if audience==`audience' & firm==`firm' & square==3
			replace cl=`c_`audience'`firm'3'-1.65*`se_`audience'`firm'3' if audience==`audience' & firm==`firm' & square==3
			replace b=`c_`audience'`firm'2' if audience==`audience' & firm==`firm' & square==2
			replace cu=`c_`audience'`firm'2'+1.65*`se_`audience'`firm'2' if audience==`audience' & firm==`firm' & square==2
			replace cl=`c_`audience'`firm'2'-1.65*`se_`audience'`firm'2' if audience==`audience' & firm==`firm' & square==2
			replace b=`c_`audience'`firm'4' if audience==`audience' & firm==`firm' & square==4
			replace cu=`c_`audience'`firm'4'+1.65*`se_`audience'`firm'4' if audience==`audience' & firm==`firm' & square==4
			replace cl=`c_`audience'`firm'4'-1.65*`se_`audience'`firm'4' if audience==`audience' & firm==`firm' & square==4	
			save "specgraph.dta",replace	
			
		restore	
		
	}

}


preserve

	use "specgraph.dta",clear


	egen fa=group(firm audience)

	global square=1
	
	su cu if fa==1 & square==$square
	global cu=`r(mean)'
	su cl if fa==1 & square==$square
	global cl=`r(mean)'
	
	twoway ///
	(scatter b fa if square==$square & fa==1, mcolor(red) msymbol(D)) ///
	(rcap cu cl fa if square==$square & fa==1, lcolor(red)) ///	
	(rbar cu cl fa if square==$square & fa==1, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==2, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==3, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==4, barwidth(0.3) fcolor(black%10) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==6, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==7, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==8, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==9, barwidth(0.3) fcolor(black%10) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==11, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==12, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==13, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==14, barwidth(0.3) fcolor(black%10) lcolor(none))	///		
	(scatter b fa if square==$square & fa>1, mcolor(black%10) msymbol(o)) ///
	, xtitle("") ytitle("") yline($cu $cl,lpattern(dash) lcolor(black%50)) scheme(s1mono) name(sq$square,replace) xscale(alt) xlabel(0 " " 2.5 "Either" 5 " " 7.5 "CB" 10 " " 12.5 "WI" 15 " ",noticks) legend(order(3 "Either" 4 "TLD" 5 "Language" 6 "Alexa") cols(4) region(lwidth(none))) xline(5 10,lcolor(black))
		graph export "$texpath/figures/figureA1_$square.pdf", replace	
	
	global square=2
	
	su cu if fa==1 & square==$square
	global cu=`r(mean)'
	su cl if fa==1 & square==$square
	global cl=`r(mean)'
	
	twoway ///
	(scatter b fa if square==$square & fa==1, mcolor(red) msymbol(D)) ///
	(rcap cu cl fa if square==$square & fa==1, lcolor(red)) ///	
	(rbar cu cl fa if square==$square & fa==1, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==2, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==3, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==4, barwidth(0.3) fcolor(black%10) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==6, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==7, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==8, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==9, barwidth(0.3) fcolor(black%10) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==11, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==12, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==13, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==14, barwidth(0.3) fcolor(black%10) lcolor(none))	///		
	(scatter b fa if square==$square & fa>1, mcolor(black%10) msymbol(o)) ///
	, xtitle("") ytitle("") yline($cu $cl,lpattern(dash) lcolor(black%50)) scheme(s1mono)  name(sq$square,replace) xscale(alt) xlabel(0 " " 2.5 "Either" 5 " " 7.5 "CB" 10 " " 12.5 "WI" 15 " ",noticks) legend(order(3 "Either" 4 "TLD" 5 "Language" 6 "Alexa") cols(4) region(lwidth(none))) xline(5 10,lcolor(black))
		graph export "$texpath/figures/figureA1_$square.pdf", replace	
	
	global square=3
	
	su cu if fa==1 & square==$square
	global cu=`r(mean)'
	su cl if fa==1 & square==$square
	global cl=`r(mean)'
	
	twoway ///
	(scatter b fa if square==$square & fa==1, mcolor(red) msymbol(D)) ///
	(rcap cu cl fa if square==$square & fa==1, lcolor(red)) ///	
	(rbar cu cl fa if square==$square & fa==1, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==2, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==3, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==4, barwidth(0.3) fcolor(black%10) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==6, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==7, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==8, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==9, barwidth(0.3) fcolor(black%10) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==11, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==12, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==13, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==14, barwidth(0.3) fcolor(black%10) lcolor(none))	///		
	(scatter b fa if square==$square & fa>1, mcolor(black%10) msymbol(o)) ///
	, xtitle("") ytitle("") yline($cu $cl,lpattern(dash) lcolor(black%50)) scheme(s1mono)  name(sq$square,replace) xscale(alt) xlabel(0 " " 2.5 "Either" 5 " " 7.5 "CB" 10 " " 12.5 "WI" 15 " ",noticks) legend(order(3 "Either" 4 "TLD" 5 "Language" 6 "Alexa") cols(4) region(lwidth(none))) xline(5 10,lcolor(black))
		graph export "$texpath/figures/figureA1_$square.pdf", replace	
	
	global square=4
	
	su cu if fa==1 & square==$square
	global cu=`r(mean)'
	su cl if fa==1 & square==$square
	global cl=`r(mean)'
	
	twoway ///
	(scatter b fa if square==$square & fa==1, mcolor(red) msymbol(D)) ///
	(rcap cu cl fa if square==$square & fa==1, lcolor(red)) ///	
	(rbar cu cl fa if square==$square & fa==1, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==2, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==3, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==4, barwidth(0.3) fcolor(black%10) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==6, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==7, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==8, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==9, barwidth(0.3) fcolor(black%10) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==11, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==12, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==13, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==14, barwidth(0.3) fcolor(black%10) lcolor(none))	///		
	(scatter b fa if square==$square & fa>1, mcolor(black%10) msymbol(o)) ///
	, xtitle("") ytitle("") yline($cu $cl,lpattern(dash) lcolor(black%50)) scheme(s1mono)  name(sq$square,replace) xscale(alt) xlabel(0 " " 2.5 "Either" 5 " " 7.5 "CB" 10 " " 12.5 "WI" 15 " ",noticks) legend(order(3 "Either" 4 "TLD" 5 "Language" 6 "Alexa") cols(4) region(lwidth(none))) xline(5 10,lcolor(black))
		graph export "$texpath/figures/figureA1_$square.pdf", replace	

*******************************
**** Figure A.2
*******************************


preserve

	clear
	set obs 4
	gen square=_n
	expand 3
	sort square
	bys square: gen firm=_n
	expand 5
	sort square firm
	bys square firm: gen audience=_n
	gen b=.
	gen cu=.
	gen cl=.
	save "specgraph.dta",replace
	
restore

use  "gdpr_website.dta",clear

forvalues firm=1(1)3 {

	forvalues audience=1(1)4 {

		reghdfe log_cookies3 c.trend#(c.eu_a`audience' c.neu_a`audience') c.after#(c.eu_a`audience' c.neu_a`audience') if eu_l`firm'==1 & exclude==0, absorb(h) vce(cluster h) nocons
		local c_`audience'`firm'1=_b[c.after#c.eu_a`audience']
		local se_`audience'`firm'1=_se[c.after#c.eu_a`audience']
		local c_`audience'`firm'3=_b[c.after#c.neu_a`audience']
		local se_`audience'`firm'3=_se[c.after#c.neu_a`audience']
		reghdfe log_cookies3 c.trend#(c.eu_a`audience' c.neu_a`audience') c.after#(c.eu_a`audience' c.neu_a`audience') if eu_l`firm'==0 & exclude==0, absorb(h) vce(cluster h) nocons
		local c_`audience'`firm'2=_b[c.after#c.eu_a`audience']
		local se_`audience'`firm'2=_se[c.after#c.eu_a`audience']
		local c_`audience'`firm'4=_b[c.after#c.neu_a`audience']
		local se_`audience'`firm'4=_se[c.after#c.neu_a`audience']
		
		preserve

			use "specgraph.dta",clear
			replace b=`c_`audience'`firm'1' if audience==`audience' & firm==`firm' & square==1
			replace cu=`c_`audience'`firm'1'+1.65*`se_`audience'`firm'1' if audience==`audience' & firm==`firm' & square==1
			replace cl=`c_`audience'`firm'1'-1.65*`se_`audience'`firm'1' if audience==`audience' & firm==`firm' & square==1
			replace b=`c_`audience'`firm'3' if audience==`audience' & firm==`firm' & square==3
			replace cu=`c_`audience'`firm'3'+1.65*`se_`audience'`firm'3' if audience==`audience' & firm==`firm' & square==3
			replace cl=`c_`audience'`firm'3'-1.65*`se_`audience'`firm'3' if audience==`audience' & firm==`firm' & square==3
			replace b=`c_`audience'`firm'2' if audience==`audience' & firm==`firm' & square==2
			replace cu=`c_`audience'`firm'2'+1.65*`se_`audience'`firm'2' if audience==`audience' & firm==`firm' & square==2
			replace cl=`c_`audience'`firm'2'-1.65*`se_`audience'`firm'2' if audience==`audience' & firm==`firm' & square==2
			replace b=`c_`audience'`firm'4' if audience==`audience' & firm==`firm' & square==4
			replace cu=`c_`audience'`firm'4'+1.65*`se_`audience'`firm'4' if audience==`audience' & firm==`firm' & square==4
			replace cl=`c_`audience'`firm'4'-1.65*`se_`audience'`firm'4' if audience==`audience' & firm==`firm' & square==4	
			save "specgraph.dta",replace	
			
		restore	
		
	}

}



preserve

	use "specgraph.dta",clear


	egen fa=group(firm audience)

	global square=1
	
	su cu if fa==1 & square==$square
	global cu=`r(mean)'
	su cl if fa==1 & square==$square
	global cl=`r(mean)'
	
	twoway ///
	(scatter b fa if square==$square & fa==1, mcolor(red) msymbol(D)) ///
	(rcap cu cl fa if square==$square & fa==1, lcolor(red)) ///	
	(rbar cu cl fa if square==$square & fa==1, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==2, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==3, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==4, barwidth(0.3) fcolor(black%10) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==6, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==7, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==8, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==9, barwidth(0.3) fcolor(black%10) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==11, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==12, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==13, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==14, barwidth(0.3) fcolor(black%10) lcolor(none))	///		
	(scatter b fa if square==$square & fa>1, mcolor(black%10) msymbol(o)) ///
	, xtitle("") ytitle("") yline($cu $cl,lpattern(dash) lcolor(black%50)) scheme(s1mono) name(sq$square,replace) xscale(alt) xlabel(0 " " 2.5 "Either" 5 " " 7.5 "CB" 10 " " 12.5 "WI" 15 " ",noticks) legend(order(3 "Either" 4 "TLD" 5 "Language" 6 "Alexa") cols(4) region(lwidth(none))) xline(5 10,lcolor(black))
		graph export "$texpath/figures/figureA2_$square.pdf", replace	
	
	global square=2
	
	su cu if fa==1 & square==$square
	global cu=`r(mean)'
	su cl if fa==1 & square==$square
	global cl=`r(mean)'
	
	twoway ///
	(scatter b fa if square==$square & fa==1, mcolor(red) msymbol(D)) ///
	(rcap cu cl fa if square==$square & fa==1, lcolor(red)) ///	
	(rbar cu cl fa if square==$square & fa==1, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==2, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==3, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==4, barwidth(0.3) fcolor(black%10) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==6, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==7, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==8, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==9, barwidth(0.3) fcolor(black%10) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==11, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==12, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==13, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==14, barwidth(0.3) fcolor(black%10) lcolor(none))	///		
	(scatter b fa if square==$square & fa>1, mcolor(black%10) msymbol(o)) ///
	, xtitle("") ytitle("") yline($cu $cl,lpattern(dash) lcolor(black%50)) scheme(s1mono)  name(sq$square,replace) xscale(alt) xlabel(0 " " 2.5 "Either" 5 " " 7.5 "CB" 10 " " 12.5 "WI" 15 " ",noticks) legend(order(3 "Either" 4 "TLD" 5 "Language" 6 "Alexa") cols(4) region(lwidth(none))) xline(5 10,lcolor(black))
		graph export "$texpath/figures/figureA2_$square.pdf", replace	
	
	global square=3
	
	su cu if fa==1 & square==$square
	global cu=`r(mean)'
	su cl if fa==1 & square==$square
	global cl=`r(mean)'
	
	twoway ///
	(scatter b fa if square==$square & fa==1, mcolor(red) msymbol(D)) ///
	(rcap cu cl fa if square==$square & fa==1, lcolor(red)) ///	
	(rbar cu cl fa if square==$square & fa==1, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==2, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==3, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==4, barwidth(0.3) fcolor(black%10) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==6, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==7, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==8, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==9, barwidth(0.3) fcolor(black%10) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==11, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==12, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==13, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==14, barwidth(0.3) fcolor(black%10) lcolor(none))	///		
	(scatter b fa if square==$square & fa>1, mcolor(black%10) msymbol(o)) ///
	, xtitle("") ytitle("") yline($cu $cl,lpattern(dash) lcolor(black%50)) scheme(s1mono)  name(sq$square,replace) xscale(alt) xlabel(0 " " 2.5 "Either" 5 " " 7.5 "CB" 10 " " 12.5 "WI" 15 " ",noticks) legend(order(3 "Either" 4 "TLD" 5 "Language" 6 "Alexa") cols(4) region(lwidth(none))) xline(5 10,lcolor(black))
		graph export "$texpath/figures/figureA2_$square.pdf", replace	
	
	global square=4
	
	su cu if fa==1 & square==$square
	global cu=`r(mean)'
	su cl if fa==1 & square==$square
	global cl=`r(mean)'
	
	twoway ///
	(scatter b fa if square==$square & fa==1, mcolor(red) msymbol(D)) ///
	(rcap cu cl fa if square==$square & fa==1, lcolor(red)) ///	
	(rbar cu cl fa if square==$square & fa==1, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==2, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==3, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==4, barwidth(0.3) fcolor(black%10) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==6, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==7, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==8, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==9, barwidth(0.3) fcolor(black%10) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==11, barwidth(0.3) fcolor(black%40) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==12, barwidth(0.3) fcolor(black%30) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==13, barwidth(0.3) fcolor(black%20) lcolor(none))	///
	(rbar cu cl fa if square==$square & fa==14, barwidth(0.3) fcolor(black%10) lcolor(none))	///		
	(scatter b fa if square==$square & fa>1, mcolor(black%10) msymbol(o)) ///
	, xtitle("") ytitle("") yline($cu $cl,lpattern(dash) lcolor(black%50)) scheme(s1mono)  name(sq$square,replace) xscale(alt) xlabel(0 " " 2.5 "Either" 5 " " 7.5 "CB" 10 " " 12.5 "WI" 15 " ",noticks) legend(order(3 "Either" 4 "TLD" 5 "Language" 6 "Alexa") cols(4) region(lwidth(none))) xline(5 10,lcolor(black))
		graph export "$texpath/figures/figureA2_$square.pdf", replace
		

restore
	



*******************************
**** Figure A.3
*******************************

use  "gdpr_website.dta",clear



reghdfe log_requests3 ib21319.date##c.eu_audience if eu_location==1 & exclude==0, absorb(h) vce(cluster h) nocons
estadd ysumm

	coefplot, keep(*.date#c.eu_audience) drop(ib21319.date#c.eu_audience) level(90) mcolor(black) ciopts(lcolor(black) recast(rcap))  vertical base omitted  yline(0,lcolor(black) lpattern(solid)) xline(21,lpattern(dash) lcolor(black)) scheme(s2color) ylabel(,grid  glcolor(gs15)) graphregion(fcolor(white) ifcolor(white) ilcolor(white)) xlabel(,grid  glcolor(gs15) angle(vertical)) ytitle("Parameter estimate and 90% CI") coeflabels(20940.date#c.eu_audience = "01may2017" 20954.date#c.eu_audience = "15may2017" 20971.date#c.eu_audience = "01jun2017" 20985.date#c.eu_audience = "15jun2017" 21001.date#c.eu_audience = "01jul2017" 21015.date#c.eu_audience = "15jul2017" 21032.date#c.eu_audience = "01aug2017" 21046.date#c.eu_audience = "15aug2017" 21063.date#c.eu_audience = "01sep2017" 21077.date#c.eu_audience = "15sep2017" 21093.date#c.eu_audience = "01oct2017" 21107.date#c.eu_audience = "15oct2017" 21124.date#c.eu_audience = "01nov2017" 21138.date#c.eu_audience = "15nov2017" 21154.date#c.eu_audience = "01dec2017" 21168.date#c.eu_audience = "15dec2017" 21185.date#c.eu_audience = "01jan2018" 21199.date#c.eu_audience = "15jan2018" 21216.date#c.eu_audience = "01feb2018" 21230.date#c.eu_audience = "15feb2018" 21244.date#c.eu_audience = "01mar2018" 21258.date#c.eu_audience = "15mar2018" 21289.date#c.eu_audience = "15apr2018" 21305.date#c.eu_audience = "01may2018" 21319.date#c.eu_audience = "15may2018" 21336.date#c.eu_audience = "01jun2018" 21350.date#c.eu_audience = "15jun2018" 21366.date#c.eu_audience = "01jul2018" 21380.date#c.eu_audience = "15jul2018" 21397.date#c.eu_audience = "01aug2018" 21411.date#c.eu_audience = "15aug2018" 21428.date#c.eu_audience = "01sep2018" 21442.date#c.eu_audience = "15sep2018" 21458.date#c.eu_audience = "01oct2018" 21472.date#c.eu_audience = "15oct2018" 21489.date#c.eu_audience = "01nov2018" 21503.date#c.eu_audience = "15nov2018") name(weekdummies_requests_square1,replace)
	graph export "$texpath/figures/figureA3_1.pdf", replace
	
	
		coefplot, keep(*.date) drop(ib21319.date) level(90) mcolor(black) ciopts(lcolor(black) recast(rcap))  vertical base omitted  yline(0,lcolor(black) lpattern(solid)) xline(21,lpattern(dash) lcolor(black)) scheme(s2color) ylabel(,grid  glcolor(gs15)) graphregion(fcolor(white) ifcolor(white) ilcolor(white)) xlabel(,grid  glcolor(gs15) angle(vertical)) ytitle("Parameter estimate and 90% CI") coeflabels(20940.date = "01may2017" 20954.date = "15may2017" 20971.date = "01jun2017" 20985.date = "15jun2017" 21001.date = "01jul2017" 21015.date = "15jul2017" 21032.date = "01aug2017" 21046.date = "15aug2017" 21063.date = "01sep2017" 21077.date = "15sep2017" 21093.date = "01oct2017" 21107.date = "15oct2017" 21124.date = "01nov2017" 21138.date = "15nov2017" 21154.date = "01dec2017" 21168.date = "15dec2017" 21185.date = "01jan2018" 21199.date = "15jan2018" 21216.date = "01feb2018" 21230.date = "15feb2018" 21244.date = "01mar2018" 21258.date = "15mar2018" 21289.date = "15apr2018" 21305.date = "01may2018" 21319.date = "15may2018" 21336.date = "01jun2018" 21350.date = "15jun2018" 21366.date = "01jul2018" 21380.date = "15jul2018" 21397.date = "01aug2018" 21411.date = "15aug2018" 21428.date = "01sep2018" 21442.date = "15sep2018" 21458.date = "01oct2018" 21472.date = "15oct2018" 21489.date = "01nov2018" 21503.date = "15nov2018") name(weekdummies_requests_square3,replace)
	graph export "$texpath/figures/figureA3_3.pdf", replace		

lincom 21305.date#c.eu_audience+21336.date#c.eu_audience, level(90)
di (exp(`r(estimate)')-1)*100
lincom 21305.date+21336.date, level(90)
di (exp(`r(estimate)')-1)*100
	
reghdfe log_requests3 ib21319.date##c.eu_audience if eu_location==0 & exclude==0, absorb(h) vce(cluster h) nocons
estadd ysumm

	coefplot, keep(*.date#c.eu_audience) drop(ib21319.date#c.eu_audience) level(90) mcolor(black) ciopts(lcolor(black) recast(rcap))  vertical base omitted  yline(0,lcolor(black) lpattern(solid)) xline(21,lpattern(dash) lcolor(black)) scheme(s2color) ylabel(,grid  glcolor(gs15)) graphregion(fcolor(white) ifcolor(white) ilcolor(white)) xlabel(,grid  glcolor(gs15) angle(vertical)) ytitle("Parameter estimate and 90% CI") coeflabels(20940.date#c.eu_audience = "01may2017" 20954.date#c.eu_audience = "15may2017" 20971.date#c.eu_audience = "01jun2017" 20985.date#c.eu_audience = "15jun2017" 21001.date#c.eu_audience = "01jul2017" 21015.date#c.eu_audience = "15jul2017" 21032.date#c.eu_audience = "01aug2017" 21046.date#c.eu_audience = "15aug2017" 21063.date#c.eu_audience = "01sep2017" 21077.date#c.eu_audience = "15sep2017" 21093.date#c.eu_audience = "01oct2017" 21107.date#c.eu_audience = "15oct2017" 21124.date#c.eu_audience = "01nov2017" 21138.date#c.eu_audience = "15nov2017" 21154.date#c.eu_audience = "01dec2017" 21168.date#c.eu_audience = "15dec2017" 21185.date#c.eu_audience = "01jan2018" 21199.date#c.eu_audience = "15jan2018" 21216.date#c.eu_audience = "01feb2018" 21230.date#c.eu_audience = "15feb2018" 21244.date#c.eu_audience = "01mar2018" 21258.date#c.eu_audience = "15mar2018" 21289.date#c.eu_audience = "15apr2018" 21305.date#c.eu_audience = "01may2018" 21319.date#c.eu_audience = "15may2018" 21336.date#c.eu_audience = "01jun2018" 21350.date#c.eu_audience = "15jun2018" 21366.date#c.eu_audience = "01jul2018" 21380.date#c.eu_audience = "15jul2018" 21397.date#c.eu_audience = "01aug2018" 21411.date#c.eu_audience = "15aug2018" 21428.date#c.eu_audience = "01sep2018" 21442.date#c.eu_audience = "15sep2018" 21458.date#c.eu_audience = "01oct2018" 21472.date#c.eu_audience = "15oct2018" 21489.date#c.eu_audience = "01nov2018" 21503.date#c.eu_audience = "15nov2018") name(weekdummies_requests_square2,replace)
		graph export "$texpath/figures/figureA3_2.pdf", replace

		coefplot, keep(*.date) drop(ib21319.date) level(90) mcolor(black) ciopts(lcolor(black) recast(rcap))  vertical base omitted  yline(0,lcolor(black) lpattern(solid)) xline(21,lpattern(dash) lcolor(black)) scheme(s2color) ylabel(,grid  glcolor(gs15)) graphregion(fcolor(white) ifcolor(white) ilcolor(white)) xlabel(,grid  glcolor(gs15) angle(vertical)) ytitle("Parameter estimate and 90% CI") coeflabels(20940.date = "01may2017" 20954.date = "15may2017" 20971.date = "01jun2017" 20985.date = "15jun2017" 21001.date = "01jul2017" 21015.date = "15jul2017" 21032.date = "01aug2017" 21046.date = "15aug2017" 21063.date = "01sep2017" 21077.date = "15sep2017" 21093.date = "01oct2017" 21107.date = "15oct2017" 21124.date = "01nov2017" 21138.date = "15nov2017" 21154.date = "01dec2017" 21168.date = "15dec2017" 21185.date = "01jan2018" 21199.date = "15jan2018" 21216.date = "01feb2018" 21230.date = "15feb2018" 21244.date = "01mar2018" 21258.date = "15mar2018" 21289.date = "15apr2018" 21305.date = "01may2018" 21319.date = "15may2018" 21336.date = "01jun2018" 21350.date = "15jun2018" 21366.date = "01jul2018" 21380.date = "15jul2018" 21397.date = "01aug2018" 21411.date = "15aug2018" 21428.date = "01sep2018" 21442.date = "15sep2018" 21458.date = "01oct2018" 21472.date = "15oct2018" 21489.date = "01nov2018" 21503.date = "15nov2018") name(weekdummies_requests_square4,replace)
	graph export "$texpath/figures/figureA3_4.pdf", replace

lincom 21305.date#c.eu_audience+21336.date#c.eu_audience, level(90)
di (exp(`r(estimate)')-1)*100
lincom 21305.date+21336.date, level(90)
di (exp(`r(estimate)')-1)*100	
	

*******************************
**** Figure A.4
*******************************

use  "gdpr_website.dta",clear

reghdfe log_cookies3 ib21319.date##c.eu_audience if eu_location==1 & exclude==0, absorb(h) vce(cluster h) nocons
estadd ysumm

	coefplot, keep(*.date#c.eu_audience) drop(ib21319.date#c.eu_audience) level(90) mcolor(black) ciopts(lcolor(black) recast(rcap))  vertical base omitted  yline(0,lcolor(black) lpattern(solid)) xline(21,lpattern(dash) lcolor(black)) scheme(s2color) ylabel(,grid  glcolor(gs15)) graphregion(fcolor(white) ifcolor(white) ilcolor(white)) xlabel(,grid  glcolor(gs15) angle(vertical)) ytitle("Parameter estimate and 90% CI") coeflabels(20940.date#c.eu_audience = "01may2017" 20954.date#c.eu_audience = "15may2017" 20971.date#c.eu_audience = "01jun2017" 20985.date#c.eu_audience = "15jun2017" 21001.date#c.eu_audience = "01jul2017" 21015.date#c.eu_audience = "15jul2017" 21032.date#c.eu_audience = "01aug2017" 21046.date#c.eu_audience = "15aug2017" 21063.date#c.eu_audience = "01sep2017" 21077.date#c.eu_audience = "15sep2017" 21093.date#c.eu_audience = "01oct2017" 21107.date#c.eu_audience = "15oct2017" 21124.date#c.eu_audience = "01nov2017" 21138.date#c.eu_audience = "15nov2017" 21154.date#c.eu_audience = "01dec2017" 21168.date#c.eu_audience = "15dec2017" 21185.date#c.eu_audience = "01jan2018" 21199.date#c.eu_audience = "15jan2018" 21216.date#c.eu_audience = "01feb2018" 21230.date#c.eu_audience = "15feb2018" 21244.date#c.eu_audience = "01mar2018" 21258.date#c.eu_audience = "15mar2018" 21289.date#c.eu_audience = "15apr2018" 21305.date#c.eu_audience = "01may2018" 21319.date#c.eu_audience = "15may2018" 21336.date#c.eu_audience = "01jun2018" 21350.date#c.eu_audience = "15jun2018" 21366.date#c.eu_audience = "01jul2018" 21380.date#c.eu_audience = "15jul2018" 21397.date#c.eu_audience = "01aug2018" 21411.date#c.eu_audience = "15aug2018" 21428.date#c.eu_audience = "01sep2018" 21442.date#c.eu_audience = "15sep2018" 21458.date#c.eu_audience = "01oct2018" 21472.date#c.eu_audience = "15oct2018" 21489.date#c.eu_audience = "01nov2018" 21503.date#c.eu_audience = "15nov2018") name(weekdummies_cookies_square1,replace)
	graph export "$texpath/figures/figureA4_1.pdf", replace
	
	
		coefplot, keep(*.date) drop(ib21319.date) level(90) mcolor(black) ciopts(lcolor(black) recast(rcap))  vertical base omitted  yline(0,lcolor(black) lpattern(solid)) xline(21,lpattern(dash) lcolor(black)) scheme(s2color) ylabel(,grid  glcolor(gs15)) graphregion(fcolor(white) ifcolor(white) ilcolor(white)) xlabel(,grid  glcolor(gs15) angle(vertical)) ytitle("Parameter estimate and 90% CI") coeflabels(20940.date = "01may2017" 20954.date = "15may2017" 20971.date = "01jun2017" 20985.date = "15jun2017" 21001.date = "01jul2017" 21015.date = "15jul2017" 21032.date = "01aug2017" 21046.date = "15aug2017" 21063.date = "01sep2017" 21077.date = "15sep2017" 21093.date = "01oct2017" 21107.date = "15oct2017" 21124.date = "01nov2017" 21138.date = "15nov2017" 21154.date = "01dec2017" 21168.date = "15dec2017" 21185.date = "01jan2018" 21199.date = "15jan2018" 21216.date = "01feb2018" 21230.date = "15feb2018" 21244.date = "01mar2018" 21258.date = "15mar2018" 21289.date = "15apr2018" 21305.date = "01may2018" 21319.date = "15may2018" 21336.date = "01jun2018" 21350.date = "15jun2018" 21366.date = "01jul2018" 21380.date = "15jul2018" 21397.date = "01aug2018" 21411.date = "15aug2018" 21428.date = "01sep2018" 21442.date = "15sep2018" 21458.date = "01oct2018" 21472.date = "15oct2018" 21489.date = "01nov2018" 21503.date = "15nov2018") name(weekdummies_cookies_square3,replace)
	graph export "$texpath/figures/figureA4_3.pdf", replace		

lincom 21305.date#c.eu_audience+21336.date#c.eu_audience, level(90)
di (exp(`r(estimate)')-1)*100
lincom 21305.date+21336.date, level(90)
di (exp(`r(estimate)')-1)*100	
	
reghdfe log_cookies3 ib21319.date##c.eu_audience if eu_location==0 & exclude==0, absorb(h) vce(cluster h) nocons
estadd ysumm

	coefplot, keep(*.date#c.eu_audience) drop(ib21319.date#c.eu_audience) level(90) mcolor(black) ciopts(lcolor(black) recast(rcap))  vertical base omitted  yline(0,lcolor(black) lpattern(solid)) xline(21,lpattern(dash) lcolor(black)) scheme(s2color) ylabel(,grid  glcolor(gs15)) graphregion(fcolor(white) ifcolor(white) ilcolor(white)) xlabel(,grid  glcolor(gs15) angle(vertical)) ytitle("Parameter estimate and 90% CI") coeflabels(20940.date#c.eu_audience = "01may2017" 20954.date#c.eu_audience = "15may2017" 20971.date#c.eu_audience = "01jun2017" 20985.date#c.eu_audience = "15jun2017" 21001.date#c.eu_audience = "01jul2017" 21015.date#c.eu_audience = "15jul2017" 21032.date#c.eu_audience = "01aug2017" 21046.date#c.eu_audience = "15aug2017" 21063.date#c.eu_audience = "01sep2017" 21077.date#c.eu_audience = "15sep2017" 21093.date#c.eu_audience = "01oct2017" 21107.date#c.eu_audience = "15oct2017" 21124.date#c.eu_audience = "01nov2017" 21138.date#c.eu_audience = "15nov2017" 21154.date#c.eu_audience = "01dec2017" 21168.date#c.eu_audience = "15dec2017" 21185.date#c.eu_audience = "01jan2018" 21199.date#c.eu_audience = "15jan2018" 21216.date#c.eu_audience = "01feb2018" 21230.date#c.eu_audience = "15feb2018" 21244.date#c.eu_audience = "01mar2018" 21258.date#c.eu_audience = "15mar2018" 21289.date#c.eu_audience = "15apr2018" 21305.date#c.eu_audience = "01may2018" 21319.date#c.eu_audience = "15may2018" 21336.date#c.eu_audience = "01jun2018" 21350.date#c.eu_audience = "15jun2018" 21366.date#c.eu_audience = "01jul2018" 21380.date#c.eu_audience = "15jul2018" 21397.date#c.eu_audience = "01aug2018" 21411.date#c.eu_audience = "15aug2018" 21428.date#c.eu_audience = "01sep2018" 21442.date#c.eu_audience = "15sep2018" 21458.date#c.eu_audience = "01oct2018" 21472.date#c.eu_audience = "15oct2018" 21489.date#c.eu_audience = "01nov2018" 21503.date#c.eu_audience = "15nov2018") name(weekdummies_cookies_square2,replace)
		graph export "$texpath/figures/figureA4_2.pdf", replace

	coefplot, keep(*.date) drop(ib21319.date) level(90) mcolor(black) ciopts(lcolor(black) recast(rcap))  vertical base omitted  yline(0,lcolor(black) lpattern(solid)) xline(21,lpattern(dash) lcolor(black)) scheme(s2color) ylabel(,grid  glcolor(gs15)) graphregion(fcolor(white) ifcolor(white) ilcolor(white)) xlabel(,grid  glcolor(gs15) angle(vertical)) ytitle("Parameter estimate and 90% CI") coeflabels(20940.date = "01may2017" 20954.date = "15may2017" 20971.date = "01jun2017" 20985.date = "15jun2017" 21001.date = "01jul2017" 21015.date = "15jul2017" 21032.date = "01aug2017" 21046.date = "15aug2017" 21063.date = "01sep2017" 21077.date = "15sep2017" 21093.date = "01oct2017" 21107.date = "15oct2017" 21124.date = "01nov2017" 21138.date = "15nov2017" 21154.date = "01dec2017" 21168.date = "15dec2017" 21185.date = "01jan2018" 21199.date = "15jan2018" 21216.date = "01feb2018" 21230.date = "15feb2018" 21244.date = "01mar2018" 21258.date = "15mar2018" 21289.date = "15apr2018" 21305.date = "01may2018" 21319.date = "15may2018" 21336.date = "01jun2018" 21350.date = "15jun2018" 21366.date = "01jul2018" 21380.date = "15jul2018" 21397.date = "01aug2018" 21411.date = "15aug2018" 21428.date = "01sep2018" 21442.date = "15sep2018" 21458.date = "01oct2018" 21472.date = "15oct2018" 21489.date = "01nov2018" 21503.date = "15nov2018") name(weekdummies_cookies_square4,replace)
	graph export "$texpath/figures/figureA4_4.pdf", replace	

lincom 21305.date#c.eu_audience+21336.date#c.eu_audience, level(90)
di (exp(`r(estimate)')-1)*100
lincom 21305.date+21336.date, level(90)
di (exp(`r(estimate)')-1)*100	

*******************************
**** Figure A.5
*******************************


use  "gdpr_website_2016.dta",clear
	

	
	twoway ///
	(lfitci log_requests date if eu_audience==1 & eu_location==1 & exclude==0, fcolor(gray%10) lcolor(gray%10) level(90)) ///		
	(lfitci log_requests date if eu_audience==1 & eu_location==1 & exclude==0 & after==0, fcolor(gray%50) lcolor(gray%50) level(90)) ///
	(lfitci log_requests date if eu_audience==1 & eu_location==1 & exclude==0 & after==1, fcolor(gray%50) lcolor(gray%50) level(90)) ///	
	(scatter mean_log_requests3t date if eu_audience==1 & eu_location==1 & exclude==0 & first==1, mcolor(black) msymbol(o)) ///
	, xline(20558,lcolor(black) lpattern(dash)) name(case1,replace) scheme(s1mono) legend(off) xlabel(20454(30)20589, format(%td)) xtitle("")
	graph export "$texpath/figures/figureA5_1.pdf", replace	
	
	twoway ///
	(lfitci log_requests date if eu_audience==1 & eu_location==1 & exclude==0, fcolor(gray%10) lcolor(gray%10) level(90)) ///	
	(lfitci log_requests date if eu_audience==1 & eu_location==0 & exclude==0 & after==0, fcolor(gray%50) lcolor(gray%50) level(90)) ///
	(lfitci log_requests date if eu_audience==1 & eu_location==0 & exclude==0 & after==1, fcolor(gray%50) lcolor(gray%50) level(90)) ///
	(scatter mean_log_requests3t date if eu_audience==1 & eu_location==0 & exclude==0 & first==1, mcolor(black) msymbol(o)) ///
	, xline(20558,lcolor(black) lpattern(dash)) name(case2,replace) scheme(s1mono) legend(off) xlabel(20454(30)20589, format(%td)) xtitle("")
	graph export "$texpath/figures/figureA5_2.pdf", replace	
	
	twoway ///
	(lfitci log_requests date if eu_audience==1 & eu_location==1 & exclude==0, fcolor(gray%10) lcolor(gray%10) level(90)) ///		
	(lfitci log_requests date if eu_audience==0 & eu_location==1 & exclude==0 & after==0, fcolor(gray%50) lcolor(gray%50) level(90)) ///
	(lfitci log_requests date if eu_audience==0 & eu_location==1 & exclude==0 & after==1, fcolor(gray%50) lcolor(gray%50) level(90)) ///
	(scatter mean_log_requests3t date if eu_audience==0 & eu_location==1 & exclude==0 & first==1, mcolor(black) msymbol(o)) ///
	, xline(20558,lcolor(black) lpattern(dash)) name(case3,replace) scheme(s1mono) legend(off) xlabel(20454(30)20589, format(%td)) xtitle("")
	graph export "$texpath/figures/figureA5_3.pdf", replace	
	
	twoway ///
	(lfitci log_requests date if eu_audience==1 & eu_location==1 & exclude==0, fcolor(gray%10) lcolor(gray%10) level(90)) ///		
	(lfitci log_requests date if eu_audience==1 & eu_location==1 & exclude==0 & after==0, fcolor(gray%50) lcolor(gray%50) level(90)) ///
	(lfitci log_requests date if eu_audience==1 & eu_location==1 & exclude==0 & after==1, fcolor(gray%50) lcolor(gray%50) level(90)) ///
	(scatter mean_log_requests3t date if eu_audience==1 & eu_location==1 & exclude==0 & first==1, mcolor(black) msymbol(o)) ///
	, xline(20558,lcolor(black) lpattern(dash)) name(case4,replace) scheme(s1mono) legend(off) xlabel(20454(30)20589, format(%td)) xtitle("")
	graph export "$texpath/figures/figureA5_4.pdf", replace		
	


*******************************
**** Figure A.6
*******************************	


use "gdpr_vendors.dta",clear	
	
	collapse (sum) ms_websites_firm=ms_websites  , by(tracker_firm date) fast
	gen ms_websites_firm2=ms_websites_firm^2
	collapse (sum) hhi=ms_websites_firm2, by(date) fast
		
	twoway ///
	(connected hhi date,yaxis(1) ytitle("",axis(1)) msymbol(X) lcolor(black) mcolor(black) lpattern(solid)) ///
	, ylabel(, grid) xlabel(#6,grid) ///
	xline(21329, lcolor(black) lpattern(dash)) name(figureA6_1,replace) xtitle("")  scheme(s1color) ///
	legend(off)
	graph export "$texpath/figures/figureA6_1.pdf", replace	

	
use "gdpr_vendors_eu.dta",clear	

	twoway ///
	(connected hhi date if eu_audience==1 & eu_location==1,yaxis(1) ytitle("EU-EU",axis(1)) lcolor(black) mcolor(black) lpattern(solid)) ///
	(connected hhi date if eu_audience==0 & eu_location==0,yaxis(2) ytitle("nonEU-nonEU",axis(2)) msymbol(X) lcolor(black) mcolor(black) lpattern(dashed)) ///		
	, ylabel(, grid) xlabel(#6,grid) ///
	xline(21329, lcolor(black) lpattern(dash)) name(figureA6_2,replace) xtitle("")  scheme(s1color) ///
	legend(order(1 "EU-EU (Case 1)" 2 "nonEU-nonEU (Case 4)"))
	graph export "$texpath/figures/figureA6_2.pdf", replace	

	twoway ///
	(connected hhi date if eu_audience==1 & eu_location==0,yaxis(1) ytitle("EU-nonEU",axis(1)) lcolor(black) mcolor(black) lpattern(solid)) ///
	(connected hhi date if eu_audience==0 & eu_location==1,yaxis(2) ytitle("nonEU-EU",axis(2)) msymbol(X) lcolor(black) mcolor(black) lpattern(dashed)) ///		
	, ylabel(, grid) xlabel(#6,grid) ///
	xline(21329, lcolor(black) lpattern(dash)) name(figureA6_3,replace) xtitle("")  scheme(s1color) ///
	legend(order(1 "EU-nonEU (Case 3)" 2 "nonEU-EU (Case 2)"))
	graph export "$texpath/figures/figureA6_3.pdf", replace	
	
