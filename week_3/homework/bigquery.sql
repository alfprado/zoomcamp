CREATE OR REPLACE EXTERNAL TABLE `balmy-chain-412110.nytaxi.external_green_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://mage-zoomcamp-andre/green/green_tripdata_2022-*.parquet']
);

CREATE OR REPLACE TABLE balmy-chain-412110.nytaxi.green_tripdata_non_partitoned AS
SELECT * FROM balmy-chain-412110.nytaxi.external_green_tripdata;

select count(*) from `nytaxi.green_tripdata_non_partitoned`

select count(distinct PULocationID) from `nytaxi.green_tripdata_non_partitoned`

select count(distinct PULocationID) from `nytaxi.external_green_tripdata`

select count(*) from `nytaxi.external_green_tripdata` where fare_amount = 0;

select count(*) from `nytaxi.green_tripdata_non_partitoned` where date(lpep_pickup_datetime) between '2022-06-01' and '2022-06-30' and PULocationID = 264;

select count(*) as trips from `nytaxi.green_tripdata_partitoned` where date(lpep_pickup_datetime) between '2022-06-01' and '2022-06-30' and PULocationID = 264;

select count(*) as trips from `nytaxi.green_tripdata_partitoned_clustered` where date(lpep_pickup_datetime) between '2022-06-01' and '2022-06-30' and PULocationID = 264;