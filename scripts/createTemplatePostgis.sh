#!/usr/bin/env bash

# Create the template spatial database
createdb -E UTF8 template_postgis

# Add PLPGSQL language support
createlang -d template_postgis plpgsql

# Enable PostGIS extension
psql -d template_postgis -c "CREATE EXTENSION postgis;"

# Enable users to alter spatial tables
psql -d template_postgis -c "GRANT ALL ON geometry_columns TO PUBLIC;"
psql -d template_postgis -c "GRANT ALL ON spatial_ref_sys TO PUBLIC;"

# Make the database a template
psql -d postgres -c "UPDATE pg_database SET datistemplate='true' WHERE datname='template_postgis';"
