/*
============================================================================
Create Schemas
=============================================================================
Script Purpose:
This script creates a new schemas,the script sets up three schemas :'bronze', 'silver' and 'gold'.

WARNING:
Running this script will drop the schemas if it exists.All data in the database will be permanently deleted.Proceed with caution
and ensure you have proper backups before runing the script.
*/

CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
