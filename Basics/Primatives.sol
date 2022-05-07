pragma solidity ^0.8.13;

contract Primatives {

    bool public boo = true;

    uint8 public u8 = 1;
    uint public u256 = 500;

    int8 public i8 = -1;
    int public i256 = 500;

    int public minInt = type(int).min;
    int public maxInt = type(int).max;

    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    byte1 a = 0xb5;
    byte1 b = 0x56;

    bool public defaultBoo; // false
    uint public defaultUint; // 0
    int public defaultInt; // 0
    address public defaultAddr; // 0x0000000000000000000000000000000000000000

}
