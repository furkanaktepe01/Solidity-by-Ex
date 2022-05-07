pragma solidity ^0.8.13;

contract Function {

    function returnMany() public pure returns (uint, bool, uint) {
        return (0, true, 2);
    }

    function namedReturnMany() public pure returns (uint x, bool b, uint y) {
        return (0, true, 2);
    }

    function assignedReturnMany() public pure returns (uint x, bool b, uint y) {
        x = 0;
        b = true;
        y = 2;
    }

    function destructuringAssignments() public pure returns (uint, bool, uint, uint, uint) {

        (uint i, bool b, uint j) = returnMany();

        (uint x, , uint y) = (4, 5, 6);

        return (i, b, j, x, y);
    }

    function arrayInput(uint[] memory _arr) public { }

    uint[] public arr;

    function arrayOutput() public view returns (uint[] memory) {
        return arr;
    }

}
