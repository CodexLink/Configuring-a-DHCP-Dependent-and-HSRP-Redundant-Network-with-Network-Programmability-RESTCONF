#!/bin/bash
# Created by Janrey Licas

# Constants
BASELINE_FOLDER="./results"
FOLDER_VENV="bin"
TESTBED_FILE_PATH="testbed.yml"
MAIN_DEV_NAME="MainRouter"
SIDEA_DEV_NAME="SideA_Router"
SIDEB_DEV_NAME="SideB_Router"
DEV_COMP_CONF_FOLDER="compared_configs"
DEV_TEST_CASE_FOLDER="test_cases"

# Intro
echo "Network Configuration and Test Result Fetcher v1"
echo "Specifically for Final Case Study - Configuring a DHCP-Dependent and Redundant Network with Network Programmability (RESTCONF)"
echo -e "Created by Janrey 'CodexLink' Licas | https://github.com/CodexLink\n"

# Preparation
echo "Step 0.1 | Preparing Folder for Result Placements ..."

if [ -d "$BASELINE_FOLDER" ]; then
  echo "Folder $BASELINE_FOLDER already exists."
else
  mkdir "$BASELINE_FOLDER"
  echo "Folder $BASELINE_FOLDER were created!"
fi

echo "Step 0.2 | Checking for Virtual Environment ..."
if [ -d "./$FOLDER_VENV" ]; then
  echo "Virtual environment exists. Assuming it was running under that."
else
  echo "Virtual environment does not exists."
fi

echo "Step 0.3 | Checking for pyATS ..."
GREP_RESULT=`$(pip3 freeze | grep -q "pyats")`

if [ -z "$GREP_RESULT" ]; then
  read -p "
pyATS Detected. Please do ensure that your pyATS is fully updated. Otherwise, 'perform pip3 install pyATS[full] --update' first. Ctrl+BREAK if you want to do that first, otherwise, press enter to continue."
else
  echo  "
pyATS Not Detected. Please install the pyATS package by performing 'perform pip3 install pyATS[full]' and try again."
  exit
fi

echo -e "\nStep 0.4 | Checking for Genie Testbed YAML ..."
if [ -f "./$TESTBED_FILE_PATH" ]; then
  echo -e "Testbed for the Cisco IOS-XE Devices detected!\n"
else
  echo -e "Testbed for the Cisco IOS-XE Device were not detected! Please perform 'genie create testbed --interactive --output testbed.yml --encode-password' and try again.\n"
  exit
fi

echo -e "\nStep 0.5 | Creating non-existing folders for all routers ..."
if [ ! -d "./$BASELINE_FOLDER/$MAIN_DEV_NAME" ]; then
  mkdir "./$BASELINE_FOLDER/$MAIN_DEV_NAME"
  echo "Folder '$MAIN_DEV_NAME' has been created."
fi

if [ ! -d "./$BASELINE_FOLDER/$SIDEA_DEV_NAME" ]; then
  mkdir "./$BASELINE_FOLDER/$SIDEA_DEV_NAME"
  echo "Folder '$SIDEA_DEV_NAME' has been created."
fi

if [ ! -d "./$BASELINE_FOLDER/$SIDEB_DEV_NAME" ]; then
  mkdir "./$BASELINE_FOLDER/$SIDEB_DEV_NAME"
  echo "Folder '$SIDEB_DEV_NAME' has been created."
fi

echo -e "\n\nStep 0.6 | Creating non-existing folders for step procedures ..."
if [ ! -d "./$BASELINE_FOLDER/$DEV_COMP_CONF_FOLDER" ]; then
  mkdir "./$BASELINE_FOLDER/$DEV_COMP_CONF_FOLDER"
  echo "Folder '$DEV_COMP_CONF_FOLDER' has been created."
fi

if [ ! -d "./$BASELINE_FOLDER/$DEV_TEST_CASE_FOLDER" ]; then
  mkdir "./$BASELINE_FOLDER/$DEV_TEST_CASE_FOLDER"
  echo "Folder '$DEV_TEST_CASE_FOLDER' has been created."
fi

# I know that this calls for the need of Anti-Redundancy but I don't know how to do that and I don't have time, maybe in the future?
echo -e "\n\nStep 1 | Fetching Device Configurations.\n"

