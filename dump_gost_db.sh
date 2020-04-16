#!/bin/bash

echo "GOST_DB_HOST is $GOST_DB_HOST"
echo "GOST_DB_PORT is $GOST_DB_PORT"
echo "GOST_DB is $GOST_DB"
echo "GOST_DB_USER is $GOST_DB_USER"
echo "GOST_DB_PASSWORD is $GOST_DB_PASSWORD"

echo "$GOST_DB_HOST:$GOST_DB_PORT:$GOST_DB:$GOST_DB_USER:$GOST_DB_PASSWORD" > ~/.pgpass
chmod 0600 ~/.pgpass

pg_dump --no-acl -h $GOST_DB_HOST -T v1.observation -p $GOST_DB_PORT -U $GOST_DB_USER $GOST_DB > /monica/dumps/gost.sql
pg_dump --no-acl -h $GOST_DB_HOST -p $GOST_DB_PORT -U $GOST_DB_USER $GOST_DB -t v1.observation -s > /monica/dumps/observation.sql
psql -h $GOST_DB_HOST -p $GOST_DB_PORT -U $GOST_DB_USER $GOST_DB -c "\copy (SELECT * FROM v1.observation WHERE (stream_id IN (20220,20311) OR stream_id=129) AND data ->> 'phenomenonTime' BETWEEN '2019-08-30T21:00:00.000Z' AND '2019-08-30T22:00:00.000Z') TO '/monica/dumps/obs.csv' with delimiter as ','"


# IOT_SLM: stream_id BETWEEN 49 AND 96  ## Everything from IOT SLM
# Density Map and trackID: stream_id IN (20220,20311)
# stream_id between 98 and 111"