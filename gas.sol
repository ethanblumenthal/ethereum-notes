pragma solidity 0.8.4;

contract Gas {
    uint[] storageArray;
    
    // writing to storage is expensive
    // reading from storage is free
    // save on gas by emitting events
    
    function testGas(uint[] memory memoryArray) public {
        // assign by copy
        // storage => memory && memory => storage
        storageArray = memoryArray; // memoryArray copied to storageArray
        memoryArray.push(4); // won't affect storageArray
        
        // assign by reference
        // memory => memory && storage => storage
        uint[] storage pointerArray = storageArray; // pointerArray points to storageArray
        pointerArray.push(7); // will affect storageArray
    }
}

contract Gastest {
    // most functions that are pure or view (read only) are free to execute
    uint number = 10;
    
    // external is cheaper since inputs are read directly from the function call
    function testExternal(uint[10] calldata numbers) external pure returns (uint) {
        return numbers[0];
    }
    
    // public is more expensive since inputs must be written to memory
    function testPublic(uint[10] memory numbers) public view returns (uint) {
        numbers[0] = number;
        return numbers[0];
    }
}