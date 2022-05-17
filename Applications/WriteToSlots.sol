pragma solidity ^0.8.13;

contract Storage {

    struct MyStruct {
        uint value;
    }

    MyStruct public s0 = MyStruct(5);    
    MyStruct public s1 = MyStruct(6);
    MyStruct public s2 = MyStruct(7);

    function _get(uint i) internal pure returns (MyStruct storage s) {
        
        assembly {
            s.slot := i
        }
    }

    function get(uint i) external view returns (uint) {
        
        return _get(i).value;
    }

    function set(uint i, uint x) external {

        _get(i).value = x;
    }

}
