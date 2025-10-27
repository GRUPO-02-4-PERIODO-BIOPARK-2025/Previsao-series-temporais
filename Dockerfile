FROM tensorflow/tensorflow:2.14.0-gpu

WORKDIR /app

RUN apt update && \
    apt install -y python3-pip build-essential python3-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    pip install --upgrade pip && \
    pip install pybind11 "dask[distributed]" "dask[dataframe]" --upgrade

COPY . .

RUN pip install -r requirements.txt

EXPOSE 80 8787

ENV DASK_DASHBOARD_ADDRESS=":8787"

CMD ["uvicorn", "app.main:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "80"]
