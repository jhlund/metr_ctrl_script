Create a virtual environment  
sudo apt install python3-venv  
python3 -m venv venv  
source venv/bin/activate  
pip install wheel  
pip install git+https://github.com/jhlund/metr_config_updater.git  
pip install git+https://github.com/jhlund/metr_data_collector.git  
python3  
