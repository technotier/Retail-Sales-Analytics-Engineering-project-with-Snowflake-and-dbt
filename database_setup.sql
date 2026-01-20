-- create warehouse 
create or replace warehouse retail_sales_wh
warehouse_size = 'x-small'
auto_suspend = 60
auto_resume = true 
initially_suspended = true
comment = 'Warehouse for Retail Sales data processing';

-- start warehouse
use warehouse retail_sales_wh;

-- create database 
create or replace database retail_sales_db;
-- start database 
use database retail_sales_db;

-- create raw schema for initial data
create or replace schema raw_schema;
-- start schema 
use schema raw_schema;
