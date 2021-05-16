pragma solidity 0.8.4;

contract HelloWorld {
    string message = "Hello world";

    // setter functions create a transaction on the blockchain
    function setMessage(string memory newMessage) public {
        message = newMessage;
    }

    // getter functions make a call to the blockchain (read-only)
    function hello() public view returns (string memory) {
        return message;
    }

    // all functions in truffle take in an options argument
    // value and from are the two most common parameters
}