// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../libraries/MintRoleLib.sol";
import "../../utils/UsingDiamondOwner.sol";
import { IMinterRole } from "../interfaces/IMinterRole.sol";

contract MintRoleFacet is UsingDiamondOwner, IMinterRole {
	function setMinter(address addr, bool isMinter) external override onlyOwner {
		MintRoleLib.Storage().isMinter[addr] = isMinter;
		emit MinterSet(addr, isMinter);
	}

	function getMinter(address addr) external view override returns (bool) {
		return MintRoleLib.Storage().isMinter[addr];
	}

	function getMintRoleAdmin() external view override returns (address) {
		return LibDiamond.diamondStorage().contractOwner;
	}
}
