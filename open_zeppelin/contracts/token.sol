pragma solidity 0.8.4;

import "../node_modules/@openzeppelin/contracts/access/AccessControl.sol";
import "../node_modules/@openzeppelin/contracts/utils/Context.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "../node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol";

contract MyToken is Context, AccessControl, ERC20Burnable, ERC20Pausable {
    using SafeMath for uint256;

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant CAP_ROLE = keccak256("CAP_ROLE");

    uint256 private _cap;
    
    // run constructor that is inherited from ERC20
    constructor(string memory name, string memory symbol, uint256 cap_) public ERC20(name, symbol) {
        // grants roles to the account that deployed the contract
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _setupRole(MINTER_ROLE, _msgSender());
        _setupRole(PAUSER_ROLE, _msgSender());
        _setupRole(CAP_ROLE, _msgSender());

        // set cap
        require(cap_ > 0, "ERC20Capped: cap is 0");
        _cap = cap_;
    }

    // returns the cap on the token's total supply
    function cap() public view virtual returns (uint256) {
        return _cap;
    }

    // changes the cap on the token's total supply
    function setCap(uint256 cap_) public virtual {
        require(hasRole(CAP_ROLE, _msgSender()), "ERC20PresetMinterPauser: must have cap role to set cap");
        require(cap_ > 0, "ERC20Capped: cap is 0");
        _cap = cap_;
    }

    // creates amount `new` tokens for `to`
    function mint(address to, uint256 amount) public virtual {
        require(hasRole(MINTER_ROLE, _msgSender()), "ERC20PresetMinterPauser: must have minter role to mint");
        _mint(to, amount);
    }

    // pauses all token transfers
    function pause() public virtual {
        require(hasRole(PAUSER_ROLE, _msgSender()), "ERC20PresetMinterPauser: must have pauser role to pause");
        _pause();
    }

    // unpauses all token transfers
    function unpause() public virtual {
        require(hasRole(PAUSER_ROLE, _msgSender()), "ERC20PresetMinterPauser: must have pauser role to unpause");
        _unpause();
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override(ERC20, ERC20Pausable) {
        super._beforeTokenTransfer(from, to, amount);

        if (from == address(0)) {
            require(totalSupply().add(amount) <= cap(), "ERC20Capped: cap exceeded");
        }
    }
}