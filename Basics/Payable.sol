pragma solidity ^0.8.13;

contract Payable {
    
    // payable: can receive ETH
    
    address payable public owner;

    constructor() payable {
        owner = payable(msg.sender);
    }

    // Invoked along with ETH -> Contract Balance gets updated
    function deposit() public payable { 
        // ...
    }

    // Invoked along with ETH -> Throws Error
    function notPayable() public { 
        // ...
    }

    function withdraw() public {

        uint amount = address(this).balance;

        (bool success, ) = owner.call{ value: amount }("");

        require(success);
    }

    function transfer(address payable _to, uint _amount) public {

        (bool success, ) = _to.call{ value: _amount }("");

        require(success);
    }

}
