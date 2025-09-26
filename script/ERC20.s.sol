// SPDX-License-Identifier:MIT
pragma solidity ^0.8.29;

import {Script} from "forge-std/Script.sol";
import {ERC20} from "../src/ERC20.sol";

contract ERC20Script is Script {
    ERC20 public stablecoin;

    function setUp() public {
    }

    function run() public {
        vm.startBroadcast();

        stablecoin=new ERC20(10000, 6, "Naira", "NGN");

        vm.stopBroadcast();
    }
}
