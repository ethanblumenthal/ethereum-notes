pragma solidity 0.8.4;

contract Ownable {
    // public keyword on a state variable creates a getter
    address public owner;
    
    // modifiers are similar to middlewares or decorators
    modifier onlyOwner {
        require(msg.sender == owner);
        _; // run the function
    }
    
    constructor() {
        owner = msg.sender;
    }
}