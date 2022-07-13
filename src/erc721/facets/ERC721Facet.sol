// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import "../interfaces/IERC721.sol";
import "../libraries/ERC721Lib.sol";
import "../../utils/Bytes32ToString.sol";
import { UsingMintRole } from "../libraries/MintRoleLib.sol";

/// @notice Modern, minimalist, and gas efficient ERC-721 implementation. Based on Solmate (https://github.com/Rari-Capital/solmate/blob/main/src/tokens/ERC721.sol)
/// @author EIP2325 implementation by DefiCake (https://github.com/DefiCake), based on solmate

contract ERC721Facet is IERC721, UsingMintRole {
	/*//////////////////////////////////////////////////////////////
                         METADATA STORAGE/LOGIC
    //////////////////////////////////////////////////////////////*/

	bytes32 private immutable _symbol;
	bytes32 private immutable _name;

	function tokenURI(uint256 id) public view virtual returns (string memory) {}

	function name() public view virtual returns (string memory) {
		return Bytes32ToString.toString(_name);
	}

	function symbol() public view virtual returns (string memory) {
		return Bytes32ToString.toString(_symbol);
	}

	/*//////////////////////////////////////////////////////////////
                      ERC721 BALANCE/OWNER STORAGE
    //////////////////////////////////////////////////////////////*/

	function ownerOf(uint256 id) public view virtual returns (address owner) {
		require((owner = ERC721Lib.Storage()._ownerOf[id]) != address(0), "NOT_MINTED");
	}

	function balanceOf(address owner) public view virtual returns (uint256) {
		require(owner != address(0), "ZERO_ADDRESS");

		return ERC721Lib.Storage()._balanceOf[owner];
	}

	/*//////////////////////////////////////////////////////////////
                         ERC721 APPROVAL STORAGE
    //////////////////////////////////////////////////////////////*/

	function getApproved(uint256 tokenId) public view returns (address) {
		return ERC721Lib.Storage().getApproved[tokenId];
	}

	function isApprovedForAll(address owner, address operator) public view returns (bool) {
		return ERC721Lib.Storage().isApprovedForAll[owner][operator];
	}

	/*//////////////////////////////////////////////////////////////
                               CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

	constructor(bytes32 __name, bytes32 __symbol) {
		_name = __name;
		_symbol = __symbol;
	}

	/*//////////////////////////////////////////////////////////////
                              ERC721 LOGIC
    //////////////////////////////////////////////////////////////*/

	function approve(address spender, uint256 id) public virtual {
		ERC721Lib.ERC721Storage storage store = ERC721Lib.Storage();

		address owner = store._ownerOf[id];

		require(msg.sender == owner || store.isApprovedForAll[owner][msg.sender], "NOT_AUTHORIZED");

		store.getApproved[id] = spender;

		emit Approval(owner, spender, id);
	}

	function setApprovalForAll(address operator, bool approved) public virtual {
		ERC721Lib.Storage().isApprovedForAll[msg.sender][operator] = approved;

		emit ApprovalForAll(msg.sender, operator, approved);
	}

	function transferFrom(
		address from,
		address to,
		uint256 id
	) public virtual {
		ERC721Lib.ERC721Storage storage store = ERC721Lib.Storage();

		require(from == store._ownerOf[id], "WRONG_FROM");

		require(to != address(0), "INVALID_RECIPIENT");

		require(
			msg.sender == from || store.isApprovedForAll[from][msg.sender] || msg.sender == store.getApproved[id],
			"NOT_AUTHORIZED"
		);

		// Underflow of the sender's balance is impossible because we check for
		// ownership above and the recipient's balance can't realistically overflow.
		unchecked {
			store._balanceOf[from]--;
			store._balanceOf[to]++;
		}

		store._ownerOf[id] = to;

		delete store.getApproved[id];

		emit Transfer(from, to, id);
	}

	function safeTransferFrom(
		address from,
		address to,
		uint256 id
	) public virtual {
		transferFrom(from, to, id);

		require(
			to.code.length == 0 ||
				ERC721TokenReceiver(to).onERC721Received(msg.sender, from, id, "") ==
				ERC721TokenReceiver.onERC721Received.selector,
			"UNSAFE_RECIPIENT"
		);
	}

	function safeTransferFrom(
		address from,
		address to,
		uint256 id,
		bytes calldata data
	) public virtual {
		transferFrom(from, to, id);

		require(
			to.code.length == 0 ||
				ERC721TokenReceiver(to).onERC721Received(msg.sender, from, id, data) ==
				ERC721TokenReceiver.onERC721Received.selector,
			"UNSAFE_RECIPIENT"
		);
	}

	/*//////////////////////////////////////////////////////////////
                              MINT LOGIC
    //////////////////////////////////////////////////////////////*/

	function mint(address to, uint256 id) external {
		_mint(to, id);
	}

	function safeMint(address to, uint256 id) external {
		_safeMint(to, id);
	}

	function safeMint(
		address to,
		uint256 id,
		bytes calldata data
	) external {
		_safeMint(to, id, data);
	}

	/*//////////////////////////////////////////////////////////////
                        INTERNAL MINT/BURN LOGIC
    //////////////////////////////////////////////////////////////*/

	function _mint(address to, uint256 id) internal virtual onlyMinter {
		require(to != address(0), "INVALID_RECIPIENT");

		ERC721Lib.ERC721Storage storage store = ERC721Lib.Storage();

		require(store._ownerOf[id] == address(0), "ALREADY_MINTED");

		// Counter overflow is incredibly unrealistic.
		unchecked {
			store._balanceOf[to]++;
		}

		store._ownerOf[id] = to;

		emit Transfer(address(0), to, id);
	}

	/// @notice burn disabled
	// function _burn(uint256 id) internal virtual {
	// 	ERC721Lib.ERC721Storage storage store = ERC721Lib.Storage();

	// 	address owner = store._ownerOf[id];

	// 	require(owner != address(0), "NOT_MINTED");

	// 	// Ownership check above ensures no underflow.
	// 	unchecked {
	// 		store._balanceOf[owner]--;
	// 	}

	// 	delete store._ownerOf[id];

	// 	delete store.getApproved[id];

	// 	emit Transfer(owner, address(0), id);
	// }

	/*//////////////////////////////////////////////////////////////
                        INTERNAL SAFE MINT LOGIC
    //////////////////////////////////////////////////////////////*/

	function _safeMint(address to, uint256 id) internal virtual {
		_mint(to, id);

		require(
			to.code.length == 0 ||
				ERC721TokenReceiver(to).onERC721Received(msg.sender, address(0), id, "") ==
				ERC721TokenReceiver.onERC721Received.selector,
			"UNSAFE_RECIPIENT"
		);
	}

	function _safeMint(
		address to,
		uint256 id,
		bytes memory data
	) internal virtual {
		_mint(to, id);

		require(
			to.code.length == 0 ||
				ERC721TokenReceiver(to).onERC721Received(msg.sender, address(0), id, data) ==
				ERC721TokenReceiver.onERC721Received.selector,
			"UNSAFE_RECIPIENT"
		);
	}
}

/// @notice A generic interface for a contract which properly accepts ERC721 tokens.
/// @author Solmate (https://github.com/Rari-Capital/solmate/blob/main/src/tokens/ERC721.sol)
interface ERC721TokenReceiver {
	function onERC721Received(
		address,
		address,
		uint256,
		bytes calldata
	) external returns (bytes4);
}
