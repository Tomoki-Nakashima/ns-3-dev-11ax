payloadSize=1472 # bytes
simulationTime=10 # seconds
distance=5 # meters
interBssDistance=10 # meters
txMaskInnerBandMinimumRejection=-40.0 # dBr
txMaskOuterBandMinimumRejection=-56.0 # dBr
txMaskOuterBandMaximumRejection=-80.0 # dBr

channelBssA=1
channelBssB=36
channelBssC=144
channelBssD=1
channelBssE=36
channelBssF=1
channelBssG=144

primaryChannelBssA=1
primaryChannelBssB=36
primaryChannelBssC=144
primaryChannelBssD=1
primaryChannelBssE=36
primaryChannelBssF=1
primaryChannelBssG=144

mcs1=VhtMcs0
mcs2=VhtMcs0
mcs3=VhtMcs0
mcs4=VhtMcs0
mcs5=VhtMcs0
mcs6=VhtMcs0
mcs7=VhtMcs0

ccaSdThreshold=-62

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
downlinkG=100


uplinkA=0
uplinkB=0
uplinkC=0
uplinkD=100
uplinkE=100
uplinkF=100
uplinkG=100

channelBondingType="ConstantThreshold"
Test=""

n=10
nBss=7

rxSensitivity=-100

result_filename=EDdownlinkforSDED.csv

for ccaSdThreshold in -82 -62;
do
for mcs in VhtMcs0 VhtMcs8;
do
for RngRun in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100;
do
echo "Starting Bss=$nBss n=$n, ccaSdThreshold=$ccaSdThreshold, mcs=$mcs, distance=$distance "
../waf --run "channel-bonding  --payloadSize=$payloadSize --simulationTime=$simulationTime --distance=$distance --interBssDistance=$interBssDistance --txMaskInnerBandMinimumRejection=$txMaskInnerBandMinimumRejection --txMaskOuterBandMinimumRejection=$txMaskOuterBandMinimumRejection --txMaskOuterBandMaximumRejection=$txMaskOuterBandMaximumRejection --channelBssA=$channelBssA --primaryChannelBssA=$primaryChannelBssA --channelBssB=$channelBssB --primaryChannelBssB=$primaryChannelBssB --channelBssC=$channelBssC --primaryChannelBssC=$primaryChannelBssC --channelBssD=$channelBssD --primaryChannelBssD=$primaryChannelBssD --channelBssE=$channelBssE --primaryChannelBssE=$primaryChannelBssE --channelBssF=$channelBssF --primaryChannelBssF=$primaryChannelBssF --channelBssG=$channelBssG --primaryChannelBssG=$primaryChannelBssG --mcs1=$mcs --mcs2=$mcs --mcs3=$mcs --mcs4=$mcs --mcs5=$mcs --mcs6=$mcs --mcs7=$mcs --ccaSdThreshold=$ccaSdThreshold --ccaEdThresholdPrimaryBssA=${ccaEdThresholdPrimaryBssA} --ccaEdThresholdSecondaryBssA=$ccaEdThresholdSecondaryBssA --ccaEdThresholdPrimaryBssB=${ccaEdThresholdPrimaryBssB} --ccaEdThresholdSecondaryBssB=$ccaEdThresholdSecondaryBssB --ccaEdThresholdPrimaryBssC=${ccaEdThresholdPrimaryBssC} --ccaEdThresholdSecondaryBssC=$ccaEdThresholdSecondaryBssC  --ccaEdThresholdPrimaryBssD=${ccaEdThresholdPrimaryBssD} --ccaEdThresholdSecondaryBssD=$ccaEdThresholdSecondaryBssD --ccaEdThresholdPrimaryBssE=${ccaEdThresholdPrimaryBssE} --ccaEdThresholdSecondaryBssE=$ccaEdThresholdSecondaryBssE --ccaEdThresholdPrimaryBssF=${ccaEdThresholdPrimaryBssF} --ccaEdThresholdSecondaryBssF=$ccaEdThresholdSecondaryBssF --ccaEdThresholdPrimaryBssG=${ccaEdThresholdPrimaryBssG} --ccaEdThresholdSecondaryBssG=$ccaEdThresholdSecondaryBssG --downlinkA=${downlinkA} --downlinkB=$downlinkB --downlinkC=$downlinkC --downlinkD=$downlinkD --downlinkE=$downlinkE --downlinkF=$downlinkF --downlinkG=$downlinkG --uplinkA=$uplinkA --uplinkB=$uplinkB --uplinkC=$uplinkC --uplinkD=${uplinkD} --uplinkE=$uplinkE --uplinkF=$uplinkF --uplinkG=$uplinkG --channelBondingType=$channelBondingType --n=$n --nBss=$nBss --rxSensitivity=$rxSensitivity --RngRun=$RngRun --result_filename=$result_filename" 
wait
done
wait
done
wait
done
