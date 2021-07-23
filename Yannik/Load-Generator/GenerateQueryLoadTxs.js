const axios = require("axios");
const uuidv4 = require('uuid/v4');
const machinIP = '34.70.122.24';
// const url = `http://${machinIP}:4000/channels/mychannel/chaincodes/traceability_cc`;

// let pk = null;
let pk = "e02e54d3-7359-4feb-86bb-6291e52fe0ad";
let token = '';

const getToken = async () => {
    try {
        let response = await axios.post(`http://${machinIP}:4000/users`, `{"username":"pavan","orgName": "Org1"}`, { headers: { "Content-Type": "application/json" } })
        // console.log(response);
        return response.data.token
    } catch (err) {
        console.log(`inside err...111`);
    }
}

const getData = async (url, conf) => {
    axios
        .get(url, conf)
        .then((response) => {
            console.log(response);
            successfulRequest++;

            console.log(`Successful requests are : ${successfulRequest} and query completed for : ${pk}`);
        })
        .catch((error) => {
            // postData(pk, conf)
            console.log(`inside err...retrying for ${pk}`);
            // console.log(error);
            console.log(`Error occured while adding data : ${error}`);
        });
};

let count = 0;
let successfulRequest = 0;
const querySampleData = async (numberOfTransaction, sendingRateInMiliSeconds) => {
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

    const url = `http://${machinIP}:4000/channels/mychannel/chaincodes/traceability_cc?args=["event%23dc73ee5e-a085-4fa4-a383-4d28d4afbc6b"]&&peer=peer0.org1.example.com&&fcn=GetAssetById`
    var setInterval1 = setInterval(() => {
        count = count + 1
        getData(url, conf);
        console.log(`request number is : ${count}`);
        if (count == numberOfTransaction) {
            clearInterval(setInterval1)
        }
    }, sendingRateInMiliSeconds)
};

let numberOfTransaction = process.argv[2]
let sendingRateInMiliSeconds = process.argv[3]
querySampleData(numberOfTransaction, sendingRateInMiliSeconds);
// getToken()
