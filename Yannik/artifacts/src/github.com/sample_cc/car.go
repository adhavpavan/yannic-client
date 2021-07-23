package main

import (
	"encoding/json"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	sc "github.com/hyperledger/fabric/protos/peer"
)

type Car struct {
	ID           string `json:"id"`
	Name         string `json:"name"`
	Model        string `json:"model"`
	Owner        string `json:"owner"`
	Manufacturer string `json:"manufacturer"`
}

func (s *SmartContract) CreateCarAsset(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {
	if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting 1")
	}

	var car Car
	err := json.Unmarshal([]byte(args[0]), &car)
	if err != nil {
		return shim.Error(err.Error())
	}

	carAsBytes, err := json.Marshal(car)
	if err != nil {
		return shim.Error(err.Error())
	}

	err = APIstub.PutState(car.ID, carAsBytes)
	if err != nil {
		return shim.Error(err.Error())
	}

	return shim.Success(nil)
}

func (s *SmartContract) GetCarById(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {
	if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting 1")
	}

	carAsBytes, _ := APIstub.GetState(args[0])
	return shim.Success(carAsBytes)
}
