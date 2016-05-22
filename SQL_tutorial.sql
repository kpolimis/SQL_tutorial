use SQL_tutorial;
show tables;
# 
select * from SeattleCrimeIncidents;

select Location from SeattleCrimeIncidents;

select Longitude,Latitude from SeattleCrimeIncidents;

select `Offense Type` from SeattleCrimeIncidents;

select `Offense Type`,`Zone/Beat` from SeattleCrimeIncidents order by `Zone/Beat` ASC;
# select rows for which the Offence Type is equal to `Theft-Bicycle'

select * from SeattleCrimeIncidents 
	where `Offense Type` = 'Theft-Bicycle';

select * from SeattleCrimeIncidents 
	where `Offense Type` <> 'Theft-Bicycle';
    
    
# Check if there are rows with missing locations
select * from SeattleCrimeIncidents
	where location is NULL;


# Finding all rows which contain Offense types which start with Theft
select * from SeattleCrimeIncidents
	where `Offense Type` like 'Theft%';


# Functions    
select count(*) from SeattleCrimeIncidents;

# Applying functions within categories

# count how many offenses are for each Offense Type
select `Offense Type`,count(*) from SeattleCrimeIncidents 
	group by `Offense Type`;
    
# count how many offenses are for each Summarized Offense Description
select `Summarized Offense Description`, count(*) from SeattleCrimeIncidents 
	group by `Summarized Offense Description`;

# create a table of Crime Incidents by Census Tract (rounding and dividing by hundred to match the census tracts in the other data) and order by descending count
select round(`Census Tract 2000`)/100 as CT, count(*) as count from SeattleCrimeIncidents group by `Census Tract 2000` order by count DESC;

# create a table of Population by Census Tract (remove the string Census tract to extract the number of the tract)
select `Total Population, 2010` as population,replace(`Census Tract`,'Census Tract ','') as CT from census;

# create a table of with population and incident number for each census tract
select crimeTable.CT,crimeTable.count,censusTable.population as crime_rate from 
	(select round(`Census Tract 2000`)/100 as CT, count(*) as count from SeattleCrimeIncidents group by `Census Tract 2000`) crimeTable
    left join 
    (select `Total Population, 2010` as population,replace(`Census Tract`,'Census Tract ','') as CT from census) censusTable
    on crimeTable.CT = censusTable.CT;

# create a table with incident per capita rate for each tract and order by the descending rate
select crimeTable.CT,crimeTable.count/censusTable.population as crime_rate from 
	(select round(`Census Tract 2000`)/100 as CT, count(*) as count from SeattleCrimeIncidents group by `Census Tract 2000`) crimeTable
    left join 
    (select `Total Population, 2010` as population,replace(`Census Tract`,'Census Tract ','') as CT from census) censusTable
    on crimeTable.CT = censusTable.CT order by crime_rate desc;
    
# Your turn: 

# find the census tract with highest rate of bike thefts:

# Are there more bike thefts in the summer than the winter months?

# How are drug crimes associated with vacant housing?

# ...

#
    

