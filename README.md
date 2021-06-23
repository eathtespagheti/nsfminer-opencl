# nsfminer-opencl

Super small nsfminer image with opencl support (no CUDA)

## Usage

Some configuration it's required

### Set the following variables

* SCHEME: usually stratum
* ETHWALLET: your eth wallet
* WORKERNAME: worker name
* POOLADDRESS: pool address
* POOLPORT: pool port
* API_PORT: monitoring page port (leave blank to disable it)
* RECHECK_TIME: custom recheck time

### Volumes

Since OpenCL configurations and drivers libraries are not included, you should add them using volumes, here's and example for an AMD gpu

- /etc/OpenCL:/etc/OpenCL:ro
- /usr/lib:/usr/externalibs:ro
- /opt/amdgpu:/opt/amdgpu:ro
- /opt/amdgpu-pro:/opt/amdgpu-pro:ro
- /usr/share/libdrm:/usr/share/libdrm:ro

### Device

Add all the cards and render for all your GPUs via the devices parameter

## Docker compose example

``` yaml
nsfminer:
    image: eathtespagheti/nsfminer-opencl
    restart: always
    ports:
      - 8080:80
    environment: 
      - SCHEME=stratum
      - ETHWALLET=0x8bDD239DA91445e4EE2d1e57274C6C8977bd6726
      - WORKERNAME=freeHelp
      - POOLADDRESS=eu1.ethermine.org
      - POOLPORT=4444
      - API_PORT=80
      - RECHECK_TIME=2000
    volumes: 
      - /etc/OpenCL:/etc/OpenCL:ro
      - /usr/lib:/usr/externalibs:ro
      - /opt/amdgpu:/opt/amdgpu:ro
      - /opt/amdgpu-pro:/opt/amdgpu-pro:ro
      - /usr/share/libdrm:/usr/share/libdrm:ro
    devices: 
      - /dev/dri/card1:/dev/dri/card1
      - /dev/dri/renderD129:/dev/dri/renderD129
```