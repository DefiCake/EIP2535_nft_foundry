// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "forge-std/console.sol";
import "ds-test/test.sol";
import "./Vm.sol";

interface USDC is IERC20 {
	function masterMinter() external view returns (address);

	function configureMinter(address minter, uint256 allowed) external;

	function mint(address to, uint256 amount) external;
}

contract UsingUSDC {
	USDC public usdc;

	function mintUsdcTo(address to, uint256 amount) public {
		address minter = usdc.masterMinter();
		HevmLib.vm.prank(minter);
		usdc.configureMinter(address(this), type(uint256).max);
		usdc.mint(to, amount);
		console.log("Minted USDC to", to, amount);
	}
}
