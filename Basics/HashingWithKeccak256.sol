pragma solidity ^0.8.13;

contract HashFunction {

    function hash(string memory _text, uint _num, address _addr) public pure returns (bytes32){
        return keccak256(abi.encodePacked(_text, _num, _addr));
    }

    function collision(string memory _text0, string memory _text1) public pure returns (bytes32) {
        
        // abi.encode() should be used intead, to avoid collision
         
        // encodePacked(YYY, ZZZ) -> YYYZZZ
        // encodePacked(YY, YZZZ) -> YYYZZZ
        return keccak256(abi.encodePacked(_text0, _text1));
    }

}

contract GuessTheMagicWord {

    bytes32 public answer = 0x60298f78cc0b47170ba79c10aa3851d7648bd96f2f8e46a19dbc777c36fb0c00;

    function guess(string memory _word) public view returns (bool) {
        return keccak256(abi.encodePacked(_word)) == answer;
    } 

}