# Main Router
echo "Step 1.1 | MainRouter's DHCP Pool ..."
genie parse "show running-config all | sec dhcp pool" --testbed-file $TESTBED_FILE_PATH --device $MAIN_DEV_NAME --output $BASELINE_FOLDER/$MAIN_DEV_NAME/dhcp-pool --raw

echo "Step 1.2 | MainRouter's DHCP Configuration ..."
genie parse "show running-config all | sec dhcp" --testbed-file $TESTBED_FILE_PATH --device $MAIN_DEV_NAME --output $BASELINE_FOLDER/$MAIN_DEV_NAME/dhcp-config --raw

echo "Step 1.3 | MainRouter's Interface ..."
genie parse "show interfaces" --testbed-file $TESTBED_FILE_PATH --device $MAIN_DEV_NAME --output $BASELINE_FOLDER/$MAIN_DEV_NAME/ip-interface-info

echo "Step 1.4 | MainRouter's Interface Configuration ..."
genie parse "show running-config all | sec interface" --testbed-file $TESTBED_FILE_PATH --device $MAIN_DEV_NAME --output $BASELINE_FOLDER/$MAIN_DEV_NAME/ip-interface-config

echo "Step 1.5 | MainRouter's IP Routes ..."
genie parse "show ip route" --testbed-file $TESTBED_FILE_PATH --device $MAIN_DEV_NAME --output $BASELINE_FOLDER/$MAIN_DEV_NAME/ip-route

echo "Step 1.6 | MainRouter's OSPF Database ..."
genie parse "show ip ospf database" --testbed-file $TESTBED_FILE_PATH --device $MAIN_DEV_NAME --output $BASELINE_FOLDER/$MAIN_DEV_NAME/ospf-database

echo "Step 1.7 | MainRouter's OSPF Neighbors ..."
genie parse "show ip ospf neighbor" --testbed-file $TESTBED_FILE_PATH --device $MAIN_DEV_NAME --output $BASELINE_FOLDER/$MAIN_DEV_NAME/ospf-neighbors

echo "Step 1.8 | MainRouter's OSPF Parameters ..."
genie parse "show running-config all | sec router" --testbed-file $TESTBED_FILE_PATH --device $MAIN_DEV_NAME --output $BASELINE_FOLDER/$MAIN_DEV_NAME/ospf-params --raw

# Side A
echo "Step 1.9 | SideA_Router's DHCP Pool ..."
genie parse "show running-config all | sec dhcp pool" --testbed-file $TESTBED_FILE_PATH --device $SIDEA_DEV_NAME --output $BASELINE_FOLDER/$SIDEA_DEV_NAME/dhcp-pool --raw

echo "Step 1.10 | SideA_Router's DHCP Configuration ..."
genie parse "show running-config all | sec dhcp" --testbed-file $TESTBED_FILE_PATH --device $SIDEA_DEV_NAME --output $BASELINE_FOLDER/$SIDEA_DEV_NAME/dhcp-config --raw

echo "Step 1.11 | SideA_Router's Interface ..."
genie parse "show interfaces" --testbed-file $TESTBED_FILE_PATH --device $SIDEA_DEV_NAME --output $BASELINE_FOLDER/$SIDEA_DEV_NAME/ip-interface-info

echo "Step 1.12 | SideA_Router's Interface Configuration ..."
genie parse "show running-config all | sec interface" --testbed-file $TESTBED_FILE_PATH --device $SIDEA_DEV_NAME --output $BASELINE_FOLDER/$SIDEA_DEV_NAME/ip-interface-config

echo "Step 1.13 | SideA_Router's IP Routes ..."
genie parse "show ip route" --testbed-file $TESTBED_FILE_PATH --device $SIDEA_DEV_NAME --output $BASELINE_FOLDER/$SIDEA_DEV_NAME/ip-route

echo "Step 1.14 | SideA_Router's OSPF Database ..."
genie parse "show ip ospf database" --testbed-file $TESTBED_FILE_PATH --device $SIDEA_DEV_NAME --output $BASELINE_FOLDER/$SIDEA_DEV_NAME/ospf-database

