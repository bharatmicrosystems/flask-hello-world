FROM python:2.7-slim AS build
ADD . /app
WORKDIR /app
RUN pip install --upgrade pip
RUN pip install -r ./requirements.txt

FROM gcr.io/distroless/python2.7
COPY --from=build /app /app
COPY --from=build /usr/local/lib/python2.7/site-packages /usr/local/lib/python2.7/site-packages
WORKDIR /app
ENV PYTHONPATH=/usr/local/lib/python2.7/site-packages
EXPOSE 5000
CMD ["app.py"]
