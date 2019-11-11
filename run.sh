#!/bin/bash 

# Run transactor as a background process
/datomic/bin/transactor /datomic/config/transactor.properties &>/logs/transactor.log &

# Run rest peer as a background process
/datomic/bin/rest free --port 8001 datomic:free://localhost:4334/ &>/logs/rest.log
