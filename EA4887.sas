/*Q1 Generate 5 to 10 records*/
proc print data=data.EA4887(firstobs=5 obs=10);
run;

/*Q2 The property with the most number of the bathroom on average*/
Proc sgplot data=Housing;
	title "Property with the most number of the bathroom on average";
	vbar FlatType / response= TotalBaths stat=mean;
run;
title;
/*Q3 The contribution of house type in the record and the common type of property in the UK*/
PROC sgpie data=Housing;
	title "Contribution of house type in the record";
		pie FlatType;
run;

/*Q4 The value distribution of the number of Reception between the semi-detached house and terraced house*/
PROC sgpie data=Housing;
	title "Value distribution of the number of Reception between the semi-detached house and terraced house";
		pie FlatType / response=TotalReceptions;
run;

/*Q5 The property that contains the second most turnover*/
Proc sgplot data=Housing;
	title "Property that contains the second most turnover";
	vbar FlatType / response= price;
run;
title;
/*Q6 The relationship between the number of bedrooms, the number of bathrooms and the average price of a different property*/
proc sgplot data=Housing; 
title "Relationship between the number of bedrooms and the number of bathrooms";

 reg X=TotalBaths Y=TotalBeds ;  

run;
