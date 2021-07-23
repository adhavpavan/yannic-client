package main

import (
	"encoding/json"
	"time"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	sc "github.com/hyperledger/fabric/protos/peer"
)

// Document : Structure of document
type Document struct {
	ID          string    `json:"id"`
	CreatedAt   time.Time `json:"createdAt"`
	Name        string    `json:"name"`
	GcpURL      string    `json:"gcpUrl"`
	ContentHash string    `json:"contentHash"`
}

// CreateDocumentAsset : Function for creating file asset
func (s *SmartContract) CreateDocumentAsset(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {
	if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting 1")
	}

	var document Document

	err := json.Unmarshal([]byte(args[0]), &document)
	if err != nil {
		return shim.Error(err.Error())
	}

	document.CreatedAt = time.Now()

	documentAsBytes, err := json.Marshal(document)
	if err != nil {
		return shim.Error(err.Error())
	}

	err = APIstub.PutState(document.ID, documentAsBytes)
	if err != nil {
		return shim.Error(err.Error())
	}

	return shim.Success(nil)

}
