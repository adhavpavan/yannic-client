const argv = require('yargs').argv;
const yaml = require('js-yaml');
const fs = require('fs');
// const { generateKeyPair } = require('crypto');
const { KEYUTIL, KJUR, X509 } = require('jsrsasign');

// loads the configuration file
const config = yaml.safeLoad(fs.readFileSync('config.yaml', 'utf8'));

// const { Worker, isMainThread, parentPort } = require('worker_threads');

// let fabric_client = initFabric();
let user = config.users["user1"];
// let defchannel = config.defaultChannel;


const invokeTransfer = () => {

    console.time("Test")
    var product = "1111";
    var c = new X509();
    c.readCertPEM(config.users["user1"].cert);
    var pubKey = c.getPublicKeyHex();  // public key as hex
    // console.log('pubkey: ', pubKey);
    var message = product + pubKey;

    let privKey = KEYUTIL.getKey(user.priv, "PKCS8PRV");

    // create signature
    let sig = new KJUR.crypto.Signature({ alg: 'SHA256withECDSA' });

    sig.init(privKey);

    sig.updateString(message);
    console.timeEnd('Test')
    console.time("111")
    let signature = sig.sign();
    console.timeEnd("111")
    // console.timeEnd("Test")

    // hexadecimal string signature
    console.log(`Signature==================:`, signature);
    console.log(`product==================:`, product);
    console.log(`pubKey===================:`, pubKey);


}

invokeTransfer()