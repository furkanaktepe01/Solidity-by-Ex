pragma solidity ^0.8.13;

contract H {
    
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }

}

contract K {

    uint public num;
    address public sender;
    uint public value;

    function setVars(address _contract, uint _num) public payable {
        
        // sets K's storage, H is not modified
        // executes H's setVars() with K's storage, msg.sender, msg.value
        (bool success, bytes memory data) = _contract.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num));
    }

}
