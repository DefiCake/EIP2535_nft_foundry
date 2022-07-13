// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC165 {
	/// @notice Query if a contract implements an interface
	/// @param interfaceId The interface identifier, as specified in ERC-165
	/// @dev Interface identification is specified in ERC-165. This function
	///  uses less than 30,000 gas.
	/// @return `true` if the contract implements `interfaceID` and
	///  `interfaceID` is not 0xffffffff, `false` otherwise
	function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

library ERC165Selectors {
	function getSelectors() internal pure returns (bytes4[] memory selectors) {
		selectors = new bytes4[](1);
		selectors[0] = 0x01ffc9a7;
	}
}
