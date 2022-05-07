pragma solidity ^0.8.13;

/*

Signing:
1: Create message to sign
2: Hash the message
3: Sign the message

Verify:
1: Recreate hash from the original message
2: Recover signer from signature and hash
3: Compare recovered signer to claimed signer

*/

contract VerifySignature {

    /*  
        1. Unlock MetaMask Account:
        
        ethereum.enable()
    */

    /*
        2. Get message hash to sign:
        
        getMessageHash(
            0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C,
            7,
            "message_0",
            1
        )

        Hash = "0xf7..."
    */

    function getMessageHash(address _to, uint _amount, string memory _message, uint _nonce) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_to, _amount, _message, _nonce));
    }

    /*
        3. Sign the hash:

        web3.personal.sign(hash, web3.defaultAccount, console.log)

        Signature = "0x99..."
    */

    function getEthSignedMessageHash(bytes32 _messageHash) public pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message\n32", _messageHash));
    }

    /*
        4. Verify signature:
    */
    
    function verify(
        address _signer,
        address _to, 
        uint _amount, 
        string memory _message,
        uint _nonce,
        bytes memory signature
    ) public pure returns (bool) {

        bytes32 messageHash = getMessageHash(_to, _amount, _message, _nonce);

        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        return recoverSigner(ethSignedMessageHash, signature) == _signer;
    }

    function recoverSigner(bytes32 _ethSignedMessageHash, bytes memory _signature) public pure returns (address) {

        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);

        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function splitSignature(bytes memory sig) public pure returns (bytes32 r, bytes32 s, uint8 v) {

        require(sig.length == 65, "Invalid Signature Length");

        /*
            Signature's first 32 bytes stores the length of the signature

            add(sig, x) = Pointer of Signature + x : skips first x byte of the sig

            mload(p) loads next 32 bytes starting at the memory address p 
        */

        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := byte(0, mload(add(sig, 96)))
        }
    }

}
