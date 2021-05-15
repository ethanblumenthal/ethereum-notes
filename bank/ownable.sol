pragma solidity 0.8.4;

contract Ownable {
    // public keyword on a state variable creates a getter
    // internal allows for use by the contract itself
    // and contracts that inherit from the contract
    address internal owner;
    
    // modifiers are similar to middlewares or decorators
    modifier onlyOwner {
        require(msg.sender == owner);
        _; // run the function
    }
    
    constructor() {
        owner = msg.sender;
    }
}