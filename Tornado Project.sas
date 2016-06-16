


*STATISTICAL PROGRAMMING PROJECT

TITLE "TORNADOES"



NAME- ROHITH SHANKAR

ID-   1717840       

DATE- 5/4/16      









*PART 1*********;





*Contents procedure;

proc contents data=week11.tornadoall_2014;

run;

*Creating new table called tornadoes;

data week11.tornados;

	set week11.tornadoall_2014;

run;

title "Number of Tornados by strength";

title2"using tabulate";



**CREATE TOTAL using tabulate;

proc tabulate data=week11.tornadoall_2014;

	class fujita;

	table fujita*N=' 'ALL*N=' ';

run;

title2"Using proc Freq of Fujita";

Proc freq data=week11.tornadoall_2014;

	table fujita;

run;

title2"use proc means to find fatalities by fujita";

proc means data=week11.tornadoall_2014 N;

	var fatalities;

	class fujita;

run;

title2"Using report to find fatalities by fujita and also grouping and summarizing";

proc report data=week11.tornadoall_2014;

	column fujita (N SUM),fatalities;

	define fujita/GROUP;

	rbreak after/summarize;

run;

*Creating new table tornados with a new column month;

data week11.tornados;

	set week11.tornadoall_2014;

	month=month(date);

run;



*Sorting table by month;

Proc Sort data=week11.tornados;

	by month;

Run;

	title2 "Using Proc Means";

**MaxDec= max decimal points**

******************************	;

Proc Means data=week11.tornados N sum nonobs maxdec=0;

	var fatalities;

Run;

***

**Add Class Statment;

**To find the Per month total injuries and fatalities

*******************************;

Proc Means data=week11.tornados N sum nonobs maxdec=0;

	var fatalities injuries;

	class month;

Run;

	title2 "Using Proc Tabulate";

**1 Dimensional**

*************************	;

Proc Tabulate data=week11.tornados format=comma8.0;

	class fujita month;

	var fatalities;

	table month all;

Run;

	title2 "Using Proc Tabulate";

**2 Dimensional**

	Fatalities in every month during the different periods for Fujita;

Proc Tabulate data=week11.tornados format=comma8.0;

	class fujita month;

	var fatalities;

	table month, fujita all;

Run;

	title2 "Using Proc Tabulate";

**3 Dimensional**

	Title"Fatalities in every month during the different periods for Fujita;

Proc Tabulate data=week11.tornados format=comma8.0;

	class fujita month;

	var fatalities;

	table month, fujita, all;

Run;

***To plot Frequency;

Title"Frequency procedure and plot of Fatalities";

Proc Freq data=week11.tornados;

	table month /PLOTS=FREQPLOT;

run;

*To summarize in months and also displaying the output in moncount

*************************;

title"Report on the fatalities and grouping them ";

Proc Report data=week11.tornados out=week11.moncount;

	column month (N SUM), fatalities;

	define month /GROUP;

	rbreak after/summarize;



Run;



*********Rename and labeling************

Counting the no of fatalities per month***********************;

Title" No of fatalities in months";

Data week11.monC (Rename=(_C2_=COUNT));

	set week11.moncount;

	where month>=1;

	label _C2_=tornado count*;

	drop _C3_ _Break_;

run;

*To arrange the same in descending order*;

Proc Sort data=week11.monC;

	by descending count;

run;

**Different Months*********

Creating format to display the months in detail;



Proc format ;

	value Monthfmt

	1='January'

	2='Feburary'

	3='March'

	4='April'

	5='May'

	6='June'

	7='July'

	8='August'

	9='Septmeber'

	10='October'

	11='November'

	12='December';

Run;



***Months with most tornados************

***************************;

title "Month with Most Tornadoes";

proc Report data=week11.monc;

	column month count;

	define month/display ;

	define count/format=comma7.0;

	format month monthfmt.;

run;







*PART 2

********************************************************************************************************************************;

*Creating new table called Tornado12;



Data week11.TORNADO12;

	set week11.tornadoall_2014;

	Tmonth=month(date);

	tdate=day(date);

	tyear=year(date);

	Bspring=mdy(3,20,tyear);

	espring=mdy(6,19,tyear);

	Bsummer=mdy(6,20,tyear);

	Esummer=mdy(9,21,tyear);

	Bfall=Esummer+1;

	Efall=mdy(12,20,tyear);

	Bwinter=Efall+1;

	Ewinter=Bspring-1;

	if date >=bspring and date <=espring then season=1;

		else if date>=bsummer and date<=Esummer then season=2;

			else if date>=bfall and date<=efall then season=3;

				else  season=4;

    Thour=hour(time);

	if thour >=22 or thour <4 then period=1;

		else if thour>=4 and thour<10 then period=2;

			else if thour>=10 and thour<16 then period=3;

				else  period=4;

	

	drop bspring espring bsummer bfall efall bwinter ewinter tdate tyear thour;

run;



*which month has tornadoes more;

Title"Frequescy prcoedure to find fatalities in every month";

proc freq data=week11.tornado12;

	table tmonth;

	format tmonth monthfmt.;

run;

*Creating a season format;

proc format;

	value seasonfmt

	1='Spring'

	2='Summer'

	3='Fall'

	4='Winter';

run;



Title"Frequency of death by month and season";

	*which season and month has death by tornado;