echo "Step 1.15 | SideA_Router's OSPF Neighbors ..."
genie parse "show ip ospf neighbor" --testbed-file $TESTBED_FILE_PATH --device $SIDEA_DEV_NAME --output $BASELINE_FOLDER/$SIDEA_DEV_NAME/ospf-neighbors

echo "Step 1.16 | SideA_Router's OSPF Parameter ..."
genie parse "show running-config all | sec router" --testbed-file $TESTBED_FILE_PATH --device $SIDEA_DEV_NAME --output $BASELINE_FOLDER/$SIDEA_DEV_NAME/ospf-params --raw

echo "Step 1.17 | SideA_Router's HSRP Brief"
genie parse "show standby brief" --testbed-file $TESTBED_FILE_PATH --device $SIDEA_DEV_NAME --output $BASELINE_FOLDER/$SIDEA_DEV_NAME/hsrp-brief

echo "Step 1.19 | SideA_Router's HSRP Configuration ..."
genie parse "show running-config all | sec standby" --testbed-file $TESTBED_FILE_PATH --device $SIDEA_DEV_NAME --output $BASELINE_FOLDER/$SIDEA_DEV_NAME/hsrp-config --raw

# Side B
echo "Step 1.20 | SideB_Router's DHCP Pool ..."
genie parse "show running-config all | sec dhcp pool" --testbed-file $TESTBED_FILE_PATH --device $SIDEB_DEV_NAME --output $BASELINE_FOLDER/$SIDEB_DEV_NAME/dhcp-pool --raw

echo "Step 1.21 | SideB_Router's DHCP Configuration ..."
genie parse "show running-config all | sec dhcp" --testbed-file $TESTBED_FILE_PATH --device $SIDEB_DEV_NAME --output $BASELINE_FOLDER/$SIDEB_DEV_NAME/dhcp-config --raw

echo "Step 1.22 | SideB_Router's Interface ..."
genie parse "show interfaces" --testbed-file $TESTBED_FILE_PATH --device $SIDEB_DEV_NAME --output $BASELINE_FOLDER/$SIDEB_DEV_NAME/ip-interface-info

echo "Step 1.23 | SideB_Router's Interface Configuration ..."
genie parse "show running-config all | sec interface" --testbed-file $TESTBED_FILE_PATH --device $SIDEB_DEV_NAME --output $BASELINE_FOLDER/$SIDEB_DEV_NAME/ip-interface-config

echo "Step 1.23 | SideB_Router's IP Routes ..."
genie parse "show ip route" --testbed-file $TESTBED_FILE_PATH --device $SIDEB_DEV_NAME --output $BASELINE_FOLDER/$SIDEB_DEV_NAME/ip-route

echo "Step 1.24 | SideB_Router's OSPF Database ..."
genie parse "show ip ospf database" --testbed-file $TESTBED_FILE_PATH --device $SIDEB_DEV_NAME --output $BASELINE_FOLDER/$SIDEB_DEV_NAME/ospf-database

echo "Step 1.25 | SideB_Router's OSPF Neighbors ..."
genie parse "show ip ospf neighbor" --testbed-file $TESTBED_FILE_PATH --device $SIDEB_DEV_NAME --output $BASELINE_FOLDER/$SIDEB_DEV_NAME/ospf-neighbors

echo "Step 1.26 | SideB_Router's OSPF Parameter ..."
genie parse "show running-config all | sec router" --testbed-file $TESTBED_FILE_PATH --device $SIDEB_DEV_NAME --output $BASELINE_FOLDER/$SIDEB_DEV_NAME/ospf-params --raw

echo "Step 1.27 | SideB_Router's HSRP Brief"
genie parse "show standby brief" --testbed-file $TESTBED_FILE_PATH --device $SIDEB_DEV_NAME --output $BASELINE_FOLDER/$SIDEB_DEV_NAME/hsrp-brief

echo "Step 1.29 | SideB_Router's HSRP Configuration ..."
genie parse "show running-config all | sec standby" --testbed-file $TESTBED_FILE_PATH --device $SIDEB_DEV_NAME --output $BASELINE_FOLDER/$SIDEB_DEV_NAME/hsrp-config --raw

