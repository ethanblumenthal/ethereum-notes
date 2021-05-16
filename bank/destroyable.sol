pragma solidity 0.8.4;

import "./ownable.sol";

contract Destroyable is Ownable {
    function destroy() public onlyOwner {
        address reciever = msg.sender;
        selfdestruct(payable(reciever));
    }
}