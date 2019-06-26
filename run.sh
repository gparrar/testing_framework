#!/bin/bash

# Set the defaults
DEFAULT_LOG_LEVEL="DEBUG" # Available levels: TRACE, DEBUG, INFO (default), WARN, NONE (no logging)
DEFAULT_RES="1280x1024x24"
DEFAULT_DISPLAY=":2"
DEFAULT_ENV="development"
DEFAULT_TESTS="*"

# Use default if none specified as env var
RES=${RES:-$DEFAULT_RES}
DISPLAY=${DISPLAY:-$DEFAULT_DISPLAY}
ROBOT_TESTS=${ROBOT_TESTS:-$DEFAULT_TESTS}
LOG_LEVEL=${LOG_LEVEL:-$DEFAULT_LOG_LEVEL}
TESTS=${TESTS:-$DEFAULT_TESTS}
ENV=${ENV:-$DEFAULT_ENV}

# Start Xvfb
export DISPLAY=${DISPLAY}
echo -e "==> Starting Xvfb on display ${DISPLAY} with res ${RES}"
Xvfb "${DISPLAY}" -ac -screen 0 "${RES}" +extension RANDR &
until xset -q
do
	echo "Waiting for X server to start..."
	sleep 1;
done
fluxbox &

# # Start Sikuli
# echo "==> Starting Sikuli Server"
# java -jar "${HOME}"/target/SikuliLibrary.jar 1000 . &

# Execute Tests
echo -e "==> Executing robot tests at log level ${LOG_LEVEL}"
robot --loglevel "${LOG_LEVEL}" --variable ROBOT_DIR:"${ROBOT_DIR}" --variable ENV:"${ENV}" --variable JMETER_HOME:"${JMETER_HOME}" --NoStatusRC --noncritical high --noncritical medium --noncritical low --outputdir "${ROBOT_DIR}"/output/ -t "${TESTS}" "${ROBOT_DIR}"/tests/"${ROBOT_TESTS}"

# Stop Xvfb
kill -9 "$(pgrep Xvfb)"
