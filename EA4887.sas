/*ITP4887 Assignment
Group member: Au Cheuk Sam(200196425), Ho Tsz Hin(200272205)*/
/*Github:https://github.com/Ritsuki0079/ITE4887_GroupProject.git*/

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
	footnote "Based on the bar chart, detached house has the is the property with the most number of the bathroom on average .";
run;
title;

/*Q3 The contribution of house type in the record and the common type of property in the UK*/
PROC template;
define statgraph piechart;
	begingraph;
		entrytitle "Q3:The contribution of house type in the record and the common type of property in the UK";
			layout region;
				piechart category=FlatType / 
				datalabelcontent=(category percent);
				footnote "Based on the pie chart, flat is the most common type of property in UK.";
			endlayout;
	endgraph;
end;
run;

proc sgrender data=DATA.EA4887 template=piechart;
run;

/*Q4 The value distribution of the number of Reception between the semi-detached house and terraced house*/
proc SQL;
create table Q4a as 
	select FlatType, TotalReceptions
	from DATA.EA4887
	where FlatType = "semi-detached house" or FlatType = "terraced house";
	run;

proc sgplot data=Q4a;
 vbox TotalReceptions / category=FlatType;
 footnote1 "The value distribution of the number of Reception between the semi-detached house and terraced house are identical."; 
 footnote2 "But terraced house has a lower median and a higher outlier than semi-detached house. ";
 title "Q4:Value distribution of the number of Reception between the semi-detached house and terraced house";
 run;

/*Q5 The property that contains the second most turnover*/
Proc sgplot data=DATA.EA4887;
	title "Q5:Property that contains the second most turnover";
	vbar FlatType / response= price categoryorder=respasc datalabel;
	footnote "According to the bar chart from Q5, the property that contains the second most turnover is terraced house.";
run;

/*Q6 Relationship between the number of bedrooms, the number of bathrooms and the average price of a different property*/
proc sgplot data=DATA.EA4887; 
title "Q6:Relationship between the number of bedrooms and the number of bathrooms";

	reg X=TotalBaths Y=TotalBeds  ;

	footnote1 "Number of bedrooms and the number of bathrooms have a positive relationship.";
	footnote2 "It is concluded that the number of bedrooms increases as the number of bathrooms increase, and vice versa. ";
run;

proc sgplot data=price; 
title "Q6:Relationship between the average price of different property";

	scatter X=FlatType Y=avgprice;  

	footnote "There is no relationship between the average price and property.";
run;
