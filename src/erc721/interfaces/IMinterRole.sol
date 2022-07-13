// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

interface IMinterRole {
	event MinterSet(address indexed addr, bool isMinter);

	function setMinter(address addr, bool isMinter) external;

	function getMinter(address addr) external view returns (bool);

	function getMintRoleAdmin() external view returns (address);
}

library MinterRoleSelectors {
	bytes constant encodedSelectors = hex"739d9662" hex"bc73b641" hex"cf456ae7";

	function getSelectors() internal pure returns (bytes4[] memory selectors) {
		uint256 numberOfSelectors = encodedSelectors.length / 4;
		selectors = new bytes4[](numberOfSelectors);

		for (uint256 i = 0; i < numberOfSelectors; i++) {
			uint256 start = i * 4;
			selectors[i] =
				bytes4(encodedSelectors[start]) |
				(bytes4(encodedSelectors[start + 1]) >> 8) |
				(bytes4(encodedSelectors[start + 2]) >> 16) |
				(bytes4(encodedSelectors[start + 3]) >> 24);
		}
	}
}
