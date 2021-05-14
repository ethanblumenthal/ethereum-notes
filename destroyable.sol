pragma solidity 0.8.4;

import "./ownable.sol";

contract Destroyable is Ownable {
    function destroy() public onlyOwner {
        address payable reciever = msg.sender;
        selfdestruct(reciever);
    }
}