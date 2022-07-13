// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import { IERC165 } from "../interfaces/IERC165.sol";

/// @notice Modern, minimalist, and gas efficient ERC-721 implementation. Based on Solmate (https://github.com/Rari-Capital/solmate/blob/main/src/tokens/ERC721.sol)
/// @author EIP2325 implementation by DefiCake (https://github.com/DefiCake), based on solmate

contract ERC165Facet is IERC165 {
	function supportsInterface(bytes4 interfaceId) external pure returns (bool) {
		return
			interfaceId == 0x01ffc9a7 || // ERC165 Interface ID for ERC165
			interfaceId == 0x80ac58cd || // ERC165 Interface ID for ERC721
			interfaceId == 0x7f5828d0 || // ERC165 Interface ID for ERC173
			interfaceId == 0x5b5e139f; // ERC165 Interface ID for ERC721Metadata
	}
}
