// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

import "../diamond/libraries/LibDiamond.sol";

contract UsingDiamondOwner {
	modifier onlyOwner() {
		LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
		require(msg.sender == ds.contractOwner, "NOT_OWNER");
		_;
	}
}
