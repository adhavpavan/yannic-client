
chmod -R 0755 ./crypto-config
# Delete existing artifacts
rm -rf ./crypto-config
rm genesis.block channel.tx

# Generate Crypto artifactes for organizations
cryptogen generate --config=./cryptogen.yaml --output=./crypto-config/



# System channel
SYS_CHANNEL="sys-channel"

# channel name defaults to "mychannel"
CHANNEL_NAME="mychannel"

echo "---------------------------------------------"
echo $CHANNEL_NAME

# Generate System Genesis block
configtxgen -profile SampleMultiNodeEtcdRaft -channelID $SYS_CHANNEL  -outputBlock ./genesis.block


# Generate channel configuration block
configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./mychannel.tx -channelID $CHANNEL_NAME