echo -e "\nStep 2 | Generating Device Configurations Comparisons.\n"
echo "Step 2.1 | Split DHCP Configuration (Pool) Comparison Between Side A and Side B Routers"
if [ ! -d $BASELINE_FOLDER/$DEV_COMP_CONF_FOLDER/side_ab_compared_dhcp_config ]; then
  mkdir $BASELINE_FOLDER/$DEV_COMP_CONF_FOLDER/side_ab_compared_dhcp_config
  echo "Folder for the Test 'side_ab_compared_dhcp_config' has been created."
fi
diff $BASELINE_FOLDER/$SIDEA_DEV_NAME/dhcp-config/SideA_Router_show-running-config-all-pipe-sec-dhcp_console.txt $BASELINE_FOLDER/$SIDEB_DEV_NAME/dhcp-config/SideB_Router_show-running-config-all-pipe-sec-dhcp_console.txt > $BASELINE_FOLDER/$DEV_COMP_CONF_FOLDER/side_ab_compared_dhcp_config/compared_dhcp_config.txt

echo "Step 2.2 | HSRP Configuration Comparison between Side A and Side B Routers."
if [ ! -d $BASELINE_FOLDER/$DEV_COMP_CONF_FOLDER/side_ab_compared_hsrp_config ]; then
  mkdir $BASELINE_FOLDER/$DEV_COMP_CONF_FOLDER/side_ab_compared_hsrp_config
  echo "Folder for the Test 'side_ab_compared_hsrp_config' has been created."
fi
diff $BASELINE_FOLDER/$SIDEA_DEV_NAME/hsrp-config/SideA_Router_show-running-config-all-pipe-sec-standby_console.txt $BASELINE_FOLDER/$SIDEB_DEV_NAME/hsrp-config/SideB_Router_show-running-config-all-pipe-sec-standby_console.txt > $BASELINE_FOLDER/$DEV_COMP_CONF_FOLDER/side_ab_compared_hsrp_config/compared_hsrp_config.txt

echo "Step 2.3 | OSPF Assert Neighbor Establish between MainRouter, Side A and Side B Routers."
# MainRouter to Side A
genie diff $BASELINE_FOLDER/$MAIN_DEV_NAME/ospf-neighbors/MainRouter_show-ip-ospf-neighbor_parsed.txt $BASELINE_FOLDER/$SIDEA_DEV_NAME/ospf-neighbors/SideA_Router_show-ip-ospf-neighbor_parsed.txt --output $BASELINE_FOLDER/$DEV_COMP_CONF_FOLDER/mainrouter_side_a_ospf_neighbor

# MainRouter to Side B
genie diff $BASELINE_FOLDER/$MAIN_DEV_NAME/ospf-neighbors/MainRouter_show-ip-ospf-neighbor_parsed.txt $BASELINE_FOLDER/$SIDEB_DEV_NAME/ospf-neighbors/SideB_Router_show-ip-ospf-neighbor_parsed.txt --output $BASELINE_FOLDER/$DEV_COMP_CONF_FOLDER/mainrouter_side_b_ospf_neighbor

# Side A to Side B
genie diff $BASELINE_FOLDER/$SIDEA_DEV_NAME/ospf-neighbors/SideA_Router_show-ip-ospf-neighbor_parsed.txt $BASELINE_FOLDER/$SIDEB_DEV_NAME/ospf-neighbors/SideB_Router_show-ip-ospf-neighbor_parsed.txt --output $BASELINE_FOLDER/$DEV_COMP_CONF_FOLDER/side_a_side_b_ospf_neighbor

echo -e "\nStep 3 | Performing Test Cases.\n"

echo "Step 3.1 | Side A Router Ping Side B Router (Vice-Versa) via Ethernet2"
# Side A to Side B
genie parse "ping 10.69.44.2" --testbed-file $TESTBED_FILE_PATH --device $SIDEA_DEV_NAME --output $BASELINE_FOLDER/$DEV_TEST_CASE_FOLDER/ping-side-a-to-b

# Side B to A
genie parse "ping 10.69.44.1" --testbed-file $TESTBED_FILE_PATH --device $SIDEB_DEV_NAME --output $BASELINE_FOLDER/$DEV_TEST_CASE_FOLDER/ping-side-b-to-a

