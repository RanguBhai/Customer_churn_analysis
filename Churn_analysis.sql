create database churn_analysis;
use churn_analysis;

 create table Customer_churn_data
 (customerID varchar(30),
 gender	varchar(10),
 SeniorCitizen varchar(5),
 Partner varchar(5),
 Dependents varchar(5),
 tenure decimal,
 PhoneService varchar(30),
 MultipleLines varchar(30),
 InternetService varchar(30),
 OnlineSecurity	varchar(30),
 OnlineBackup varchar(30),
 DeviceProtection varchar(30),
 TechSupport varchar(30),
 StreamingTV varchar(30),
 StreamingMovies varchar(30),
 Contract	varchar(20),
 PaperlessBilling varchar(5),
 PaymentMethod varchar(30),
 MonthlyCharges float,
 TotalCharges float,
 numAdminTickets decimal,
 numTechTickets	decimal,
 Churn varchar(5)
 );

-- table details 
select * from Customer_churn_data; 

 -- total customers
select count(*) as total_customer from Customer_churn_data;

 -- total customer churned
select count(*) as total_churned_customer,
round(count(*)*100/(select count(*) from Customer_churn_data),2) as percentage_of_customer_churned
from Customer_churn_data
where churn ='yes';

-- total yearly charges
select round(sum(TotalCharges),2) as Yearly_charges
from Customer_churn_data;
 
 -- percentage of phone service customer churned
select PhoneService, count(*) as churned_customer,
round(count(*)*100/(select count(*) from Customer_churn_data where churn = 'yes'),2) as perentage_churned_customer
from customer_churn_data
where churn = 'yes'
group by PhoneService;

-- percentage of multiple lines customer churned
select MultipleLines, count(*),
round(count(*)*100/(select count(*) from Customer_churn_data where churn = 'yes' and MultipleLines <> 'No phone service'),2) as percentage_of_customer_churned_by_multiple_lines
from Customer_churn_data
where MultipleLines = 'yes' and churn = 'yes';

-- percentage of streaming TV customer churned
select StreamingTV, count(*) as churned_customer,
round(count(*)*100/(select count(*) from Customer_churn_data where churn = 'yes'),2) as perentage_churned_customer
from customer_churn_data
where churn = 'yes'
group by StreamingTV;

-- percentage of streaming Movies customer churned
select StreamingMovies, count(*) as churned_customer,
round(count(*)*100/(select count(*) from Customer_churn_data where churn = 'yes'),2) as perentage_churned_customer
from customer_churn_data
where churn = 'yes'
group by StreamingMovies;

-- percentage of Device Protection customer churned
select DeviceProtection, count(*) as churned_customer,
round(count(*)*100/(select count(*) from Customer_churn_data where churn = 'yes'),2) as perentage_churned_customer
from customer_churn_data
where churn = 'yes'
group by DeviceProtection;

-- percentage of Online Backup customer churned
select OnlineBackup, count(*) as churned_customer,
round(count(*)*100/(select count(*) from Customer_churn_data where churn = 'yes'),2) as perentage_churned_customer
from customer_churn_data
where churn = 'yes'
group by OnlineBackup;

-- percentage of Online Security customer churned
select OnlineSecurity, count(*) as churned_customer,
round(count(*)*100/(select count(*) from Customer_churn_data where churn = 'yes'),2) as perentage_churned_customer
from customer_churn_data
where churn = 'yes'
group by OnlineSecurity;

-- percentage of TechSupport customer churned
select TechSupport, count(*) as churned_customer,
round(count(*)*100/(select count(*) from Customer_churn_data where churn = 'yes'),2) as perentage_churned_customer
from customer_churn_data
where churn = 'yes'
group by TechSupport;

-- percentage of senior_citizens churned
select SeniorCitizen, count(*) as churned_customer,
round(count(*)*100/(select count(*) from Customer_churn_data where churn = 'yes'),2) as perentage_churned_customer
from customer_churn_data
where churn = 'yes'
group by SeniorCitizen;
 
 -- total_churn_ratio
