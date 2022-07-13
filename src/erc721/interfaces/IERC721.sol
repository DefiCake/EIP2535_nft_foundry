// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC721 {
	event Transfer(address indexed from, address indexed to, uint256 indexed id);

	event Approval(address indexed owner, address indexed spender, uint256 indexed id);

	event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

	function name() external view returns (string memory);

	function symbol() external view returns (string memory);

	function balanceOf(address owner) external view returns (uint256);

	function ownerOf(uint256 tokenId) external view returns (address);

	function approve(address spender, uint256 id) external;

	function getApproved(uint256 tokenId) external view returns (address);

	function setApprovalForAll(address operator, bool approved) external;

	function isApprovedForAll(address owner, address operator) external view returns (bool);

	function transferFrom(
		address from,
		address to,
		uint256 id
	) external;

	function safeTransferFrom(
		address from,
		address to,
		uint256 id
	) external;

	function safeTransferFrom(
		address from,
		address to,
		uint256 id,
		bytes calldata data
	) external;

	function mint(address to, uint256 id) external;

	function safeMint(address to, uint256 id) external;

	function safeMint(
		address to,
		uint256 id,
		bytes calldata data
	) external;
}

library ERC721Selectors {
	bytes constant encodedSelectors =
		hex"095ea7b3"
		hex"70a08231"
		hex"081812fc"
		hex"e985e9c5"
		hex"40c10f19"
		hex"06fdde03"
		hex"6352211e"
		hex"a1448194"
		hex"8832e6e3"
		hex"42842e0e"
		hex"b88d4fde"
		hex"a22cb465"
		hex"95d89b41"
		hex"23b872dd";

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
