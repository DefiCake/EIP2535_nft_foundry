// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "ds-test/test.sol";
import "./utils/UsingUSDC.sol";
import "forge-std/console.sol";

contract Adder {
	uint256 public st;

	function addTwo(uint256 a) external pure returns (uint256) {
		unchecked {
			return a + 2;
		}
	}

	function set(uint256 value) external {
		st = value;
	}

	function foo() external view {
		require(msg.sender == address(1), "wrong caller");
	}
}

contract ContractTest is DSTest, UsingUSDC {
	Vm vm = Vm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

	Adder private adder;

	function setUp() public {
		adder = new Adder();
		usdc = USDC(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
	}

	function testExample() public {
		adder.addTwo(6);
		emit log_named_decimal_uint("balance", 2e20, 18);
		assertTrue(true);
	}

	function testFuzzy(uint256 b) public {
		unchecked {
			assertEq(adder.addTwo(b), b + 2);
		}
	}

	function testSet(uint256 value) external {
		adder.set(value);
		assertEq(adder.st(), value);
	}

	function testSet2() external {
		assertEq(adder.st(), 0);
	}

	function testFailFoo() external view {
		adder.foo();
	}

	function testFoo2Revert() external {
		vm.expectRevert("wrong caller");
		adder.foo();
	}

	function testFoo() external {
		vm.prank(address(1));
		adder.foo();
	}

	function testForking() external {
		address to = address(1);
		uint256 balancePre = usdc.balanceOf(to);
		mintUsdcTo(to, 50);
		uint256 balanceDelta = usdc.balanceOf(to) - balancePre;
		assertEq(balanceDelta, 50);
	}

	function testForking2() external view {
		console.log("FORKIIIIING2");
	}
}
