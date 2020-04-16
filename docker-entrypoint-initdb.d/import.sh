#!/bin/bash

psql gost < /monica/dumps/gost.sql
psql gost < /monica/dumps/observation.sql
psql -d gost -c "\copy v1.observation (id, data, stream_id, featureofinterest_id) FROM '/monica/dumps/obs.csv' with delimiter as ','"

