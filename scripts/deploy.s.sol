// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "./UsingDiamondDeployer.sol";

contract Deploy is Script, UsingDiamondDeployer {
	function run() external {
		address[] memory minters = new address[](1);
		minters[0] = vm.addr(uint256(vm.envBytes32("PRIVATE_KEY")));
		vm.startBroadcast();
		new ERC721Facet("TEST", "TEST");
		// deployDiamondERC721(minters);
		vm.stopBroadcast();
	}

	function deployDiamondERC721(address[] memory minters) public {
		(, DiamondCutFacet cut) = setupDiamond(minters[0]);

		addERC721Facet(cut, address(new ERC721Facet("TEST_NAME", "TEST_SYMBOL")));
		addMintRoleFacet(cut, address(new MintRoleFacet()));

		for (uint256 i = 0; i < minters.length; i++) {
			MintRoleFacet(address(cut)).setMinter(minters[i], true);
		}
	}
}