select round((select count(*) from Customer_churn_data
where churn= 'yes')*100
/
(select count(*) from Customer_churn_data),2) as total_churn_ratio;

-- percentage_churned_customer_by_gender
select gender, count(*) churned_customer_by_gender,
round(count(*)*100/(select count(*) from Customer_churn_data where churn = 'yes'),2) as percentage_churned_customer_by_gender
from Customer_churn_data
where churn ='yes'
group by gender;

-- dependents_churned_ratio
select Dependents, count(*) as churned_customer,
round(count(*)*100/(select count(*) from Customer_churn_data where churn = 'yes'),2) as perentage_churned_customer
from customer_churn_data
where churn = 'yes'
group by Dependents;

-- number_of_admin_tickets
select sum(numAdminTickets) as number_of_admin_tickets from Customer_churn_data
where churn = 'yes';

-- number_of_tech_tickets
select sum(numTechTickets) as number_of_tech_tickets from Customer_churn_data
where churn = 'yes';

-- churned_customers_by_internet_service_type
select InternetService ,count(*) as churned_customers ,
round(count(*)*100/(select count(*) from Customer_churn_data where churn = 'yes'),2) as per_churned_customer_by_internet_service_type 
from Customer_churn_data
where churn ='yes'
group by internetservice;

-- churned_customer_by_tenure
select case 
when tenure <=12 then "< 1 year"
when tenure <=24 then "< 2 years"
when tenure <=36 then "< 3 years"
when tenure <=48 then "< 4 years"
when tenure <=60 then "< 5 years"
else "< 6 years"
end as tenure_in_years, count(churn),
round(count(*)*100/(select count(*) from Customer_churn_data where churn = 'yes'),2) as per_churned_customer_by_tenure 
from Customer_churn_data
where churn ='yes'
group by tenure_in_years
order by tenure_in_years;

-- churned_customer_by_contract_type 
select contract, count(*) as churned_customer,
round(count(*)*100/(select count(*) from Customer_churn_data where churn = 'yes'),2) as per_churned_customer_by_contract_type 
from Customer_churn_data
where churn ='yes'
group by contract
order by contract;

-- churned_customer_by_payment_type
select PaymentMethod, count(*) as churned_customer,
round(count(*)*100/(select count(*) from Customer_churn_data where churn = 'yes'),2) as per_churned_customer_by_payment_type 
from Customer_churn_data
where churn ='yes'
group by PaymentMethod
order by per_churned_customer_by_payment_type desc;

-- churned cusdtomer by contract type and payment method
SELECT Contract, PaymentMethod, COUNT(*) AS churned_customers,
round(count(*)*100/(select count(*) from Customer_churn_data where churn = 'yes'),2) as churned_customer_percentage
FROM Customer_churn_data
WHERE churn = 'yes'
GROUP BY Contract, PaymentMethod
ORDER BY churned_customers DESC;

-- sum of monthly charges ,average monthly charges and sum of total charges average total charges of churned_customer
select round(sum(MonthlyCharges),2) as sum_of_monthly_charges, round(avg(MonthlyCharges),2) as avg_monthly_charges,
round(sum(TotalCharges),2) as sum_of_total_charges, round(avg(TotalCharges),2) as avg_total_charges 
from Customer_churn_data
where churn ='yes';

-- churned_customer_by_paperless_billing_type
select PaperlessBilling, count(*) as churned_customer,
round(count(*)*100/(select count(*) from Customer_churn_data where churn = 'yes'),2) as per_churned_customer_by_paperless_billing
from Customer_churn_data
where churn ='yes'
group by PaperlessBilling;

-- churned_customer_by_Partner_type
select Partner, count(*) as churned_customer,
round(count(*)*100/(select count(*) from Customer_churn_data where churn = 'yes'),2) as per_churned_customer_by_paperless_billing
from Customer_churn_data
where churn ='yes' and partner ='yes'
group by Partner;

