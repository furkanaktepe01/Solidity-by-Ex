pragma solidity ^0.8.13;

contract Array {

    uint[] public arr_0;
    uint[] public arr_1 = [1, 2, 3];

    uint[10] public myFixedSizeArr;

    function get(uint index) public view returns (uint) {
        return arr_0[index];
    }

    function getArr() public view returns (uint[] memory) {
        return arr_0;
    }

    function push(uint element) public {
        arr_0.push(element);
    }

    function pop() public {
        arr_0.pop();
    }

    function getLength() public view returns (uint) {
        return arr_0.length;
    }

    function remove(uint index) public {
        delete arr_0[index];
    } 

    function examples() external {
        uint[] memory a = new uint[](5);
    }

}

contract ArrayRemoveByShifting {

    uint[] public arr;

    function remove(uint index) public {

        require(index < arr.length);

        for (uint i = index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }

        arr.pop();
    }

}

contract ArrayReplaceFromEnd {

    uint[] public arr;

    function remove(uint index) public {

        arr[index] = arr[arr.length - 1];

        arr.pop();
    }

}
