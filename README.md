## Setup running the metr coding challenge

The implemented solution relies on two separate python programs.  
-  **metr_config_updater**  
Which updates the config for an IoT device.  
-  **metr_data_collector**  
Which is used to fetch data from a server queried at a certain interval, using the information from previously mentioned config.

Both are implemented as CLI tools relying on certain input arguments to avoid hardcoded solutions.

See:

[https://github.com/jhlund/metr_config_updater](https://github.com/jhlund/metr_config_updater)   
[https://github.com/jhlund/metr_data_collector](https://github.com/jhlund/metr_data_collector)

---

### Create a virtual environment  
If not present install the virtual environment module. Create a virtual environment and activate it.  
	`sudo apt install python3-venv`  
	`python3 -m venv venv`  
	`source venv/bin/activate`

### Prepare and install the python tools into this environment
1. install `wheel` if not present.  
`pip install wheel`

2. Either install `metr_config_updater` from git  
`pip install git+https://github.com/jhlund/metr_config_updater.git`  
or from the project folder  
`pip install /path/to/metr_config_updater/ .`

3. Install `metr_data_collector` in the same way.  
`pip install git+https://github.com/jhlund/metr_data_collector.git`  
or  
`pip install /path/to/metr_data_collector/ .`

4. Either clone or download the collection of support and script files   
`pip clone https://github.com/jhlund/metr_ctrl_script.git`

### Move the bash script
#### If wanted move the script called by the systemd service to reasonable location
`sudo cp metr_ctrl_script.sh /usr/local/bin`  
`sudo chmod +x /usr/local/bin/metr_ctrl_script.sh`

### Setup the systemd service to run on startup
1. Open the file `metr_data_collector.service` and edit the four arguments used for `metr_ctrl_script.sh` so that the paths match the local environment  
   
	1. UPDATER_CONFIG, path to the `metr_config_updater` config file
	2. DATA_COLLECTOR_CONFIG, path to the `metr_data_collector` config file
	3. OUTPUT_PATH, path to the output-file used by `metr_data_collector`
	4. VENV, path to the virtual environment where the programs are installed
	
	If `metr_ctrl_script.sh` is not present in /usr/local/bin/, change the path in 		`metr_data_collector.service` to correct path.

2. Copy the .service file to correct folder and change permissions  
`sudo cp metr_data_collector.service /etc/systemd/system/`  
`sudo chmod 640 /etc/systemd/system/metr_data_collector.service`

3. Enable the service to start the created service at boot:  
`sudo systemctl enable metr_data_collector.service`

4. Make sure to enable the network wait process to allow the service to wait for network availability  
`sudo systemctl enable systemd-networkd-wait-online.service`

### Testing the application
To start the service without reboot run:  
`sudo systemctl start metr_data_collector.service`

and check the status of the service   
`systemctl status metr_data_collector.service` 

Also check that the output-file behaves as expected.

