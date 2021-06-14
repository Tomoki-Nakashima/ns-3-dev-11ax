payloadSize=1472 # bytes
simulationTime=100 # seconds
distance=5 # meters
interBssDistance=15 # meters
txMaskInnerBandMinimumRejection=-40.0 # dBr
txMaskOuterBandMinimumRejection=-56.0 # dBr
txMaskOuterBandMaximumRejection=-80.0 # dBr

channelBssA=36
channelBssB=52
channelBssC=100
channelBssD=36
channelBssE=52
channelBssF=100
channelBssG=100

primaryChannelBssA=36
primaryChannelBssB=52
primaryChannelBssC=100
primaryChannelBssD=36
primaryChannelBssE=52
primaryChannelBssF=100
primaryChannelBssG=100

mcs1=VhtMcs0
mcs2=VhtMcs0
mcs3=VhtMcs0
mcs4=VhtMcs0
mcs5=VhtMcs0
mcs6=VhtMcs0
mcs7=VhtMcs0

ccaSdThreshold=-82

ccaEdThresholdPrimaryBssA=-62.0
ccaEdThresholdSecondaryBssA=-62.0
ccaEdThresholdPrimaryBssB=-62.0
ccaEdThresholdSecondaryBssB=-62.0
ccaEdThresholdPrimaryBssC=-62.0
ccaEdThresholdSecondaryBssC=-62.0
ccaEdThresholdPrimaryBssD=-62.0
ccaEdThresholdSecondaryBssD=-62.0
ccaEdThresholdPrimaryBssE=-62.0
ccaEdThresholdSecondaryBssE=-62.0
ccaEdThresholdPrimaryBssF=-62.0
ccaEdThresholdSecondaryBssF=-62.0
ccaEdThresholdPrimaryBssG=-62.0
ccaEdThresholdSecondaryBssG=-62.0

downlinkA=100
downlinkB=100
downlinkC=100
downlinkD=100
downlinkE=100
downlinkF=100
downlinkG=0


uplinkA=0
uplinkB=0
uplinkC=0
uplinkD=0
uplinkE=0
uplinkF=0
uplinkG=0

channelBondingType="ConstantThreshold"
Test=""

n=10
nBss=6

rxSensitivity=-100

result_filename=dynamicMCS0_100.csv

for ccaSdThreshold in -82 -62 -67.25340976;
do
for mcs in VhtMcs0;
do
for RngRun in {1..100};
do
echo "Starting Bss=$nBss n=$n, ccaSdThreshold=$ccaSdThreshold, mcs=$mcs, distance=$distance "
../waf --run "channel-bonding  --payloadSize=$payloadSize --simulationTime=$simulationTime --distance=$distance --interBssDistance=$interBssDistance --txMaskInnerBandMinimumRejection=$txMaskInnerBandMinimumRejection --txMaskOuterBandMinimumRejection=$txMaskOuterBandMinimumRejection --txMaskOuterBandMaximumRejection=$txMaskOuterBandMaximumRejection --channelBssA=$channelBssA --primaryChannelBssA=$primaryChannelBssA --channelBssB=$channelBssB --primaryChannelBssB=$primaryChannelBssB --channelBssC=$channelBssC --primaryChannelBssC=$primaryChannelBssC --channelBssD=$channelBssD --primaryChannelBssD=$primaryChannelBssD --channelBssE=$channelBssE --primaryChannelBssE=$primaryChannelBssE --channelBssF=$channelBssF --primaryChannelBssF=$primaryChannelBssF --channelBssG=$channelBssG --primaryChannelBssG=$primaryChannelBssG --mcs1=$mcs --mcs2=$mcs --mcs3=$mcs --mcs4=$mcs --mcs5=$mcs --mcs6=$mcs --mcs7=$mcs --ccaSdThreshold=$ccaSdThreshold --ccaEdThresholdPrimaryBssA=${ccaEdThresholdPrimaryBssA} --ccaEdThresholdSecondaryBssA=$ccaEdThresholdSecondaryBssA --ccaEdThresholdPrimaryBssB=${ccaEdThresholdPrimaryBssB} --ccaEdThresholdSecondaryBssB=$ccaEdThresholdSecondaryBssB --ccaEdThresholdPrimaryBssC=${ccaEdThresholdPrimaryBssC} --ccaEdThresholdSecondaryBssC=$ccaEdThresholdSecondaryBssC  --ccaEdThresholdPrimaryBssD=${ccaEdThresholdPrimaryBssD} --ccaEdThresholdSecondaryBssD=$ccaEdThresholdSecondaryBssD --ccaEdThresholdPrimaryBssE=${ccaEdThresholdPrimaryBssE} --ccaEdThresholdSecondaryBssE=$ccaEdThresholdSecondaryBssE --ccaEdThresholdPrimaryBssF=${ccaEdThresholdPrimaryBssF} --ccaEdThresholdSecondaryBssF=$ccaEdThresholdSecondaryBssF --ccaEdThresholdPrimaryBssG=${ccaEdThresholdPrimaryBssG} --ccaEdThresholdSecondaryBssG=$ccaEdThresholdSecondaryBssG --downlinkA=${downlinkA} --downlinkB=$downlinkB --downlinkC=$downlinkC --downlinkD=$downlinkD --downlinkE=$downlinkE --downlinkF=$downlinkF --downlinkG=$downlinkG --uplinkA=$uplinkA --uplinkB=$uplinkB --uplinkC=$uplinkC --uplinkD=${uplinkD} --uplinkE=$uplinkE --uplinkF=$uplinkF --uplinkG=$uplinkG --channelBondingType=$channelBondingType --n=$n --nBss=$nBss --rxSensitivity=$rxSensitivity --RngRun=$RngRun --result_filename=$result_filename" &
wait
done
wait
done
wait
done
