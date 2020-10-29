import excel "C:\Users\tanya raj\Documents\DATASET IPO(Sector Wise).xlsx", sheet("Sheet1") firstrow
gen underpricing = ListingClosePrice - IssuePrice
gen pricing=0
replace pricing=-1 if underpricing<0
replace pricing=1 if underpricing>0
encode Sector, gen(sector)
grmeanby sector, summarize(underpricing)
lab define vo -1 "Negative Underpriced" 0 "Appropriate Priced" 1 "Positive Underpriced"
lab value pricing vo
tab sector pricing
tabstat underpricing, statistics( mean max min sd ) by(sector)
tabstat IssueSizeinCrores , statistics( mean max min sd ) by(sector)
tabstat IssuePrice , statistics( mean max min sd ) by(sector)
tabstat ListingOpenPrice , statistics( mean max min sd ) by(sector)
tabstat ListingClosePrice , statistics( mean max min sd ) by(sector)
tabstat ListingGains , statistics( mean max min sd ) by(sector)
graph hbar (mean) underpricing, over(sector)
graph hbar (mean) underpricing , over(sector)
twoway (line ListingGains IssueSizeinCrores, sort), xlab(0(1000)10000)
reg ListingGains IssueSizeinCrores
reg TotalSubscription IssueSizeinCrores
gen UnderpricingRatio = underpricing / IssuePrice
tabstat IssuePrice ListingOpenPrice ListingClosePrice underpricing UnderpricingRatio, statistics( mean max min sd ) by(sector)
graph hbar (mean) underpricing, over(sector)
twoway (line ListingGains IssueSizeinCrores, sort), xlab(0(1000)10000)
graph hbar (mean) underpricing , over(sector)
twoway (line TotalSubscription IssueSizeinCrores, sort), xlab(0(1000)10000)
graph hbar (mean) ListingGains , over(sector)
