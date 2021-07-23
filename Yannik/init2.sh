# Set environment variables
export CHANNEL_NAME=mychannel
export CC_NAME=yannik_cc
export CC_PATH=github.com/yannik_cc

export CC_VERSION=1.1
# wait for Hyperledger Fabric to start
# incase of errors when running later commands, issue export FABRIC_START_TIMEOUT=<larger number>
# export FABRIC_START_TIMEOUT=10
#echo ${FABRIC_START_TIMEOUT}
# sleep ${FABRIC_START_TIMEOUT}


echo "========== Creating Channel=========="
#Create Channel
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/channel/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" cli peer channel create -o orderer.example.com:7050 -c mychannel -f /etc/hyperledger/channel/mychannel.tx --tls --cafile /etc/hyperledger/channel/crypto-config/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem

echo "========== Peer0 Joining Channel Channel=========="
#Join Channel peer 0
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/channel/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e "CORE_PEER_ADDRESS=peer0.org1.example.com:7051" cli peer channel join -b mychannel.block 
# echo "========== Join Channel: Peer0 Org1 =========="

# Fetch genesis block for Peer1 Org1
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/channel/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" peer1.org1.example.com peer channel fetch newest mychannel.block -c mychannel --orderer orderer.example.com:7050 --tls --cafile /etc/hyperledger/channel/crypto-config/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem


# Join channel  peer 1
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/channel/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" peer1.org1.example.com peer channel join -b mychannel.block
# echo "========== Join Channel: Peer01 Org1 =========="


echo "========== Install Chaincode Using CLI on Peer0 Org1 =========="

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "export CORE_PEER_ADDRESS=peer0.org1.example.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/channel/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" cli peer chaincode install -n $CC_NAME -v $CC_VERSION -p $CC_PATH

echo "========== Install Chaincode Using CLI on Peer1 Org1 =========="

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_ADDRESS=peer1.org1.example.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/channel/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" cli peer chaincode install -n $CC_NAME -v $CC_VERSION -p $CC_PATH

echo "========== Install Chaincode Using CLI on Peer2 Org1 =========="

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_ADDRESS=peer2.org1.example.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/channel/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" cli peer chaincode install -n $CC_NAME -v $CC_VERSION -p $CC_PATH


echo "========== Instantiate Chaincode =========="
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/channel/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" cli peer chaincode instantiate -o orderer.example.com:7050 -C mychannel -n $CC_NAME -v $CC_VERSION -c '{"Args":[""]}' -P "OR ('Org1MSP.member')" --tls --cafile /etc/hyperledger/channel/crypto-config/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem

sleep 5

# echo "========== Finished Instantiating Chaincode =========="
