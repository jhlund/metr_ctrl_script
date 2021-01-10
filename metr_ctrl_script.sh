#!/bin/bash
# Upstart script that runs the metr_data_collector if
# metr_config_updater have been able to run successfully.

UPDATER_CONFIG=$1
DATA_COLLECTOR_CONFIG=$2
OUTPUT_PATH=$3
VENV=$4

# activate virtual environment
source $VENV


if metr_config_update update-config -C $UPDATER_CONFIG; then
    echo success
    metr_data_collector collect-data -C $DATA_COLLECTOR_CONFIG -O $OUTPUT_PATH
else
    echo failed
fi