-- dependents_churned_customer
select Dependents, count(*) as churned_customer,
round(count(*)*100/(select count(*) from Customer_churn_data where churn = 'yes'),2) as per_churned_customer_by_dependents
from Customer_churn_data
where churn ='yes' and Dependents ='yes'
group by Dependents;

-- customer churn based on average tenure period
select churn, round(avg(tenure),2) as avg_tenure 
from customer_churn_data
group by churn;

-- customer churn based on monthly charges segment
select case
when MonthlyCharges < 30 then "< 30$"
when MonthlyCharges between 30 and 60 then "30-60$"
when MonthlyCharges between 60 and 90 then "60-90$"
else ">90$" end as monthly_charges_segment,
count(*) as churned_customer,
round(count(*)*100/(select count(*) from Customer_churn_data where churn = 'yes'),2) as churned_customer_percentage
from customer_churn_data
where churn = 'yes'
group by monthly_charges_segment
order by churned_customer desc;

-- churned customer based on pay type
select case
when PaymentMethod like "%auto%" then "autopay"
else "manualpay" end as pay_type,
count(*) as churned_customer
from customer_churn_data
where churn ='yes'
group by pay_type;

-- customer churn based on service count
SELECT 
  service_count,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(
    100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS churn_rate_percentage
FROM (
  SELECT customerID,
    (
      (OnlineSecurity = 'Yes') +
      (OnlineBackup = 'Yes') +
      (DeviceProtection = 'Yes') +
      (TechSupport = 'Yes') +
      (StreamingTV = 'Yes') +
      (StreamingMovies = 'Yes')
    ) AS service_count,
	churn
  FROM Customer_churn_data
) AS service_count
GROUP BY service_count
ORDER BY service_count;  

-- customer churn life time value based on tenure 
select case 
when tenure <=12 then "< 1 year"
when tenure <=24 then "< 2 years"
when tenure <=36 then "< 3 years"
when tenure <=48 then "< 4 years"
when tenure <=60 then "< 5 years"
else "< 6 years"
end as tenure_in_years, 
round(avg(TotalCharges),2) as avg_lifetime_value
from Customer_churn_data
where churn ='yes'
group by tenure_in_years
order by tenure_in_years;

-- customer churn based on internet service and streaming tv
SELECT InternetService, StreamingTV, count(*) as total_customers,
round(sum(case when churn = 'yes' then 1 else 0 end ),2) AS churned_customers,
round(100.0 * sum(case when churn = 'yes' then 1 else 0 end)  / COUNT(*),2) AS churn_rate_percentage
FROM Customer_churn_data 
GROUP BY InternetService, StreamingTV
ORDER BY InternetService;

-- customer churn based on tenure range and contract type
SELECT 
  CASE 
    WHEN tenure <= 12 THEN '< 1 year'
    WHEN tenure <= 24 THEN '< 2 years'
    WHEN tenure <= 36 THEN '< 3 years'
    WHEN tenure <= 48 THEN '< 4 years'
    WHEN tenure <= 60 THEN '< 5 years'
    ELSE '< 6 years'
  END AS tenure_range,
  Contract,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(
    100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS churn_rate_percentage
FROM Customer_churn_data
GROUP BY tenure_range, Contract
ORDER BY tenure_range, Contract;

-- customer churn based on  tickets raised
with ticket as (select customerid, NTILE(4) OVER (ORDER BY (numAdminTickets + numTechTickets) DESC) AS ticket_group,
churn from customer_churn_data)
select ticket_group,count(*) as total_customer,
sum(case when churn ='yes' then 1 else 0 end) as churned_customer,
round(sum(case when churn ='yes' then 1 else 0 end)*100/count(*),2) as churned_percentage 
from ticket
group by ticket_group;
