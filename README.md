# Monica gost-db-dump-dummy
 application of gost-db-dump for huge observation table (https://github.com/MONICA-Project/gost-db-dump)

`dump_gost_db.sh` has been changed to dump the all db except v1.observation, dump the schema of v1.observation, and save some parts according a query

This is a simple docker-compose setup to dump a GOST database from the MONICA cloud and deploy it locally on your machine. Check first if the database you want to export has a manageable size:

```sql
SELECT pg_size_pretty( pg_database_size('<db_name>') );
```

Then copy `docker-compose-example.yml` to `docker-compose.yml`, enter the necessary environment variables for your use case and run

```bash
docker-compose up gost-db-dump
```

This may take a few minutes and will create a dump of the database to file `./dumps/gost.sql`. Your Postgres user needs to have the necessary permissions.

To import the database to a local deployment run

```bash
docker-compose up -d gost-db
```

This will run the script `./docker-entrypoint-initdb.d/import.sh` that imports the dump file `./dumps/gost.sql` created in the first step into a fresh database named `gost`. Note that this will only run as long as your Docker volume `pgdata` is empty. So if the process fails at some point and you want to repeat the import you might have to remove the volume before, e.g.:

```bash
docker volume rm gostdbdump_pgdata
```

After the import was successful, you can start a Gost server instance with a Mosquitto and the Gost Dashboard:

```bash
docker-compose up -d gost-dashboard
```

Then browse your OGC entities at http://localhost:8080/v1.0.

This or a similar setup should be easy to combine with https://github.com/MONICA-Project/observation-replayer.
## Contributing
Contributions are welcome. 

Please fork, make your changes, and submit a pull request. For major changes, please open an issue first and discuss it with the other authors.

## Affiliation
![MONICA](https://github.com/MONICA-Project/template/raw/master/monica.png)  
This work is supported by the European Commission through the [MONICA H2020 PROJECT](https://www.monica-project.eu) under grant agreement No 732350.
