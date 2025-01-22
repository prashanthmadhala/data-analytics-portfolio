# SQL Project Folder

05/01/2025

More information will be updated later

19/01/2025

Repository Content
This repository includes:
1. SQL queries used for creating each table, uploaded as separate .sql files.
2. A structured approach to creating and populating the ecommerce database.
   

This repository showcases my work in building an e-commerce database using datasets gathered from the Kaggle platform. 


Overview
Dataset Source: The datasets used in this project were sourced from Kaggle, providing detailed information related to orders, customers, products, sellers, and payments in an e-commerce context.

Link: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

Database Setup
The database, named ecommerce, was created using the datasets. Each dataset was converted into a corresponding table, forming a relational database.

Tables Created
The following tables were created in the ecommerce database:
1. orders: Information about customer orders.
2. order_items: Details of items included in each order.
3. order_payments: Information on payment methods and transactions.
4. customer: Data about the customers.
5. product_category_name: Mapping of product categories and their descriptions.
6. seller: Information about the sellers in the marketplace.
7. products: Details of the products available for purchase.


22/01/2025
There are also separate files that contain some queries related to each table. 

The names of these files begin with "querying". 

There is another file called analysis.sql where I have done some basic analysis of the dataset. At the end of this file, I have returned a table with 7984 rows and 9 columns. I saved this table as a csv file and uploaded it to the data folder. The name of the file is CityStateProductCategoryStats.csv

I will perform data analysis on this file using Python programming language. The analysis can be found in python_project folder. 
