
export CHANNEL_NAME=mychannel

export CC_NAME=yannik_cc
export CC_PATH=github.com/yannik_cc

export CC_VERSION=1.1



# echo "========== Install Chaincode Using CLI on Peer0 Org1 =========="

# docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "export CORE_PEER_ADDRESS=peer0.org1.example.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/channel/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" cli peer chaincode install -n $CC_NAME -v $CC_VERSION -p $CC_PATH

# echo "========== Install Chaincode Using CLI on Peer1 Org1 =========="

# docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_ADDRESS=peer1.org1.example.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/channel/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" cli peer chaincode install -n $CC_NAME -v $CC_VERSION -p $CC_PATH

# echo "========== Install Chaincode Using CLI on Peer2 Org1 =========="

# docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_ADDRESS=peer2.org1.example.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/channel/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" cli peer chaincode install -n $CC_NAME -v $CC_VERSION -p $CC_PATH


echo "========== Upgrade Chaincode =========="
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/channel/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" cli peer chaincode upgrade -o orderer.example.com:7050 -C mychannel -n $CC_NAME -v $CC_VERSION -c '{"Args":[""]}' -P "OR ('Org1MSP.member')"

sleep 5