Create a virtual environment  
sudo apt install python3-venv  
python3 -m venv venv  
source venv/bin/activate  
pip install wheel  
pip install git+https://github.com/jhlund/metr_config_updater.git  
pip install git+https://github.com/jhlund/metr_data_collector.git  
pip clone https://github.com/jhlund/metr_ctrl_script.git   

sudo cp metr_ctrl_script.sh /usr/local/bin   
sudo chmod +x /usr/local/bin/metr_ctrl_script.sh   

Edit metr_data_collector.service to match the file system of the local computer   
sudo cp metr_data_collector.service /etc/systemd/system/   
python3  
