const axios = require("axios");
const uuidv4 = require('uuid/v4');
const machinIP = 'localhost';
const url = `http://${machinIP}:4000/channels/mychannel/chaincodes/contract_cc`;
let pk = null;
let token = '';
// axios.timeout= 5;

const getToken = async () => {
  try {
    let response = await axios.post(`http://${machinIP}:4000/users`, `{"username":"pavan","orgName": "Org1"}`, { headers: { "Content-Type": "application/json" } })
    // console.log(response);
    return response.data.result.token

  } catch (err) {
    console.log(`inside err...111: ${err}`);
  }
}

const postData = async (pk, conf, id) => {
    let name = "Contract_"+id
  axios
    .post(
      url,
      {
        "fcn": "CreateContract",
        "peers": ["peer0.org2.example.com"],
        "chaincodeName": "contract_cc",
        "channelName": "mychannel",
        "args": [`{\"contractId\": \"${name}\",\"contractType\": \"Fix Price\",\"name\": \"LaptopContract\",\"businessStatus\": \"Created\",\"categary\": \"Default\",\"vendorName\": \"Lenovo Pvt Ltd\",\"owner\": \"IBM Pvt Ltd\",\"address\": \"IBM Pune\",\"startDate\":\"11/11/2020\",\"endDate\": \"11/11/2021\",\"journey\": [{\"number\":\"1\",\"description\":\"NA\",\"status\":\"Pending\",\"documents\":[{\"id\": \"1234\",\"name\":\"Agrement Docs\",\"gcpUrl\":\"abc.com\",\"contentHash\": \"AAAAA\"}],\"users\": [{\"userID\":\"1\",\"name\": \"Pavan\",\"email\": \"abc@gmail.com\",\"departmentID\":\"123\",\"role\":\"Approver\"},{\"userID\" : \"2\",\"name\": \"Sandip\",\"email\": \"pqr@gmail.com\",\"departmentID\":\"123\",\"role\":\"Viewer\"}]}]}`]
      },
      conf
    )
    .then((response) => {
      // console.log(response);
      successfulRequest++;
      console.log(`Successful requests are : ${successfulRequest} and Data added for : ${pk}`);
    })
    .catch((error) => {
      // postData(pk, conf)
      console.log(`inside err...retrying for ${pk}`);
      // console.log(error);
      // console.log(`Error occured while adding data : ${{ error }}`);
    });
};

let count = 0;
let successfulRequest = 0;
const addSampleData = async (numberOfTransaction, sendingRateInMiliSeconds) => {
  if (numberOfTransaction == null || numberOfTransaction < 1) {
    numberOfTransaction = 2
    console.log("Transaction numnber not provided, hence seting default as 2");
  }
  if (sendingRateInMiliSeconds == null || sendingRateInMiliSeconds < 1) {
    sendingRateInMiliSeconds = 10
    console.log("Did not get transaction sending rate, hence seting to 10 ms default");
  }
  token = await getToken();
  console.log(`token is :    ------------- ${token}`);
  let conf = {
    headers: {
      Authorization: `Bearer ${token}`,
      "Content-Type": "application/json"
    },
    timeout: 10000
  };
  var setInterval1 = setInterval(() => {
    count = count + 1
    let pk = uuidv4();
    postData(pk, conf, Math.floor((Math.random() * 10000000) + 1));
    console.log(`request number is : ${count}`);
    if (count == numberOfTransaction) {
      clearInterval(setInterval1)
    }
  }, sendingRateInMiliSeconds)
};

let numberOfTransaction = process.argv[2]
let sendingRateInMiliSeconds = process.argv[3]

addSampleData(numberOfTransaction, sendingRateInMiliSeconds);

// ex - node contract.js 10 100
// 10 - number of transaction
// 100 - interval bet transactions sending