echo "Step 3.2 | Side A Router Ping their Clients"
echo "The following test case needs an input of the IP address of a computer!"
read -p "SideA_ClientN> IP Address: " SideA_IPADDR
genie parse "ping $SideA_IPADDR" --testbed-file $TESTBED_FILE_PATH --device $SIDEA_DEV_NAME --output $BASELINE_FOLDER/$DEV_TEST_CASE_FOLDER/ping-side-a-router-to-client

echo "Step 3.3 | Side B Router Ping their Clients"
echo "The following test case needs an input of the IP address of a computer!"
read -p "SideB_ClientN> IP Address: " SideB_IPADDR
genie parse "ping $SideB_IPADDR" --testbed-file $TESTBED_FILE_PATH --device $SIDEB_DEV_NAME --output $BASELINE_FOLDER/$DEV_TEST_CASE_FOLDER/ping-side-b-router-to-client

echo "Step 3.4 | MainRouter Ping Side A and Side B Router"
genie parse "ping 10.69.42.2" --testbed-file $TESTBED_FILE_PATH --device $MAIN_DEV_NAME --output $BASELINE_FOLDER/$DEV_TEST_CASE_FOLDER/ping-mainrouter-to-side-a-router
genie parse "ping 10.69.43.2" --testbed-file $TESTBED_FILE_PATH --device $MAIN_DEV_NAME --output $BASELINE_FOLDER/$DEV_TEST_CASE_FOLDER/ping-mainrouter-to-side-b-router

read -p "Step 3.5 | HSRP Effect: Side B as Active, Pinging Side A and Side B Clients (Requires User Interaction) | Disconnect Side A Router's Ethernet Ports, Wait and Press Enter to Continue."
read -p "SideA_ClientN> IP Address after Side B is an HSRP Active: " SideA_IPADDR
read -p "SideB_ClientN> IP Address after Side B is an HSRP Active: " SideB_IPADDR
genie parse "ping 10.69.43.2" --testbed-file $TESTBED_FILE_PATH --device $MAIN_DEV_NAME --output $BASELINE_FOLDER/$DEV_TEST_CASE_FOLDER/ping-hsrp-side-b-active-mainrouter-to-side-b-router
genie parse "ping $SideA_IPADDR" --testbed-file $TESTBED_FILE_PATH --device $MAIN_DEV_NAME --output $BASELINE_FOLDER/$DEV_TEST_CASE_FOLDER/ping-hsrp-side-b-active-mainrouter-to-side-a-pc
genie parse "ping $SideB_IPADDR" --testbed-file $TESTBED_FILE_PATH --device $MAIN_DEV_NAME --output $BASELINE_FOLDER/$DEV_TEST_CASE_FOLDER/ping-hsrp-side-b-active-mainrouter-to-side-b-pc

echo "Step 3.6 | HSRP Effect: Side A as Active (Preempt-ed), Pinging Side A and Side B Clients (Requires User Interaction) | Disconnect Side B Router's Ethernet Ports, Wait and Press Enter to Continue."
read -p "SideA_ClientN> IP Address after Side A is an HSRP Active: " SideA_IPADDR
read -p "SideB_ClientN> IP Address after Side A is an HSRP Active: " SideB_IPADDR
genie parse "ping 10.69.42.2" --testbed-file $TESTBED_FILE_PATH --device $MAIN_DEV_NAME --output $BASELINE_FOLDER/$DEV_TEST_CASE_FOLDER/ping-hsrp-side-a-active-mainrouter-to-side-b-router
genie parse "ping $SideA_IPADDR" --testbed-file $TESTBED_FILE_PATH --device $MAIN_DEV_NAME --output $BASELINE_FOLDER/$DEV_TEST_CASE_FOLDER/ping-hsrp-side-a-active-mainrouter-to-side-a-pc
genie parse "ping $SideB_IPADDR" --testbed-file $TESTBED_FILE_PATH --device $MAIN_DEV_NAME --output $BASELINE_FOLDER/$DEV_TEST_CASE_FOLDER/ping-hsrp-side-a-active-mainrouter-to-side-b-pc

echo -e "\nAll done!"
echo "Please check the results in the '$BASELINE_FOLDER' for the results of the test cases and also configurations that the Genie has fetched throughout the script runtime."
exit