proc freq data=week11.tornado12;

	table tmonth season;

	format season seasonfmt.;

	format tmonth monthfmt.;

run;





Title "Number of death/fatalities by weight";

proc freq data=week11.tornado12;

	table tmonth season;

	format season seasonfmt.;

	format tmonth monthfmt.;

	weight fatalities;

run;



Title" Number of fatalities in season and month by fujita";

proc freq data=week11.tornado12;

	table Season* Fujita;

	format Season seasonfmt.;

run;



proc freq data=week11.tornado12;

	table season *fujita /nocum chisq nofreq nopercent;

	format season seasonfmt.;

run;

*Creating a format for representing the period";

proc format;

	value periodfmt

	1='period 1'

	2='period 2'

	3='period 3'

	4='period 4';

run;

*Using the periodfmt;

Title"Frequency procedure of no of fatalities in season/month";

proc freq data=week11.tornado12;

	table period* season;

	format Season seasonfmt. ;

	format period periodfmt.;

run;

*Sorting the no of fatalities in descending order and putting the output in sorted;

proc sort data=week11.tornado12 out=sorted ;

    by descending fatalities;

run;



title'No of deaths by state in descending order';

proc freq data=week11.tornado12 order=freq;

	table  state1/ nocum nopercent;

	weight fatalities;

run;





*****   PART 3      **********************************;

*adding tweekday to get reports on fatalities on days;

Data week11.TORNADO13;

	set week11.tornadoall_2014;

	Tmonth=month(date);

	tdate=day(date);

	tweekday=weekday(date);

	tyear=year(date);

	Bspring=mdy(3,20,tyear);

	espring=mdy(6,19,tyear);

	Bsummer=mdy(6,20,tyear);

	Esummer=mdy(9,21,tyear);

	Bfall=Esummer+1;

	Efall=mdy(12,20,tyear);

	Bwinter=Efall+1;

	Ewinter=Bspring-1;

	if date >=bspring and date <=espring then season=1;

		else if date>=bsummer and date<=Esummer then season=2;

			else if date>=bfall and date<=efall then season=3;

				else  season=4;

    Thour=hour(time);

	if thour >=22 or thour <4 then period=1;

		else if thour>=4 and thour<10 then period=2;

			else if thour>=10 and thour<16 then period=3;

				else  period=4;

	

	drop bspring espring bsummer bfall efall bwinter ewinter tdate tyear thour;

run;

*Creating a format for the days in a week;

proc format;

value weekdayfmt

	1='Sunday'

	2='Monday'

	3='Tuesday'

	4='Wednesday'

	5='Thursday'

	6='Friday'

	7='Saturday';

run;

Title"Frequency procedure to get deviations of fatalities in days, month and season";

proc freq data=week11.tornado13;

	table tmonth season tweekday/chisq;

	format season seasonfmt.;

	format tmonth monthfmt.;

	format tweekday weekdayfmt.;

	weight fatalities;

run;

*Sorting and also getting the output in ftornado;

proc sort data=week11.tornado11 out=ftornado ;

    by descending fatalities;

run;

*Creating a new table top10 and sepcifying the condition to delete anything greater than 10;

data top10;

	set ftornado;

	if _N_>10 then delete;

run;

title"fujita's fatalities and injuries by state";

proc report data=top10;

	column date state1 time fujita fatalities injuries;

	define date /display 'date';

	define state1 /"state";

run;



title'sgplot for no of fatalities in days';

Proc SGPLOT data=week11.tornado13;

	series X=Tweekday Y=fatalities/markers;

	format tweekday weekdayfmt.;

run;







title'vbox plot for no of fatalities in month';

Proc SGPLOT data=week11.tornado13;

	series X=Tmonth Y=fatalities/markers;

	format tmonth monthfmt.;

run;



ods Graphics on;

title'vbox plot for number of fatalities on weekdays';

proc SGPLOT data=week11.tornado13;

	vbox fatalities/category=tweekday;

	format tweekday weekdayfmt.;

run;





*BAR CHARTS;

title'Bar chart for fatalities by month';

proc SGPLOT data=week11.tornado13;

	vbar tmonth/response=fatalities;

	format tmonth monthfmt.;

run;

title"Bar chart for fatalities in weekdays";

proc SGPLOT data=week11.tornado13;

	vbar tweekday/response=fatalities;

	format tweekday weekdayfmt.;

run;



title'Bar chart Injuries in weekdays';

proc SGPLOT data=week11.tornado13;

    vbar tweekday/response=injuries;

	format tweekday weekdayfmt.;

run;



title'Barchart comparing fatalities and injuries on weekdays';

proc SGPLOT data=week11.tornado13;

yaxis label="frequency" min=0;

	vbar tweekday/response=fatalities;

    vbar tweekday/response=injuries

	barwidth=0.5

	transparency=0.2;

	format tweekday weekdayfmt.;

run;





*PIE CHARTS;

title' pie chart for no of fatalities on months';

proc gchart data=week11.tornado13;

	pie tmonth/ sumvar=fatalities;

	format tmonth monthfmt.;

run;

Title'3D pie chart for no of fatalities on weekdays';

proc gchart data=week11.tornado13;

	pie3d tweekday/ sumvar=fatalities;

	format tweekday weekdayfmt.;

run;
tornado.txt
Open with
2 of 2 items
Birthday.txttornado.txtDisplaying tornado.txt.