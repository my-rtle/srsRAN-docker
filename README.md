# srsRAN-docker
```
git clone https://github.com/my-rtle/srsRAN-docker.git
cd srsRAN-docker
docker-compose build
docker-compose up -d
sudo docker exec -it srsran bash
```
```
cd ../opt/srsRAN_4G/build/
sudo make install
srsran_install_configs.sh user
```
### UHD TEST
```
uhd_find_devices
```
### srsRAN TEST
```
srsue
srsepc
srsenb
```

