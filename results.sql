with calculating_stats as (
    select  CustomerID, datediff(day,max(Purchase_Date),'2022-09-01') as Recency,
            count(distinct(Purchase_Date)) as Frequency ,
            sum(GMV) as Monetary
    from Customer_Transaction
    where CustomerID != 0
    group by CustomerID ),
    RFM as (
         select * , case when Recency >= 92 then '1'
                         when Recency < 92 and Recency >= 62 then '2'
                         when Recency < 62 and Recency  >= 31 then '3'
                         else '4' end as R ,
                case when Frequency >=1  and Frequency < 2 then '1'
                     when Frequency >= 2 and Frequency < 3 then '2'
                     when Frequency >= 3 and Frequency < 4 then '3'
                     else '4' end as F ,
                case when Monetary >= 75000 and Monetary < 126000 then '1'
                     when Monetary >= 126000 and Monetary < 240000 then '2'
                     when Monetary >= 240000 and Monetary < 300000 then '3'
                     else '4' end as M
         from calculating_stats)
select * , (R+F+M) as RFM from RFM

