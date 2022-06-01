// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Contract is ERC20("Test", "Test") {
    function mint(uint256 amount) external {
        _mint(msg.sender, amount);
    }
}
