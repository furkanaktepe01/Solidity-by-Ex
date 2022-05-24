pragma solidity ^0.8.13;

contract Vault {

    uint public count = 5;

    address public owner = msg.sender;
    bool public isTrue = true;
    uint16 public u16 = 30;

    bytes32 private password;

    uint public constant con = 2;

    bytes32[3] public data;

    struct User {
        uint id;
        bytes32 password;
    }

    User[] private users;

    mapping(uint => User) private idToUser;

    constructor(bytes32 _password) {

        password = _password;
    } 

    function addUser(bytes32 _password) public {

        User memory user = User({id: users.length, password: _password});

        users.push(user);

        idToUser[user.id] = user;
    }

    function getArrayLocation(uint slot, uint index, uint elementSize) public pure returns (uint) {

        return uint(keccak256(abi.encodePacked(slot))) + (index * elementSize);
    }
    
    function getMapLocation(uint slot, uint key) public pure returns (uint) {

        return uint(keccak256(abi.encodePacked(key, slot)));
    }

}
