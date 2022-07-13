// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library MintRoleLib {
	bytes32 constant STORAGE_POSITION = keccak256("eth.mintrole.storage");

	struct MintRoleStorage {
		mapping(address => bool) isMinter;
	}

	function Storage() internal pure returns (MintRoleStorage storage ds) {
		bytes32 position = STORAGE_POSITION;
		assembly {
			ds.slot := position
		}
	}
}

contract UsingMintRole {
	modifier onlyMinter() {
		require(MintRoleLib.Storage().isMinter[msg.sender], "NOT_MINTER");
		_;
	}
}
