pragma solidity 0.8.13;

contract Foo {

    Bar bar;

    constructor(address _bar) {

        bar = Bar(_bar);
    }

    function callBar() public {

        bar.log();
    }

}

contract Bar {

    event Log(string message);

    function log() public {
        
        emit Log("Bar.log()");
    }

}

contract Mal {

    event Log(string message);

    function log() public {
        
        emit Log("Mal.log()");
    }

}

contract FooSafe {

    Bar public bar;

    constructor() {

        bar = new Bar();
    }

    function callBar() public {

        bar.log();
    }

}
