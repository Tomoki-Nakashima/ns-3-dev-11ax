/* -*-  Mode: C++; c-file-style: "gnu"; indent-tabs-mode:nil; -*- */
/*
 * Copyright (c) 2018 University of Washington
 *
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
 *
 * Author: Sébastien Deronne <sebastien.deronne@gmail.com>
 */

#include "ns3/log.h"
#include "ns3/node.h"
#include "ns3/config.h"
#include "ns3/double.h"
#include "ns3/uinteger.h"
#include "constant-obss-pd-algorithm.h"
#include "sta-wifi-mac.h"
#include "wifi-utils.h"
#include "wifi-phy.h"
#include "wifi-net-device.h"
#include "he-configuration.h"

namespace ns3 {

NS_LOG_COMPONENT_DEFINE ("ConstantObssPdAlgorithm");
NS_OBJECT_ENSURE_REGISTERED (ConstantObssPdAlgorithm);

ConstantObssPdAlgorithm::ConstantObssPdAlgorithm ()
  : ObssPdAlgorithm ()
{
  NS_LOG_FUNCTION (this);
}

TypeId
ConstantObssPdAlgorithm::GetTypeId (void)
{
  static ns3::TypeId tid = ns3::TypeId ("ns3::ConstantObssPdAlgorithm")
    .SetParent<ObssPdAlgorithm> ()
    .SetGroupName ("Wifi")
    .AddConstructor<ConstantObssPdAlgorithm> ()
  ;
  return tid;
}
    
void
ConstantObssPdAlgorithm::SetupCallbacks (void)
{
  uint32_t nodeid = GetWifiNetDevice ()->GetNode ()->GetId ();
        
  std::ostringstream oss;
  oss.str ("");
  oss << "/NodeList/" << nodeid << "/DeviceList/*/";
  std::string devicepath = oss.str ();
        
  Config::ConnectWithoutContext (devicepath + "$ns3::WifiNetDevice/Phy/EndOfHePreamble", MakeCallback (&ConstantObssPdAlgorithm::ReceiveHeSig, this));
}

void
ConstantObssPdAlgorithm::ReceiveHeSig (HePreambleParameters params)
{
  NS_LOG_FUNCTION (this);

  Ptr<StaWifiMac> mac = GetWifiNetDevice ()->GetMac ()->GetObject<StaWifiMac>();
  if (mac && !mac->IsAssociated ())
    {
      NS_LOG_DEBUG ("This is not an associated STA: skip OBSS PD algorithm");
      return;
    }

  NS_LOG_DEBUG ("RSSI=" << WToDbm (params.rssiW) << " dBm , BSS color=" << +params.bssColor);

  Ptr<HeConfiguration> heConfiguration = GetWifiNetDevice ()->GetHeConfiguration ();
  NS_ASSERT (heConfiguration);
  UintegerValue bssColorAttribute;
  heConfiguration->GetAttribute ("BssColor", bssColorAttribute);
  uint8_t bssColor = bssColorAttribute.Get ();

  if (bssColor == 0)
    {
      NS_LOG_DEBUG ("BSS color is 0");
      return;
    }
  if (params.bssColor == 0)
    {
      NS_LOG_DEBUG ("Received BSS color is 0");
      return;
    }
  //TODO: SRP_AND_NON-SRG_OBSS-PD_PROHIBITED=1 => OBSS_PD SR is not allowed

  bool isObss = (bssColor != params.bssColor);
  if (isObss)
    {
      if (WToDbm (params.rssiW) < GetObssPdLevel ())
        {
          NS_LOG_DEBUG ("Frame is OBSS and RSSI is below OBSS-PD level: reset PHY to IDLE");
          ResetPhy ();
        }
      else
        {
          NS_LOG_DEBUG ("Frame is OBSS and RSSI is above OBSS-PD level");
        }
    }
  else
    {
      NS_LOG_DEBUG ("Frame is not OBSS");
    }
}

void
ConstantObssPdAlgorithm::ReceiveBeacon (HeBeaconReceptionParameters params)
{
  NS_LOG_FUNCTION (this);
}

} //namespace ns3