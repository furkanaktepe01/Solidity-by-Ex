pragma solidity ^0.8.13;

contract X {

    string name;

    constructor(string memory _name) {
        name = _name;
    }

}

contract Y {

    string text;

    constructor(string memory _text) {
        text = _text;
    }

}

contract Z is X("name_0"), Y("text_0") {

    // ...
}

contract W is X, Y {

    constructor(string memory _name, string memory _text) X(_name) Y(_text) { }

    // The order of invocation of parent constructors is subject to the ordering in the inheritance list
}
