pragma solidity 0.8.4;

contract Overflow {
    // uint8 (8 bits/1 byte) - max of 255
    uint8 n = 255;

    function add() public returns (uint8) {
        // would return 0 (overflow)
        n = n + 1;
        return n;
    }

    function subtract() public returns (uint8) {
        // would return 255 if n = 0 (underflow)
        n = n - 1;
        return n;
    }
}