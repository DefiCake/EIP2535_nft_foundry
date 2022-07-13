// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Bytes32ToString {
	function toString(bytes32 source) internal pure returns (string memory result) {
		uint8 length = 0;
		while (source[length] != 0 && length < 32) {
			length++;
		}
		assembly {
			result := mload(0x40)
			// new "memory end" including padding (the string isn't larger than 32 bytes)
			mstore(0x40, add(result, 0x40))
			// store length in memory
			mstore(result, length)
			// write actual data
			mstore(add(result, 0x20), source)
		}
	}
}
