// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library ERC721Lib {
	bytes32 constant STORAGE_POSITION = keccak256("eth.erc721.storage");

	struct ERC721Storage {
		uint256 totalSupply;
		mapping(uint256 => address) _ownerOf;
		mapping(address => uint256) _balanceOf;
		mapping(uint256 => address) getApproved;
		mapping(address => mapping(address => bool)) isApprovedForAll;
		mapping(uint256 => string) tokenUri;
	}

	function Storage() internal pure returns (ERC721Storage storage ds) {
		bytes32 position = STORAGE_POSITION;
		assembly {
			ds.slot := position
		}
	}
}
