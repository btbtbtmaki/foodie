#!/bin/bash
#sudo -u postgres psql postgres --command 'CREATE ROLE daniel WITH CREATEDB;'
sudo -u postgres psql postgres --command 'ALTER USER ubuntu CREATEDB;'
sudo -u postgres psql -U postgres -d postgres -c "alter user ubuntu with password 'ubuntu';"



