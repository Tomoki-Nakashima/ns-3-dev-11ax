/* -*- Mode:C++; c-file-style:"gnu"; indent-tabs-mode:nil; -*- */
/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation;
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include "ns3/core-module.h"
#include "ns3/network-module.h"
#include "ns3/mobility-module.h"
#include "ns3/wifi-module.h"
#include "ns3/internet-module.h"
#include "ns3/stats-module.h"
#include "ns3/ssid.h"



// Default Network Topology
//
//   Wifi 10.1.3.0
// n0 -------------- n1   
//                   
//                                     


using namespace ns3;

int 
main (int argc, char *argv[])
{
  uint32_t nwifiAP = 1; // Number of AP(Access point)
  uint32_t nwifiSTA = 1; // Number of STA(Stations)
  double distance = 10;
  std::string m_Rate {"0"};       // "ideal" or MCS value
  

  
  CommandLine cmd;
  cmd.AddValue("distance", "Distance apart to place nodes (in meters).", distance);
  cmd.Parse(argc, argv);


// Create STA node objects
  NodeContainer wifiStaNodes;
  wifiStaNodes.Create(nwifiSTA);

// Create AP node objects
  NodeContainer wifiApNodes;
  wifiApNodes.Create(nwifiAP);


// Create a channel helper and phy helper, and then create the channel
  YansWifiPhyHelper phy = YansWifiPhyHelper::Default();
  YansWifiChannelHelper wifiChannel = YansWifiChannelHelper::Default();
  phy.SetChannel(wifiChannel.Create());


// Create a WifiHelper, which will use the above helpers to create
// and install Wifi devices.  Configure a Wifi standard to use, which
// will align various parameters in the Phy and Mac to standard defaults.
  WifiHelper wifi;
  wifi.SetStandard (WIFI_PHY_STANDARD_80211ac);
  uint8_t mcs = std::stoul (m_Rate);
  std::string ctrlRate = mcs == 0 ? "OfdmRate6Mbps"
                                  : (mcs < 3 ? "OfdmRate12Mbps" : "OfdmRate24Mbps");
  wifi.SetRemoteStationManager ("ns3::ConstantRateWifiManager",
                                "DataMode", StringValue ("VhtMcs" + m_Rate),
                                "ControlMode", StringValue (ctrlRate));


// Create a WifiMacHelper, which is reused across STA and AP configurations
  WifiMacHelper mac;


// Declare NetDeviceContainers to hold the container returned by the helper
  NetDeviceContainer wifiStaDevices;
  NetDeviceContainer wifiApDevices;


  Ssid ssid = Ssid ("ns-3-ssid");
// Perform the installation
  mac.SetType ("ns3::StaWifiMac",
               "Ssid", SsidValue (ssid),
               "ActiveProbing", BooleanValue (false));
  wifiStaDevices = wifi.Install (phy, mac, wifiStaNodes);
  mac.SetType ("ns3::ApWifiMac",
               "Ssid", SsidValue (ssid));
  wifiApDevices = wifi.Install (phy, mac, wifiApNodes);


  InternetStackHelper internet;
  internet.Install(wifiStaDevices);
  internet.Install(wifiApDevices);

  Ipv4AddressHelper address;
  address.SetBase("10.1.1.0", "255.255.255.0");
  address.Assign (wifiStaDevices);
  address.Assign (wifiApDevices);


  MobilityHelper mobility;
  Ptr<ListPositionAllocator> positionAlloc = CreateObject<ListPositionAllocator>();
  positionAlloc->Add(Vector(0.0, 0.0, 0.0));
  mobility.SetPositionAllocator(positionAlloc);
  mobility.Install(wifiApNodes);
  Ptr<ListPositionAllocator> positionAlloc = CreateObject<ListPositionAllocator>();
  positionAlloc->Add(Vector(0.0, distance, 0.0));
  mobility.SetPositionAllocator(positionAlloc);
  mobility.Install(wifiStaNodes);


  Ptr<Node> source = NodeList::GetNode(0);
  Ptr<Node> sink = NodeList::GetNode(1);
  Ptr<Sender> sender = CreateObject<Sender>();
  Ptr<Receiver> receiver = CreateObject<Receiver>();
  source ->AddApplication(sender);
  sink ->AddApplication(receiver);
  sender ->SetStartTime(Seconds (0));
  receiver->SetStartTime(Seconds (0));
  Config::Set("/NodeList/0/ApplicationList/*/$Sender/Destination", Ipv4AddressValue("192.168.0.2"));


  Simulator::Run();
  Simulator::Destroy();

  return 0;
}

