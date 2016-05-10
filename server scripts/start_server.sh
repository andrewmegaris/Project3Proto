#! bin/bash

#this script launches the server on port 80 for http
echo Starting Hawk Cloud server...
cd project3proto
rvmsudo rails server --binding=0.0.0.0 --port=80
