pragma solidity 0.8.4;

import "./ownable.sol"

contract Bank is Ownable {
    // storage - permanent storage of data (state variables)
    // memory - temporary storage used in function execution
    // calldata - save arguments/inputs to our functions
    // complex ds - strings, arrays, mappings, structs
    
    mapping(address => uint) balance;
    address owner;
    // events are used for logging to the evm
    // and gives frontends the ability to hook into changes
    // indexed parameter allows logs to be searchable over time
    event depositDone(uint indexed amount, address indexed depositedTo);
    
    // modifiers are similar to middlewares or decorators
    modifier onlyOwner {
        require(msg.sender == owner);
        _; // run the function
    }
    
    constructor() {
        owner = msg.sender;
    }
    
    // payble keyword lets the function receive money
    function deposit() public payable returns(uint) {
        balance[msg.sender] += msg.value;
        emit depositDone(msg.value, msg.sender);
        return balance[msg.sender];
    }
    
    function withdraw(uint amount) public returns (uint) {
        require(balance[msg.sender] >= amount);
        balance[msg.sender] -= amount;
        
        // msg.sender is an address
        msg.sender.transfer(amount);
        return balance[msg.sender];
    }
    
    function getBalance() public view returns (uint) {
        return balance[msg.sender];
    }
    
    function transfer(address recipient, uint amount) public {
        require(balance[msg.sender] >= amount, "Balance not sufficient");
        require(msg.sender != recipient, "Don't transfer money to yourself");
        
        uint previousSenderBalance = balance[msg.sender];
        _transfer(msg.sender, recipient, amount);
        
        assert(balance[msg.sender] == previousSenderBalance - amount);
    }
    
    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }
}