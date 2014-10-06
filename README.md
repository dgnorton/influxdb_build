# Usage

Make a directory to receive the output packages.  I'm using ~/vmshare in this example but you can use any directory that suits.  Be sure to update pkg-influxdb.sh accordingly.

`mkdir ~/vmshare`

Build the docker image.

`docker build -t influxdb/build .`

Run pkg-influxdb.sh inside the docker container to build the desired tag, branch, or commit.  In this example, I'm building the "fix-1001" branch.

`docker run -i -v ~/vmshare:/vmshare -t influxdb/build ./pkg-influxdb.sh -t "fix-1001"`

Once the container exits, the .deb, .rpm, etc files should be in ~/vmshare/packages.

If needed, the container can be started with:

`docker run -i -v ~/vmshare:/vmshare -t influxdb/build /bin/bash`

to manually run the script and/or debug build issues.
