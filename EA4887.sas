/*ITP4887 Assignment
Group member: Au Cheuk Sam, Ho Tsz Hin  */

PROC SQL;
	create table price as
	select DISTINCT FlatType, avg(price) as avgprice from DATA.EA4887
	Group By FlatType;

run;

/*Q1 Generate 5 to 10 records*/

proc print data=data.EA4887(firstobs=5 obs=10);
title "Q1:Generate 5 to 10 records";
run;

/*Q2 The property with the most number of the bathroom on average*/
Proc sgplot data=DATA.EA4887;
	title "Q2:Property with the most number of the bathroom on average";
	vbar FlatType / response= TotalBaths stat=mean categoryorder=respasc datalabel;
run;
title;

/* The bar chart shows the number of the bathroom in different property on average. Detached house has the is the property 
with the most number of the bathroom on average based on the bar chart. */

/*Q3 The contribution of house type in the record and the common type of property in the UK*/
PROC template;
define statgraph piechart;
	begingraph;
		entrytitle "Q3:The contribution of house type in the record and the common type of property in the UK";
			layout region;
				piechart category=FlatType / 
				datalabelcontent=(category percent);
			endlayout;
	endgraph;
end;
run;

proc sgrender data=DATA.EA4887 template=piechart;
run;

/* Based on the pie chart, flat is the most common type of property in UK. */

/* PROC sgpie data=DATA.EA4887; */
/* 	title "Contribution of house type in the record"; */
/* 		pie FlatType ; */
/* run; */

/*Q4 The value distribution of the number of Reception between the semi-detached house and terraced house*/
PROC SQL;
create table Q4 as 
	select FlatType, count(Distinct TotalReceptions) as ReceptionsNum
	from DATA.EA4887
	where FlatType = "semi-detached house" or FlatType = "terraced house"
	Group by FlatType;
run;

PROC sgpie data=Q4;
	title "Q4:Value distribution of the number of Reception between the semi-detached house and terraced house";
		pie FlatType / response=ReceptionsNum;
run;
title;

/* Based on the pie chart from Q4, the value distribution of the number of Reception between the semi-detached house and terraced house
is the same. */

/*Q5 The property that contains the second most turnover*/

/* PROC SQL; */
/* select Distinct FlatType,sum(price) as Flatpricesum from DATA.EA4887 */
/* Group by FlatType; */
/*  */
/* run; */

Proc sgplot data=DATA.EA4887;
	title "Q5:Property that contains the second most turnover";
	vbar FlatType / response= price categoryorder=respasc datalabel;
run;

/* According to the bar chart from Q5, the property that contains the second most turnover is terraced house. */

/*Q6 Relationship between the number of bedrooms, the number of bathrooms and the 
average price of a different property*/
proc sgplot data=DATA.EA4887; 
title "Q6:Relationship between the number of bedrooms and the number of bathrooms";

 scatter X=TotalBaths Y=TotalBeds ;  

run;

/*  */

proc sgplot data=price; 
title "Q6:Relationship between the average price of different property";

 scatter X=FlatType Y=avgprice;  

run;

/* Based on the scatter diagram above, there is no relationship between the average price and property.  */

proc sgscatter data=DATA.EA4887;
  title "Scatterplot Matrix for Iris Data";
  matrix TotalBaths TotalBeds price
          / group=FlatType;
run;
title;
