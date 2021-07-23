package main

import (
	"fmt"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	sc "github.com/hyperledger/fabric/protos/peer"
)

// SmartContract
type SmartContract struct {
}

// Init  Method
func (s *SmartContract) Init(APIstub shim.ChaincodeStubInterface) sc.Response {
	return shim.Success(nil)
}

// Invoke Method
func (s *SmartContract) Invoke(APIstub shim.ChaincodeStubInterface) sc.Response {
	function, args := APIstub.GetFunctionAndParameters()

	if function == "CreateContract" {
		return s.CreateContract(APIstub, args)
	} else if function == "getAssetByID" {
		return s.getAssetByID(APIstub, args)
	} else if function == "CreateDocumentAsset" {
		return s.CreateDocumentAsset(APIstub, args)
	}

	return shim.Error("Invalid Smart Contract name........")
}

// getAssetByID : function to get any asset by id
func (s *SmartContract) getAssetByID(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {
	if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting 1")
	}

	contractAsBytes, _ := APIstub.GetState(args[0])
	return shim.Success(contractAsBytes)
}

func main() {

	err := shim.Start(new(SmartContract))
	if err != nil {
		fmt.Printf("Error creating new Smart Contract: %s", err)
	}
}
