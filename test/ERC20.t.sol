// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

import "forge-std/Test.sol";
import "../src/ERC20.sol";

contract ERC20Test is Test {
    ERC20 token;
    address alice = address(0x1);
    address bob = address(0x2);

    function setUp() public {
        token = new ERC20(1000, 18, "MyToken", "MTK");
    }

    function test_InitialSupplyAssignedToDeployer() public {
        uint256 supply = token.totalSupply();
        assertEq(token.balanceOf(address(this)), supply);
    }

    function test_Transfer() public {
        uint256 amount = 100;
        token.transfer(alice, amount);
        assertEq(token.balanceOf(alice), amount);
        assertEq(token.balanceOf(address(this)), token.totalSupply() - amount);
    }

    function test_ApproveAndAllowance() public {
        token.approve(alice, 200);
        assertEq(token.allowance(address(this), alice), 200);
    }

    function test_TransferFrom() public {
        token.approve(alice, 150);

        vm.prank(alice);
        token.transferFrom(address(this), bob, 100);

        assertEq(token.balanceOf(bob), 100);
        assertEq(token.allowance(address(this), alice), 50);
    }

    function test_FailTransferExceedsBalance() public {
        vm.prank(alice);
        vm.expectRevert();
        token.transfer(bob, 10); // Alice has 0 balance, should revert
    }

    function test_FailTransferFromExceedsAllowance() public {
        token.approve(alice, 10);
        vm.prank(alice);
        vm.expectRevert();
        token.transferFrom(address(this), bob, 20); // exceeds allowance, should revert
    }
}
