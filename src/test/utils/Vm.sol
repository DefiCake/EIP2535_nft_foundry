// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0;

import "forge-std/Vm.sol";

library HevmLib {
	address public constant HEVM_ADDRESS = address(bytes20(uint160(uint256(keccak256("hevm cheat code")))));

	Vm public constant vm = Vm(HEVM_ADDRESS);
}
