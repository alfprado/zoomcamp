# Zoocamp 2024

Week 1

- to compile Dockerfile:

```docker build -t taxi_ingest:v001 .```

- start local python http server inside data directory:

```python -m http.server```

- to ingest data you need to set URL:

```URL="http://localhost:8000/green_tripdata_2019-09.csv"```

then:

```python ingest_data.py --user=root --password=root --host="localhost-ip" --port=5432 --db=ny_taxi --table_name=green_taxi_data --url=${URL}```

with docker:

```docker run -it taxi_ingest:v001 --user=root --password=root --host=localhost --port=5432 --db=ny_taxi --table_name=gree_taxi_data --url=${URL}```

set "localhost" with your ip.