channelBssA=42
channelBssB=40
channelBssC=44
channelBssD=42
channelBssE=42
channelBssF=42
channelBssG=42

primaryChannelBssA=36
primaryChannelBssB=40
primaryChannelBssC=44
primaryChannelBssD=48
primaryChannelBssE=36
primaryChannelBssF=40
primaryChannelBssG=44

uplinkA=400
uplinkB=100
uplinkC=100
uplinkD=400
uplinkE=400
uplinkF=400
uplinkG=400
downlinkA=0
downlinkB=0
downlinkC=0
downlinkD=0
downlinkE=0
downlinkF=0
downlinkG=0

payloadSize=1472
simulationTime=5


ccaEdThresholdPrimary=-62
constantCcaEdThresholdSecondaryBss=-72
channelBondingType=ConstantThreshold
interBssDistance=10
distance=5
n=10
nBss=3
RngRun=1
mcs=VhtMcs8
for RngRun in 1; do
for interBssDistance in 10  40; do
for constantCcaEdThresholdSecondaryBss in -87 -57;
do
				Test=${nBss}_${n}_${interBssDistance}_${constantCcaEdThresholdSecondaryBss}_${mcs}_${RngRun}

../waf --run "channel-bonding --Test=$Test --mcs=$mcs --nBss=$nBss --simulationTime=$simulationTime --RngRun=$RngRun --uplinkA=$uplinkA --uplinkB=$uplinkB --uplinkC=$uplinkC --uplinkD=$uplinkD --uplinkE=$uplinkE --uplinkF=$uplinkF --uplinkG=$uplinkG --downlinkA=$downlinkA --downlinkB=$downlinkB --downlinkC=$downlinkC --downlinkD=$downlinkD --downlinkE=$downlinkE --downlinkF=$downlinkF --downlinkG=$downlinkG --channelBondingType=$channelBondingType  --n=$n --interBssDistance=$interBssDistance --distance=$distance --ccaEdThresholdPrimaryBssA=$ccaEdThresholdPrimary --ccaEdThresholdPrimaryBssB=$ccaEdThresholdPrimary --ccaEdThresholdPrimaryBssC=$ccaEdThresholdPrimary --ccaEdThresholdPrimaryBssD=$ccaEdThresholdPrimary --ccaEdThresholdPrimaryBssE=$ccaEdThresholdPrimary --ccaEdThresholdPrimaryBssF=$ccaEdThresholdPrimary --ccaEdThresholdPrimaryBssG=$ccaEdThresholdPrimary --ccaEdThresholdSecondaryBssA=$constantCcaEdThresholdSecondaryBss --ccaEdThresholdSecondaryBssB=$constantCcaEdThresholdSecondaryBss --ccaEdThresholdSecondaryBssC=$constantCcaEdThresholdSecondaryBss --ccaEdThresholdSecondaryBssD=$constantCcaEdThresholdSecondaryBss --ccaEdThresholdSecondaryBssE=$constantCcaEdThresholdSecondaryBss --ccaEdThresholdSecondaryBssF=$constantCcaEdThresholdSecondaryBss --ccaEdThresholdSecondaryBssG=$constantCcaEdThresholdSecondaryBss  --channelBssA=$channelBssA --channelBssB=$channelBssB --channelBssC=$channelBssC --channelBssD=$channelBssD --channelBssE=$channelBssE --channelBssF=$channelBssF --channelBssG=$channelBssG --primaryChannelBssA=$primaryChannelBssA --primaryChannelBssB=$primaryChannelBssB --primaryChannelBssC=$primaryChannelBssC --primaryChannelBssD=$primaryChannelBssD --primaryChannelBssE=$primaryChannelBssE --primaryChannelBssF=$primaryChannelBssF --primaryChannelBssG=$primaryChannelBssG" &
done
done
done
