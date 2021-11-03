#!/usr/bin/env bash

FLAG_FILE=/tmp/bluetooth-disable
# Adapted from a copy-pasted script.

ADDR=38:18:4C:BE:49:FC
function get_headphones_index() {
  echo $(pacmd list-cards | grep bluez_card -B1 | grep index | awk '{print $2}')
}

# unused function
function get_headphones_mac_address() {
  local temp=$(pacmd list-cards | grep bluez_card -C20 | grep 'device.string' | cut -d' ' -f 3)
  temp="${temp%\"}"
  temp="${temp#\"}"
  echo "${temp}"
}

function _control_bluetooth_headphones() {
  local op=${1}
  local hp_mac=$ADDR
  echo -e "${op} ${hp_mac}\n quit" | bluetoothctl
}

function disconnect_bluetooth_headphones() {
  _control_bluetooth_headphones "disconnect"
}

function connect_bluetooth_headphones() {
  _control_bluetooth_headphones "connect"
}

function _set_headphones_profile() {
  local profile=${1}
  pacmd set-card-profile $(get_headphones_index) ${profile}
}

function set_headphones_profile_a2dp_sink() {
  _set_headphones_profile "a2dp_sink"
  echo "bluetooth headphones a2dp_sink"
}

function set_headphones_profile_off() {
  _set_headphones_profile "off"
  echo "bluetooth headphones profile off"
}

function main() {
  rm -f "$FLAG_FILE"
  set_headphones_profile_off
  sleep 1s
  disconnect_bluetooth_headphones
  sleep 4s
  connect_bluetooth_headphones
  sleep 2s
  set_headphones_profile_a2dp_sink
}

main
