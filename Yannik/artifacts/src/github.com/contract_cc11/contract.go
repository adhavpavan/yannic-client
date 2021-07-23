package main

import (
	"encoding/json"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	sc "github.com/hyperledger/fabric/protos/peer"
)

type Contract struct {
	ID             string    `json:"id"`
	TypeOfContract string    `json:"typeOfContract"`
	Title          string    `json:"title"`
	Owner          string    `json:"owner"`
	Contract       string    `json:"contract"`
	FirstParty     string    `json:"firstParty"`
	SecondParty    string    `json:"secondParty"`
	Status         string    `json:"status"`
	CurrentlyWith  string    `json:"currentlyWith"`
	Steps          []Journey `json:"steps"`
}

type Journey struct {
	Number      float32 `json:"number"`
	Description string  `json:"description"`
	Approver    string  `json:"approver"`
	Action      string  `json:"action"`
	Status      string  `json:"status"`
}

func (s *SmartContract) CreateContract(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {
	if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting 1")
	}

	var contract Contract
	err := json.Unmarshal([]byte(args[0]), &contract)
	if err != nil {
		return shim.Error(err.Error())
	}

	contractAsBytes, err := json.Marshal(contract)
	if err != nil {
		return shim.Error(err.Error())
	}

	err = APIstub.PutState(contract.ID, contractAsBytes)
	if err != nil {
		return shim.Error(err.Error())
	}

	return shim.Success(nil)
}

func (s *SmartContract) getContractById(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {
	if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting 1")
	}

	contractAsBytes, _ := APIstub.GetState(args[0])
	return shim.Success(contractAsBytes)
}
