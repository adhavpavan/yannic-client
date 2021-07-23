# Set environment variables
export CHANNEL_NAME=mychannel

# export CC_NAME=sample_cc
# export CC_PATH=github.com/sample_cc

# export CC_NAME=contract_cc
# export CC_PATH=github.com/contract_cc

export CC_NAME=yannik_cc
export CC_PATH=github.com/yannik_cc

export CC_VERSION=1.0
# wait for Hyperledger Fabric to start
# incase of errors when running later commands, issue export FABRIC_START_TIMEOUT=<larger number>
export FABRIC_START_TIMEOUT=10
#echo ${FABRIC_START_TIMEOUT}
sleep ${FABRIC_START_TIMEOUT}


echo "========== Creating Channel=========="
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/channel/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" peer0.org1.example.com peer channel create -o orderer.example.com:7050 -c mychannel -f /etc/hyperledger/channel/mychannel.tx


# echo "========== Join Channel: Peer0 Org1 =========="

# # Join peer0.org1.example.com to the channel.
# docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/channel/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" peer0.org1.example.com peer channel join -b mychannel.block

# echo "========== Join Channel: Peer1 Org1 =========="

# # For every other peers the genesis block must be first fetched before joining to the channel
# # Fetch genesis block for Peer1 Org1
# docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/channel/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" peer1.org1.example.com peer channel fetch newest mychannel.block -c mychannel --orderer orderer.example.com:7050

# # Join peer1.org1.example.com to the channel.
# docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/channel/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" peer1.org1.example.com peer channel join -b mychannel.block

# echo "========== Join Channel: Peer0 Org2 =========="

# # Fetch genesis block for Peer2 Org1
# docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/channel/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" peer2.org1.example.com peer channel fetch newest mychannel.block -c mychannel --orderer orderer.example.com:7050


# # Join peer0.org2.example.com to the channel.
# docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/channel/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" peer2.org1.example.com peer channel join -b mychannel.block

# echo "========== Join Channel: Peer1 Org2 =========="

# echo "========== Creating CLI Docker Container=========="

# # docker-compose -f artifacts/docker-compose.yaml up -d cli
# # docker-compose -f artifacts/docker-compose-cli.yaml up -d cli

# echo "========== Finished creating CLI Docker Container=========="


# echo "========== Install Chaincode Using CLI on Peer0 Org1 =========="

# docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "export CORE_PEER_ADDRESS=peer0.org1.example.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" cli peer chaincode install -n $CC_NAME -v $CC_VERSION -p $CC_PATH

# echo "========== Install Chaincode Using CLI on Peer1 Org1 =========="

# docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_ADDRESS=peer1.org1.example.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" cli peer chaincode install -n $CC_NAME -v $CC_VERSION -p $CC_PATH

# echo "========== Install Chaincode Using CLI on Peer2 Org1 =========="

# docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_ADDRESS=peer2.org1.example.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" cli peer chaincode install -n $CC_NAME -v $CC_VERSION -p $CC_PATH


# echo "========== Instantiate Chaincode =========="
# docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" cli peer chaincode instantiate -o orderer.example.com:7050 -C mychannel -n $CC_NAME -v $CC_VERSION -c '{"Args":[""]}' -P "AND ('Org1MSP.member')"

# sleep 10

# echo "========== Finished Instantiating Chaincode =========="
