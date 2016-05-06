#! bin/bash

#this script launches the server on port 80 for http
echo starting server...
cd project3proto
rvmsudo rails server --binding=0.0.0.0 --port=80