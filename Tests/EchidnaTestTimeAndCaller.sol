pragma solidity ^0.8;

contract EchidnaTestTimeAndCaller {

    bool private pass = true;
    uint private createdAt = block.timestamp;

    function echidna_test_pass() public view returns (bool) {

        return pass;
    }

    function setFail() external {

        uint delay = 7 days;

        require(block.timestamp >= createdAt + delay);

        pass = false;
    }

    address[3] private senders = [
        address(0x10000),
        address(0x20000),
        address(0x00a329C0648769a73afAC7F9381e08fb43DBEA70)
    ];

    address private sender = msg.sender;

    function setSender(address _sender) external {

        require(_sender == msg.sender);

        sender = msg.sender;
    }

    function echidna_test_sender() public view returns (bool) {

        for (uint i; i < 3; i++) {

            if (sender == senders[i]) {
                
                return true;
            }
        }

        return false;
    }

}
