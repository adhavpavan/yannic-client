echo "========== Stop Previous Docker Containers=========="

docker-compose -f artifacts/docker-compose-raft.yaml down


echo "========== Creating Docker Containers=========="

docker-compose -f artifacts/docker-compose-raft.yaml up -d


echo "========== Finished creating Docker Containers=========="

# Use REGEX to search and delete keystore folders starting with 'fabric-client-kv'
echo "========== Deleting Old KeyStore =========="
rm -rf `ls | grep -E "^fabric-client-kv*"`