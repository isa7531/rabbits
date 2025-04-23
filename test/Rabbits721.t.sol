// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {Rabbits} from "../src/Rabbits721.sol";

contract RabbitsTest is Test {
    Rabbits public rabbits;
    string public baseURI;

    function setUp() public {
        baseURI = "https://gateway.decentralizedscience.org/ipfs/";
        rabbits = new Rabbits(address(this), address(this));
    }

    function testMint() public {
        rabbits.safeMint(address(0x1), "abc");
        assertEq(rabbits.ownerOf(0), address(0x1),
                 "Token should be minted to specified address.");
    }
}
