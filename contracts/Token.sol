// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    mapping(address => bool) public _blocked;

    constructor(uint8 _decimals) public ERC20("yearn.finance test token", "TEST") {
        _setupDecimals(_decimals);
        _mint(msg.sender, 30000 * 10**uint256(_decimals));
    }

    function _setBlocked(address user, bool value) public virtual {
        _blocked[user] = value;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override(ERC20) {
        require(!_blocked[to], "Token transfer refused. Receiver is on blacklist");
        super._beforeTokenTransfer(from, to, amount);
    }

    function transferWithoutReturn(address recipient, uint256 amount) public {
        super.transfer(recipient, amount);
    }

    function transferFromWithoutReturn(
        address sender,
        address recipient,
        uint256 amount
    ) public {
        super.transferFrom(sender, recipient, amount);
    }

    function approveWithoutReturn(address spender, uint256 amount) public {
        super.approve(spender, amount);
    }
}
