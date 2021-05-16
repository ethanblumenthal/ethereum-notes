pragma solidity 0.8.4;

import "./ownable.sol";
import "./SafeMath.sol";

// interface defines function header of external functions
interface GovernmentInterface {
    function addTransaction(address _from, address _to, uint _amount) external payable;
}

// is keyword allows for inheritance
contract Bank is Ownable {
    // uint always defaults to uint256
    using SafeMath for uint;

    // smart contract address holds funds and exposes external functions
    GovernmentInterface governmentInstance;
    
    constructor(address _address) {
        governmentInstance = GovernmentInterface(_address);
    }
    
    // storage - permanent storage of data (state variables)
    // memory - temporary storage used in function execution
    // calldata - save arguments/inputs to our functions
    // complex ds - strings, arrays, mappings, structs
    mapping(address => uint) balance;
    
    // events are used for logging to the evm
    // and gives frontends the ability to hook into changes
    // indexed parameter allows logs to be searchable over time
    event depositDone(uint indexed amount, address indexed depositedTo);
    
    // payble keyword lets the function receive money
    function deposit() public payable returns(uint) {
        balance[msg.sender] += msg.value;
        emit depositDone(msg.value, msg.sender);
        return balance[msg.sender];
    }
    
    function withdraw(uint amount) public onlyOwner returns (uint) {
        require(balance[msg.sender] >= amount);
        balance[msg.sender] -= amount;
        
        // msg.sender is an address
        payable(msg.sender).transfer(amount);
        return balance[msg.sender];
    }
    
    function getBalance() public view returns (uint) {
        return balance[msg.sender];
    }
    
    function getOwner() public view returns (address) {
        return owner;
    }
    
    function transfer(address recipient, uint amount) public {
        require(balance[msg.sender] >= amount, "Balance not sufficient");
        require(msg.sender != recipient, "Don't transfer money to yourself");
        
        uint previousSenderBalance = balance[msg.sender];
        _transfer(msg.sender, recipient, amount);
        
        // value lets a contract send money to an external contract
        governmentInstance.addTransaction{value: 1 ether}(msg.sender, recipient, amount);
        
        assert(balance[msg.sender] == previousSenderBalance - amount);
    }
    
    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }
}