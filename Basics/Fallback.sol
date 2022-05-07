pragma solidity ^0.8.13;

contract Fallback {
    
    event Log(uint gas);

    // If a function that does not exist is called or
    // Ether is sent directly to the contract and msg.data is not empty or receive() does not exist
    fallback() external payable {

        // send() and transfer() forwards 2300 gas,
        // call{}() forwards all of the gas to the fallback()

        emit Log(gasleft());
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

}

contract SendToFallback {

    function transferToFallback(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function callToFallback(address payable _to) public payable {
        (bool sent, ) = _to.call{ value: msg.value }("");
        require(sent);
    }

}
