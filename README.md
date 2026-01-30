# srsRAN-docker
'''
git clone https://github.com/my-rtle/srsRAN-docker.git
docker-compose build
docker-compose up -d
sudo docker exec -it srsran bash
'''
이후 opt/srsRAN_4G/build/ 들어가서
'''
sudo make install
srsran_install_configs.sh user
'''
### UHD TEST
'''
uhd_find_devices
'''
### srsRAN TEST
'''
srsue
srsepc
srsenb
'''

