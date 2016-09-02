# Softonic Rexray for EC2

This image starts a RexRay service in the host. Now it just supports EC2 volumes (EBS).
You need to pass your EC2 credentials when launching the container as environment variables. 

## Container execution

    docker service create --mode global --name rexray -e  basi/rexray

## Sample config file

```
rexray:
  storageDrivers:
  - ec2
aws:
  accessKey: ${AWS_ACCESS_KEY_ID}
  secretKey: ${AWS_SECRET_ACCESS_KEY}
```

## Run

For run this container you need to mount some sockets needed for service to run.

```
docker run \
  --rm -it \
  -e AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY \
  -e AWS_SECRET_ACCESS_KEY=YOUR_SECRET_KEY \
  -v /run/docker/plugins:/run/docker/plugins \
  -v /var/lib/rexray:/var/lib/rexray \
  -v /var/run/rexray:/var/run/rexray \
  -v /dev:/dev \
  basi/rexray-ec2
```

In case you have a Swarm cluster you can run it as a global service: 

```
docker service create \
  --name rexray \
  --mode global \
  -e AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY \
  -e AWS_SECRET_ACCESS_KEY=YOUR_SECRET_KEY \
  --mount type=bind,src=/run/docker/plugins,dst=/run/docker/plugins \
  --mount type=bind,src=/var/lib/rexray,dst=/var/lib/rexray \
  --mount type=bind,src=/dev,dst=/dev \
  basi/rexray-ec2
```
