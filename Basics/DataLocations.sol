pragma solidity ^0.8.13;

contract DataLocations {

    uint[] public arr;

    mapping(uint => address) map;

    struct MyStruct {
        uint foo;
    }

    mapping(uint => MyStruct) myStructs;

    function f() public {

        _f(arr, map, myStructs[1]);

        MyStruct storage myStruct = myStructs[1];

        MyStruct memory myMemStruct = MyStruct(0);
    }

    function _f(uint[] storage _arr, mapping(uint => address) storage _map, MyStruct storage _myStruct) internal {
        // ...
    }

    function g(uint[] memory _arr) public returns (uint[] memory) {
        // ...
        return _arr;
    }

    function h(uint[] calldata _arr) external {
        // ...
    }

}
