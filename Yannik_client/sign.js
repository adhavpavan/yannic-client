const hasha = require('hasha');
const yaml = require('js-yaml');
const fs = require('fs');
const { KEYUTIL } = require('jsrsasign');
const elliptic = require('elliptic');
const { time, timeEnd } = require('console');

console.time('end-to-end')
const config = yaml.safeLoad(fs.readFileSync('config.yaml', 'utf8'));
let user = config.users["user1"];


const certPem = '<PEM encoded certificate content>';
const mspId = 'Org1MSP'; // the msp Id for this org

const txproposal = {
    fcn: 'move',
    args: ['a', 'b', '100'],
    chaincodeId: 'mychaincodeId',
    channelId: 'mychannel',
};
// const { proposal, txId } = channel.generateUnsignedProposal(transactionProposal, mspId, certPem);

const proposalBytes = Buffer.from(JSON.stringify(proposal));
const digest = hasha(proposalBytes); // calculate the hash of the proposal bytes

let sig;
time('Operations')
const EC = elliptic.ec;
const ecdsaCurve = elliptic.curves['p256'];
const ecdsa = new EC(ecdsaCurve);
timeEnd('Operations')

const { prvKeyHex } = KEYUTIL.getKey(user.priv); // convert the pem encoded key to hex encoded private key
const signKey = ecdsa.keyFromPrivate(prvKeyHex, 'hex');


time('Sign')
sig = ecdsa.sign(Buffer.from(digest, 'hex'), signKey);
timeEnd('Sign')


const signature = Buffer.from(sig.toDER());
console.timeEnd('end-to-end')
const signedProposal = {
    signature,
    proposal_bytes: proposalBytes,
};