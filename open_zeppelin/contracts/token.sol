pragma solidity 0.8.4;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    // run constructor that is inherited from ERC20
    constructor () ERC20("MyToken", "MTKN") {

    }
}