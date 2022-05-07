pragma solidity ^0.8.13;

contract ReceiveEther {

    // ETH has sent:
    
    // if msg.data is empty
    receive() external payable { 
        // ...
    }

    // if msg.data is not empty or receive() does not exist
    fallback() external payable {
        // ...
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

}

contract SendEther {

    function sendViaTransfer(address payable _to) public payable {
        
        // transfer: 2300 gas, throws error
        _to.tranfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        
        // send: 2300 gas, returns bool
        bool sent = _to.send(msg.value);

        require(sent);       
    }

    function sendViaCall(address payable _to) public payable {
        
        // call: forward all gas or set gas, returns bool, recommended
        (bool sent, bytes memory data) = _to.call{ value: msg.value }("");

        require(sent);
    }

}
