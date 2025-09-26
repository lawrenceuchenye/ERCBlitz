// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

import "forge-std/Test.sol";
import "../src/ERC165.sol";

contract MyContractTest is Test {
    MyContract myContract;

    function setUp() public {
        myContract = new MyContract();
    }

    function test_SupportsERC165() public {
        // ERC165 interface ID is always 0x01ffc9a7
        bytes4 ERC165_ID = 0x01ffc9a7;
        bool result = myContract.supportsInterface(ERC165_ID);
        assertTrue(result, "Contract should support ERC165");
    }

    function test_SupportsIMyInterface() public {
        // Compute interface ID same way Solidity does
        bytes4 fooSelector = bytes4(keccak256("foo()"));
        bytes4 barSelector = bytes4(keccak256("bar(uint256)"));
        bytes4 IMyInterface_ID = fooSelector ^ barSelector;

        bool result = myContract.supportsInterface(IMyInterface_ID);
        assertTrue(result, "Contract should support IMyInterface");
    }

    function test_DoesNotSupportRandomId() public {
        bytes4 randomId = 0x12345678;
        bool result = myContract.supportsInterface(randomId);
        assertFalse(result, "Contract should not support random interface");
    }
}
