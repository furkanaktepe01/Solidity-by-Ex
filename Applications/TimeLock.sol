pragma solidity ^0.8.13;

contract TimeLock {

    error NotOwnerError();
    error AlreadyQueuedError(bytes32 txId);
    error TimestampNotInRangeError(uint blockTimestamp, uint timestamp);
    error NotQueuedError(bytes32 txId);
    error TimestampNotPassedError(uint blockTimestamp, uint timestamp);
    error TimestampExpiredError(uint blockTimestamp, uint expiresAt);
    error TxFailedError(bytes32 txId);

    event Queue(bytes32 indexed txId, address indexed target, uint value, string func, bytes data, uint timestamp);
    event Execute(bytes32 indexed txId, address indexed target, uint value, string func, bytes data, uint timestamp);
    event Cancel(bytes32 indexed txId);

    uint public constant MIN_DELAY = 10;
    uint public constant MAX_DELAY = 1000;
    uint public constant GRACE_PERIOD = 1000;

    address public owner;

    mapping(bytes32 => bool) public queued;

    constructor() {

        owner = msg.sender;
    }

    modifier onlyOwner() {

        if (msg.sender != owner) {

            revert NotOwnerError();
        }

        _;
    }

    receive() external payable { }

    function getTxId(address _target, uint _value, string calldata _function, bytes calldata _data, uint _timestamp) public pure returns (bytes32) {

        return keccak256(abi.encode(_target, _value, _function, _data, _timestamp));
    }

    function queue(address _target, uint _value, string calldata _function, bytes calldata _data, uint _timestamp) external onlyOwner returns (bytes32 txId) {

        txId = getTxId(_target, _value, _function, _data, _timestamp);

        if (queued[txId]) {

            revert AlreadyQueuedError(txId);
        }

        if (_timestamp < block.timestamp + MIN_DELAY || _timestamp > block.timestamp + MAX_DELAY) {

            revert TimestampNotInRangeError(block.timestamp, _timestamp);
        }

        queued[txId] = true;

        emit Queue(txId, _target, _value, _function, _data, _timestamp);
    }

    function execute(address _target, uint _value, string calldata _function, bytes calldata _data, uint _timestamp) external payable onlyOwner returns (bytes memory) {

        bytes32 txId = getTxId(_target, _value, _function, _data, _timestamp);

        if (!queued[txId]) {

            revert NotQueuedError(txId);
        }

        if (block.timestamp < _timestamp) {

            revert TimestampNotPassedError(block.timestamp, _timestamp);
        }

        if (block.timestamp > _timestamp + GRACE_PERIOD) {

            revert TimestampExpiredError(block.timestamp, _timestamp + GRACE_PERIOD);
        }

        queued[txId] = false;

        bytes memory data;

        if (bytes(_function).length > 0) {

            data = abi.encodePacked(bytes4(keccak256(bytes(_function))), _data);
        
        } else {

            data = _data;
        }

        (bool success, bytes memory result) = _target.call{ value: _value }(data);

        if (!success) {

            revert TxFailedError(txId);
        }

        emit Execute(txId, _target, _value, _function, _data, _timestamp);

        return result;
    }

    function cancel(bytes32 _txId) external onlyOwner {

        if (!queued[_txId]) {

            revert NotQueuedError(_txId);
        }

        queued[_txId] = false;

        emit Cancel(_txId);
    }

}
