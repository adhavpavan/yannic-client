package main

import (
	"encoding/json"

	// "github.com/hyperledger/fabric/core/chaincode/lib/cid"
	"github.com/hyperledger/fabric/core/chaincode/shim"
	sc "github.com/hyperledger/fabric/protos/peer"
)

// Contract : Structure of contract
// type Contract struct {
// 	ID             string    `json:"id"`
// 	TypeOfContract string    `json:"typeOfContract"`
// 	Title          string    `json:"title"`
// 	Owner          string    `json:"owner"`
// 	Contract       string    `json:"contract"`
// 	FirstParty     string    `json:"firstParty"`
// 	SecondParty    string    `json:"secondParty"`
// 	Status         string    `json:"status"`
// 	CurrentlyWith  string    `json:"currentlyWith"`
// 	Journey        []Journey `json:"journey"`
// }

// Contract : Structure of contract
type Contract struct {
	ContractID     string    `json:"contractID"`
	ContractType   string    `json:"contractType"`
	Name           string    `json:"name"`
	BusinessStatus string    `json:"businessStatus"`
	Categary       string    `json:"categary"`
	VendorName     string    `json:"vendorName"`
	Owner          string    `json:"owner"`
	Address        string    `json:"address"`
	StartDate      string    `json:"startDate"`
	EndDate        string    `json:"endDate"`
	Journey        []Journey `json:"journey"`
}

// Journey : Structure of journey steps in contract
type Journey struct {
	Number      string     `json:"number"`
	Description string     `json:"description"`
	Status      string     `json:"status"`
	Documents   []Document `json:"documents"`
	Users       []User     `json:"users"`
}

// CreateContract : function to create contract asset
func (s *SmartContract) CreateContract(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	// err := cid.AssertAttributeValue(APIstub, "myapp.admin", "true")
	// if err != nil {
	// 	// Return an error
	// }

	// val, ok, err := cid.GetAttributeValue(APIstub, "key")
	// if ok == false {
	// 	fmt.Println("Attribute id not found")
	// 	return shim.Error("only pavan  attribute users can create layout.")
	// }
	// if err != nil {
	// 	return shim.Error(err.Error())
	// }
	// if val != "sandip" {
	// 	fmt.Println("Attribute role: " + val)
	// 	return shim.Error("only pavan attribute users can create layout.")
	// }

	var contract Contract
	err := json.Unmarshal([]byte(args[0]), &contract)
	if err != nil {
		return shim.Error(err.Error())
	}

	contractAsBytes, err := json.Marshal(contract)
	if err != nil {
		return shim.Error(err.Error())
	}

	err = APIstub.PutState(contract.ContractID, contractAsBytes)
	if err != nil {
		return shim.Error(err.Error())
	}

	return shim.Success(nil)
}
