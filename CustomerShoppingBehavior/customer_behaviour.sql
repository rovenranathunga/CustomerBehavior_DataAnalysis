--select * from customer limit 20

--Q1. What is the total revenue generated
--by male vs female customers?

--select "Gender", SUM("Purchase_Amount") as "Revenue"
--from customer
--group by "Gender"

--Q2. Which customers used a discount but still spent more than average purchase amount?
--select "Customer_ID", "Purchase_Amount"
--from customer
--where "Discount_Applied" = 'Yes' and "Purchase_Amount" >= (select AVG("Purchase_Amount") from customer)

--Q3. which are the op 5 products with avetrage review ratings?
--select "Item_Purchased", ROUND(AVG("Review_Rating"::numeric),2) as "Average_Product_Rating"
--from customer
--group by "Item_Purchased"
--order by avg("Review_Rating") desc
--limit 5;

--Q4. Compare the average Purchase amounts between Standard and Express Shipping.
--select "Shipping_Type",
--ROUND(AVG("Purchase_Amount"),2)
--from customer
--where "Shipping_Type" in ('Standard', 'Express')
--group by "Shipping_Type"

--Q5.Do subscribed customers customers spend more? Compare average spend and total revenue between subscribers and non subscribers
--select "Subscription_Status",
--COUNT("Customer_ID") as "Total_Customers",
--ROUND(AVG("Purchase_Amount"),2) as "Avg_Spend",
--ROUND(SUM("Purchase_Amount"),2) as "Total_Revenue"
--from customer
--group by "Subscription_Status"
--order by "Total_Revenue", "Avg_Spend" desc;

--Q6. Which 5 products have the highest percentage of purchases with discounts applied?
--select "Item_Purchased",
--ROUND(100*SUM(CASE WHEN "Discount_Applied" = 'Yes' THEN 1 ELSE 0 END)/COUNT(*),2) as "Discount_Rate"
--from customer
--group by "Item_Purchased"
--order by "Discount_Rate" desc
--limit 5;

--Q7. Segment customers into New, Returning, and loyal based on their
--total number of previous purchases, and show count of each segment.
--with "Customer_Type" as (
--select "Customer_ID", "Previous_Purchases",
--CASE
 --WHEN "Previous_Purchases" = 1 THEN 'New'
 --WHEN "Previous_Purchases" BETWEEN 2 AND 10 THEN 'Returning'
 --ELSE 'Loyal'
 --END AS "Customer_Segment"
--from customer
--)

--select "Customer_Segment", count(*) as "Number_Of_Customers"
--from "Customer_Type"
--group by "Customer_Segment"

--Q8. What are the top 3 most purchased products within each category.
--with "Item_Counts" as (
--select "Category",
--"Item_Purchased",
--COUNT("Customer_ID") as "Total_Orders",
--ROW_NUMBER() over(partition by "Category" order by count("Customer_ID") DESC) as "Item_Rank"
--from customer
--group by "Category", "Item_Purchased"
--)
--select "Item_Rank", "Category", "Item_Purchased", "Total_Orders"
--from "Item_Counts"
--where "Item_Rank" <= 3;

--Q9. Are customers who are repeat bjuyers (more than 5 previous purchases) aslo likely to subscribe?
--select "Subscription_Status",
--count("Customer_ID") as "Repeat_Buyers"
--from customer
--where "Previous_Purchases" > 5
--group by "Subscription_Status"

--Q10. What is the revenue contribution of each age group?
select "Age",
sum("Purchase_Amount") as "Total_Revenue"
from customer
group by "Age"
order by "Total_Revenue" desc;