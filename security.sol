pragma solidity 0.8.4;

// re-entrency attacks occur when a contract's fallback function
// continually calls another contract's withdraw function
// pattern => checks, effects (changing state), interactions

contract Security {
    mapping(address => uint) balance;

    // ethereum introduced send and transfer functions
    // with 2300 gas stipend limit for fallbacks
    // as a counter to re-entrency attacks

    // EIP1884 changed the cost of operations which
    // enables possible security issues in the future

    function withDraw() public {
        require(balance[msg.sender] > 0);
        uint toTransfer = balance[msg.sender]; // checks
        balance[msg.sender] = 0; // effects
        
        // currently best way to send money // interactions
        (bool success,) = msg.sender.call{value: toTransfer}("");

        if (!success) {
            balance[msg.sender] = toTransfer;
        }
    }
}

contract Attack {
    function start() public {
        // deposit funds to bank
        // call to withDraw()
    }

    // runs whenever a contract receives value or is called with no data
    receive() external payable {}

    // runs when another contract calls a function that does not exist
    fallback() external payable { }
}