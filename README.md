# Wolrd Layoffs Analysis and Data Cleaning Project



## Tables of Contents: 
- [Project Overview](#project-overview)  
- [Tools Used](#tools-used)  
- [Data Sources](#data-sources)  
- [Data Cleaning/Preparation](#data-cleaningpreparation)  
- [Key Business Questions Answered](#key-business-questions-answered)  
- [Project Files](#project-files)  
- [How to Use](#how-to-use)  
- [Insights & Findings](#insights--findings)  
- [Recommendations](#recommendations)  
- [Conclusion](#conclusion)
  
### Project Overview
The World Layoffs Data Analysis project examines global layoff trends across industries, analyzing factors such as total layoffs, percentage of workforce reductions, company stages, and funding status. The goal is to identify patterns, economic impacts, and potential industry vulnerabilities to provide insights into workforce stability and corporate downsizing trends.

### Tools Used
- MySQL

### Data Sources
The "layoffs.csv" file likely contains information about layoffs across various companies, including details such as the company name, number of employees laid off, department, location, and the date of the layoff. This dataset may also include information on reasons for the layoffs, industry sectors affected, and other related factors like company performance or restructuring events.


### Data Cleaning/Preparation
- In the initial data preparation phase, we performed the following tasks:

1. Imported data into the MySQL database and conducted an inspection.
2. Removed duplicates, handles missing values and handling Blank values
3. Corrected spelling errors, typos, and inconsistencies.
4. Assigned appropriate data types to columns (e.g., date)
5. Removing col and rows that are not necessaty for analysis

### Key Business Questions Answered
- 1. Maximum laid off in a day
- 2. Where 100% of employees were laid off
- 3. Total laid off by comapnies
- 4. Get date range
- 5. Total laid off by industry
- 6. Total laid off by country
- 7. Total laid off by year
- 8. Total laid off by stage
- 9. Total laid off by MONTH
- 10. Total laid off by companies by year
- 11. Maximum laid off by a company in a year
- 12. Ranking companies by Maximum laid off by a in a year

### Project Files
- 📊 "world_layoffs" (Database File) - Contains all data.
- 📝 Problem Statement (Word File) - Outlines the business questions and objectives.

 ### How to Use
1. Review the Problem Statement PDF to understand the key objectives.
2. Use the Readme file to get answers


### Insights & Findings
1. Maximum laid off in a day?
````sql
select max(total_laid_off),max(percentage_laid_off)
from layoffs_staging2
````
**Results:**
Max layoffs|
---------------------|
12000    |

2. Where 100% of employees were laid off?
````sql
select *
from layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off desc
````
**Results:**
- Gets us records of companies were all employees were laid off

3. Total laid off by comapnies?
````sql
select company,sum(total_laid_off) as total_lay_off_by_company
from layoffs_staging2
group by company
order by total_lay_off_by_company desc
````
**Results:**
- Gets us total layoffs of each company

4. Get date range?
````sql
select min(date) as start_date ,max(date) as end_date
from layoffs_staging2
````
**Results:**
 start_date   | end_date | 
-----------|------------|
2020-03-11  | 2023-03-06         | 


5. Total laid off by industry?
````sql
select industry,sum(total_laid_off) as total_lay_off_by_company
from layoffs_staging2
group by industry
order by total_lay_off_by_company desc
````
**Results:**
 Company       | Number of Layoffs |
---------------|-------------------|
 Consumer      | 45182             |
 Retail        | 43613             |
 Other         | 36289             |
 Transportation| 33748             |
 Finance       | 28344             |
 Healthcare    | 25953             |
 Food          | 22855             |
 Real Estate   | 17565             |
 Travel        | 17159             |
 Hardware      | 13828             |
 Education     | 13338             |
 Sales         | 13216             |
 Crypto        | 10693             |
 Marketing     | 10258             |
 Fitness       | 8748              |
 Security      | 5979              |
 Infrastructure| 5785              |
 Media         | 5234              |
 Data          | 5135              |
 Logistics     | 4026              |
 Construction  | 3863              |
 Support       | 3523              |
 HR            | 2783              |
 Recruiting    | 2775              |
 Product       | 1233              |
 Legal         | 836               |
 Energy        | 802               |
 Aerospace     | 661               |
 Fin-Tech      | 215               |
 Manufacturing | 20                |

6. Total laid off by country?
````sql
select country,sum(total_laid_off) as total_lay_off_by_company
from layoffs_staging2
group by country
order by total_lay_off_by_company desc
````
**Results:**
| Country             | Number of Layoffs |
|---------------------|-------------------|
| United States       | 256559            |
| India               | 35993             |
| Netherlands         | 17220             |
| Sweden              | 11264             |
| Brazil              | 10391             |
| Germany             | 8701              |
| United Kingdom      | 6398              |
| Canada              | 6319              |
| Singapore           | 5995              |
| China               | 5905              |
| Israel              | 3638              |
| Indonesia           | 3521              |
| Australia           | 2324              |
| Nigeria             | 1882              |
| United Arab Emirates| 995               |
| France              | 915               |
| Hong Kong           | 730               |
| Austria             | 570               |
| Russia              | 400               |
| Kenya               | 349               |
| Estonia             | 333               |
| Argentina           | 323               |
| Senegal             | 300               |
| Mexico              | 270               |
| Ireland             | 257               |
| Finland             | 250               |
| Spain               | 250               |
| Denmark             | 240               |
| Myanmar             | 200               |
| Norway              | 140               |
| Colombia            | 130               |
| Bulgaria            | 120               |
| Portugal            | 115               |
| Malaysia            | 100               |
| Japan               | 85                |
| Romania             | 80                |
| Seychelles          | 75                |
| Switzerland         | 62                |
| Lithuania           | 60                |
| Thailand            | 55                |
| Luxembourg          | 45                |
| New Zealand         | 45                |
| Chile               | 30                |
| Poland              | 25                |
| Pakistan            | -                 |
| Hungary             | -                 |
| Italy               | -                 |
| Turkey              | -                 |
| South Korea         | -                 |
| Vietnam             | -                 |
| Egypt               | -                 |

7. Total laid off by year?
````sql
select YEAR(date),sum(total_laid_off) as total_lay_off_by_company
from layoffs_staging2
group by YEAR(date)
order by total_lay_off_by_company desc
````
**Results:**
| Year   | Number of Layoffs |
|--------|-------------------|
| 2022   | 160661            |
| 2023   | 125677            |
| 2020   | 80998             |
| 2021   | 15823             |
| NULL   | 500               |

8. Total laid off by stage?
````sql
select stage,sum(total_laid_off) as total_lay_off_by_company
from layoffs_staging2
group by stage
order by total_lay_off_by_company desc
````
**Results:**
| Funding Stage    | Number of Layoffs |
|------------------|-------------------|
| Post-IPO         | 204132            |
| Unknown          | 40716             |
| Acquired         | 27576             |
| Series C         | 20017             |
| Series D         | 19225             |
| Series B         | 15311             |
| Series E         | 12697             |
| Series F         | 9932              |
| Private Equity   | 7957              |
| Series H         | 7244              |
| Series A         | 5678              |
| Series G         | 3697              |
| Series J         | 3570              |
| Series I         | 2855              |
| Seed             | 1636              |
| Subsidiary       | 1094              |
| NULL             | 322               |


9. Total laid off by MONTH?
````sql
select SUBSTRING(date,1,7) AS date_format,sum(total_laid_off) as total_lay_off_by_company
from layoffs_staging2
where `date` is not null
group by date_format WITH ROLLUP
order by date_format 
````
 **Results:**
| Date       | Number of Layoffs |
|------------|-------------------|
| NULL       | 383159            |
| 2020-03    | 9628              |
| 2020-04    | 26710             |
| 2020-05    | 25804             |
| 2020-06    | 7627              |
| 2020-07    | 7112              |
| 2020-08    | 1969              |
| 2020-09    | 609               |
| 2020-10    | 450               |
| 2020-11    | 237               |
| 2020-12    | 852               |
| 2021-01    | 6813              |
| 2021-02    | 868               |
| 2021-03    | 47                |
| 2021-04    | 261               |
| 2021-06    | 2434              |
| 2021-07    | 80                |
| 2021-08    | 1867              |
| 2021-09    | 161               |
| 2021-10    | 22                |
| 2021-11    | 2070              |
| 2021-12    | 1200              |
| 2022-01    | 510               |
| 2022-02    | 3685              |
| 2022-03    | 5714              |
| 2022-04    | 4128              |
| 2022-05    | 12885             |
| 2022-06    | 17394             |
| 2022-07    | 16223             |
| 2022-08    | 13055             |
| 2022-09    | 5881              |
| 2022-10    | 17406             |
| 2022-11    | 53451             |
| 2022-12    | 10329             |
| 2023-01    | 84714             |
| 2023-02    | 36493             |
| 2023-03    | 4470              |

     
10. Total laid off by companies by year?
````sql
select company,YEAR(`date`) AS year,sum(total_laid_off) as total_lay_off_by_company
from layoffs_staging2
group by company, year
order by company
````
 **Results:**
| Company                | Year | Layoffs |
|------------------------|------|---------|
| &Open                  | 2022 | 9       |
| #Paid                  | 2023 | 19      |
| 100 Thieves            | 2022 | 12      |
| 10X Genomics           | 2022 | 100     |
| 1stdibs                | 2020 | 70      |
| 2TM                    | 2022 | 190     |
| 2U                     | 2022 |         |
| 54gene                 | 2022 | 95      |
| 5B Solar               | 2022 |         |
| 6sense                 | 2022 | 150     |
| 80 Acres Farms         | 2023 |         |
| 8x8                    | 2022 | 200     |
| 8x8                    | 2023 | 155     |
| 98point6               | 2022 |         |
| 99                     | 2022 | 75      |
| Abra                   | 2022 | 12      |
| Absci                  | 2022 | 40      |
| Acast                  | 2022 | 70      |
| Acko                   | 2020 | 45      |
| Acorns                 | 2020 | 50      |
| Actifio                | 2020 | 54      |
| ActiveCampaign         | 2022 |         |
| Ada                    | 2022 | 78      |
| Ada Health             | 2022 | 50      |
| Ada Support            | 2020 | 36      |
| Adaptive Biotechnologies | 2022 | 100    |
| Addepar                | 2023 | 20      |
| Adobe                  | 2022 | 100     |
| AdRoll                 | 2020 | 210     |
| Advata                 | 2022 | 32      |
| Adwerx                 | 2022 | 40      |
| Affirm                 | 2022 |         |
| Affirm                 | 2023 | 500     |
| Afterverse             | 2022 | 60      |
| Agoda                  | 2020 | 1500    |
| Ahead                  | 2022 | 44      |
| Air                    | 2020 |         |
| Airbnb                 | 2020 | 1900    |
| Airbnb                 | 2023 | 30      |
| Airlift                | 2022 |         |
| Airtable               | 2022 | 254     |
| Airtame                | 2022 | 15      |
| Airtime                | 2022 | 30      |
| Airy Rooms             | 2020 |         |
| Aiven                  | 2023 |         |
| Ajaib                  | 2022 | 67      |
| Akili Labs             | 2023 | 46      |
| Akulaku                | 2020 | 100     |
| AlayaCare              | 2022 | 80      |
| Albert                 | 2022 | 20      |

- so on

11. Maximum laid off by a company in a year?
````sql
select company,YEAR(`date`) AS year,MAX(total_laid_off) as max_lay_off_by_company
from layoffs_staging2
group by company, year
order by max_lay_off_by_company DESC
````
**Results:**
| Company               | Year | Layoffs |
|-----------------------|------|---------|
| Google                | 2023 | 12000   |
| Meta                  | 2022 | 11000   |
| Amazon                | 2022 | 10000   |
| Microsoft             | 2023 | 10000   |
| Ericsson              | 2023 | 8500    |
| Amazon                | 2023 | 8000    |
| Salesforce            | 2023 | 8000    |
| Dell                  | 2023 | 6650    |
| Philips               | 2023 | 6000    |
| Booking.com           | 2020 | 4375    |
| Cisco                 | 2022 | 4100    |
| Philips               | 2022 | 4000    |
| IBM                   | 2023 | 3900    |
| Twitter               | 2022 | 3700    |
| Uber                  | 2020 | 3700    |
| Better.com            | 2022 | 3000    |
| SAP                   | 2023 | 3000    |
| Groupon               | 2020 | 2800    |
| Peloton               | 2022 | 2800    |
| Byju's                | 2022 | 2500    |
| Carvana               | 2022 | 2500    |
| Katerra               | 2021 | 2434    |
| Crypto.com            | 2022 | 2000    |
| PayPal                | 2023 | 2000    |
| Zillow                | 2021 | 2000    |
| Airbnb                | 2020 | 1900    |
| Instacart             | 2021 | 1877    |
| Bytedance             | 2021 | 1800    |
| WhiteHat Jr           | 2021 | 1800    |
| Wayfair               | 2023 | 1750    |
| Yahoo                 | 2023 | 1600    |
| Agoda                 | 2020 | 1500    |
| Byju's                | 2023 | 1500    |
| Gopuff                | 2022 | 1500    |
| OLX Group             | 2023 | 1500    |
| PaisaBazaar           | 2020 | 1500    |
| PuduTech              | 2022 | 1500    |
| Twilio                | 2023 | 1500    |
| Ola                   | 2020 | 1400    |
| Stitch Fix            | 2020 | 1400    |
| GoTo Group            | 2022 | 1300    |
| Lam Research          | 2023 | 1300    |
| Stone                 | 2020 | 1300    |
| Toast                 | 2020 | 1300    |
| Vacasa                | 2023 | 1300    |
| Zoom                  | 2023 | 1300    |
| Snap                  | 2022 | 1280    |
| DoorDash              | 2022 | 1250    |
| Capital One           | 2023 | 1100    |
| Coinbase              | 2022 | 1100    |
| Kraken                | 2022 | 1100    |
| Swiggy                | 2020 | 1100    |
| Butler Hospitality    | 2022 | 1000    |
| Invitae               | 2022 | 1000    |
| Magic Leap            | 2020 | 1000    |
| Ola                   | 2022 | 1000    |
| Salesforce            | 2022 | 1000    |
| Salesforce            | 2020 | 1000    |
| Shopify               | 2022 | 1000    |
| Stripe                | 2022 | 1000    |
| Unacademy             | 2022 | 1000    |
| Yelp                  | 2020 | 1000    |
| Lyft                  | 2020 | 982     |
| LinkedIn              | 2020 | 960     |
| NetApp                | 2023 | 960     |
| Coinbase              | 2023 | 950     |
| OneTrust              | 2022 | 950     |
| Better.com            | 2021 | 900     |
| Black Shark           | 2023 | 900     |
| Jumia                 | 2022 | 900     |
| Juul                  | 2020 | 900     |
| TripAdvisor           | 2020 | 900     |
| Wayfair               | 2022 | 870     |
| Redfin                | 2022 | 862     |
| Rivian                | 2022 | 840     |
| Arrival               | 2023 | 800     |
| Curefit               | 2020 | 800     |
| GoHealth              | 2022 | 800     |
| Shutterfly            | 2021 | 800     |
| Twilio                | 2022 | 800     |
| Flywheel Sports       | 2020 | 784     |
| Cazoo                 | 2022 | 750     |
| Reef                  | 2022 | 750     |
| Intuit                | 2020 | 715     |
| Robinhood             | 2022 | 713     |
| Amdocs                | 2023 | 700     |
| Klarna                | 2022 | 700     |
| Lyft                  | 2022 | 700     |
| MindBody              | 2020 | 700     |
| DocuSign              | 2023 | 680     |
| DocuSign              | 2022 | 671     |
| Deliv                 | 2020 | 669     |
| Misfits Market        | 2023 | 649     |
| Flexport              | 2023 | 640     |
| HelloFresh            | 2022 | 611     |
| Bybit                 | 2022 | 600     |
| Cars24                | 2022 | 600     |
| MFine                 | 2022 | 600     |
| Opendoor              | 2020 | 600     |
| OYO                   | 2022 | 600     |
| OYO                   | 2020 | 600     |
| Playtika              | 2022 | 600     |
| Spotify               | 2023 | 600     |
| Opendoor              | 2022 | 550     |
| Gorillas              | 2022 | 540     |
| Careem                | 2020 | 536     |
| GoDaddy               | 2023 | 530     |
| Workday               | 2023 | 525     |
| Zomato                | 2020 | 520     |
| Doma                  | 2022 | 515     |
| Affirm                | 2023 | 500     |
| Atlassian             | 2023 | 500     |
| Avo                   | 2022 | 500     |
| Blackbaud             | 2023 | 500     |
| eBay                  | 2023 | 500     |
| Eventbrite            | 2020 | 500     |
| Groupon               | 2023 | 500     |
| Groupon               | 2022 | 500     |
| HubSpot               | 2023 | 500     |
| Illumina              | 2022 | 500     |
| Infarm                | 2022 | 500     |
| Jump                  | 2020 | 500     |
| Lendingkart           | 2020 | 500     |
| Loggi                 | 2022 | 500     |
| Noom                  | 2022 | 500     |
| PagBank               | 2023 | 500     |
| Paytm                 | 2020 | 500     |
| Sema4                 | 2022 | 500     |
| ShareChat             | 2023 | 500     |
| Thoughtworks          | 2023 | 500     |
| TomTom                | 2022 | 500     |
| WeDoctor              | 2022 | 500     |
| SiriusXM              | 2023 | 475     |

- JUST PASTED TOP FEW RECORDS
  
12. Ranking companies by Maximum laid off by a in a year?
````sql
SELECT company,year,max_lay_off_by_company,RANK() OVER (ORDER BY max_lay_off_by_company DESC) AS ranking
FROM 
(
SELECT company,YEAR(date) AS year,MAX(total_laid_off) AS max_lay_off_by_company
FROM layoffs_staging2
where `date` is not null
GROUP BY company, year
) AS subquery
ORDER BY ranking;

````
**Results:**
- Gets us table which contains answer


### Recommendations
- Maximum Layoffs in a Day: Focus on companies with high daily layoffs (e.g., 12,000) for deeper workforce impact analysis.
- Companies with 100% Employee Layoffs: Investigate the reasons behind total workforce layoffs in specific companies for strategic insights.
- Total Layoffs by Company/Industry/Country/Year/Stage: Analyze trends by country, industry, and year to predict future layoffs and assess market stability.
- Laid Off by Month/Company Year: Track peak layoff periods (like 2022) to prepare for workforce shifts in similar economic conditions.
- Recommendations: Monitor heavily affected sectors (Consumer, Retail, Tech) and countries (United States, India) for workforce changes and adjust strategies accordingly.

### Conclusion
The analysis of global layoffs reveals significant patterns in industry and regional impact, with the highest layoffs occurring in sectors like tech and consumer goods. By understanding these trends, companies can better prepare for workforce shifts and mitigate the effects of future layoffs through targeted strategies.

### Author
- Prasannagoud Patil

### Email
- Prasannpatil31@gmail.com
