import requests
from google.cloud import storage

BUCKET = "mage-zoomcamp-andre"

storage.blob._MAX_MULTIPART_SIZE = 5 * 1024 * 1024 
storage.blob._DEFAULT_CHUNKSIZE = 5 * 1024 * 1024 

client = storage.Client()
    
def load():
    for i in range(12):
        
        month = '0'+str(i+1)
        month = month[-2:]

        file_name = f"green_tripdata_2022-{month}.parquet"
        
        url = f'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-{month}.parquet'
        
        response = requests.get(url)
        open(file_name, 'wb').write(response.content)

        bucket = client.bucket(BUCKET)
        blob = bucket.blob(f"green/{file_name}")
        blob.upload_from_filename(file_name)
        print(f"green/{file_name}")


load()
