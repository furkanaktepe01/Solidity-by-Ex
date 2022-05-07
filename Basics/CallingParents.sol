pragma solidity ^0.8.13;

contract A {
    
    event Log(string message);

    function foo() public virtual {
        emit Log("A.foo()");
    }

    function bar() public virtual {
        emit Log("A.bar()");
    }

}

contract B is A {

    function foo() public virtual override {
        emit Log("B.foo()");
        A.foo();
    }

    function bar() public virtual override {
        emit Log("B.bar()");
        super.bar();
    }

}

contract C is A {

    function foo() public virtual override {
        emit Log("C.foo()");
        A.foo();
    }

    function bar() public virtual override {
        emit Log("C.bar()");
        super.bar();
    }

}

contract D is B, C {

    // D -> C -> A
    function foo() public override(B, C) {
        super.foo();
    }

    // D -> C -> B -> A
    function bar() public override(B, C) {
        super.bar();
    }

}
