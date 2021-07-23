package main

import (
	"fmt"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	sc "github.com/hyperledger/fabric/protos/peer"
)

// Smart Contract
type SmartContract struct {
}

// Init  Method
func (s *SmartContract) Init(APIstub shim.ChaincodeStubInterface) sc.Response {
	return shim.Success(nil)
}

// Invoke Method
func (s *SmartContract) Invoke(APIstub shim.ChaincodeStubInterface) sc.Response {
	function, args := APIstub.GetFunctionAndParameters()

	if function == "CreateCarAsset" {
		return s.CreateCarAsset(APIstub, args)
	} else if function == "GetCarById" {
		return s.GetCarById(APIstub, args)
	} else if function == "GetHistoryForCarAsset" {
		return s.GetHistoryForCarAsset(APIstub, args)
	}

	return shim.Error("Invalid Smart Contract name........")
}

func main() {

	err := shim.Start(new(SmartContract))
	if err != nil {
		fmt.Printf("Error creating new Smart Contract: %s", err)
	}
}
