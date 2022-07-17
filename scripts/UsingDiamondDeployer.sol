// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Diamond } from "../src/diamond/Diamond.sol";
import { DiamondCutFacet, IDiamondCut } from "../src/diamond/facets/DiamondCutFacet.sol";
import { DiamondLoupeSelectors } from "../src/diamond/interfaces/IDiamondLoupe.sol";
import { DiamondLoupeFacet } from "../src/diamond/facets/DiamondLoupeFacet.sol";

import { OwnershipFacet } from "../src/diamond/facets/OwnershipFacet.sol";
import { ERC165Facet } from "../src/diamond/facets/ERC165Facet.sol";
import { ERC721Facet } from "../src/erc721/facets/ERC721Facet.sol";
import { MintRoleFacet } from "../src/erc721/facets/MintRoleFacet.sol";

import { ERC721Selectors } from "../src/erc721/interfaces/IERC721.sol";
import { MinterRoleSelectors } from "../src/erc721/interfaces/IMinterRole.sol";
import { ERC173Selectors } from "../src/diamond/interfaces/IERC173.sol";
import { ERC165Selectors } from "../src/diamond/interfaces/IERC165.sol";

contract UsingDiamondDeployer {
	function setupDiamond(address deployer) internal returns (Diamond diamond, DiamondCutFacet) {
		diamond = new Diamond(deployer, address(new DiamondCutFacet()));
		DiamondCutFacet cut = DiamondCutFacet(address(diamond));

		addLoupeFacet(cut, address(new DiamondLoupeFacet()));
		addOwnershipFacet(cut, address(new OwnershipFacet()));
		addERC165Facet(cut, address(new ERC165Facet()));
		return (diamond, cut);
	}

	function addLoupeFacet(DiamondCutFacet cut, address loupe) internal {
		DiamondCutFacet.FacetCut[] memory initialFacets = new DiamondCutFacet.FacetCut[](1);

		bytes4[] memory selectors = DiamondLoupeSelectors.getSelectors();

		initialFacets[0] = IDiamondCut.FacetCut(loupe, IDiamondCut.FacetCutAction.Add, selectors);

		cut.diamondCut(initialFacets, address(0), bytes(""));
	}

	function addERC721Facet(DiamondCutFacet cut, address erc721Facet) internal {
		DiamondCutFacet.FacetCut[] memory facets = new DiamondCutFacet.FacetCut[](1);

		bytes4[] memory selectors = ERC721Selectors.getSelectors();

		facets[0] = IDiamondCut.FacetCut(erc721Facet, IDiamondCut.FacetCutAction.Add, selectors);

		cut.diamondCut(facets, address(0), bytes(""));
	}

	function addMintRoleFacet(DiamondCutFacet cut, address facet) internal {
		DiamondCutFacet.FacetCut[] memory facets = new DiamondCutFacet.FacetCut[](1);

		bytes4[] memory selectors = MinterRoleSelectors.getSelectors();

		facets[0] = IDiamondCut.FacetCut(facet, IDiamondCut.FacetCutAction.Add, selectors);

		cut.diamondCut(facets, address(0), bytes(""));
	}

	function addOwnershipFacet(DiamondCutFacet cut, address facet) internal {
		DiamondCutFacet.FacetCut[] memory facets = new DiamondCutFacet.FacetCut[](1);

		bytes4[] memory selectors = ERC173Selectors.getSelectors();

		facets[0] = IDiamondCut.FacetCut(facet, IDiamondCut.FacetCutAction.Add, selectors);

		cut.diamondCut(facets, address(0), bytes(""));
	}

	function addERC165Facet(DiamondCutFacet cut, address facet) internal {
		DiamondCutFacet.FacetCut[] memory facets = new DiamondCutFacet.FacetCut[](1);

		bytes4[] memory selectors = ERC165Selectors.getSelectors();

		facets[0] = IDiamondCut.FacetCut(facet, IDiamondCut.FacetCutAction.Add, selectors);

		cut.diamondCut(facets, address(0), bytes(""));
	}
}
