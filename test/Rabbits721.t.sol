// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {Rabbits} from "../src/Rabbits721.sol";

contract RabbitsTest is Test {
    Rabbits public rabbits;
    string public baseURI;
    string[] public NFTs;

    function setUp() public {
        baseURI = "https://gateway.decentralizedscience.org/ipfs/";
        rabbits = new Rabbits(address(this), address(this));
        NFTs = [
            "bafybeigdyzwa5ez6mrn3yk97kcrf4qkuuygwgxv3wqhxqjx6m72nzlvpea",
            "bafybeid3d4e3c4a5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6",
            "bafybeif4e3d4a5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6g7",
            "bafybeigdyzwa5ez6mrn3yk97kcrf4qkuuygwgxv3wqhxqjx6m72nzlvpea",
            "bafybeid3d4e3c4a5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6",
            "bafybeif4e3d4a5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6g7",
            "bafybeigdyzwa5ez6mrn3yk97kcrf4qkuuygwgxv3wqhxqjx6m72nzlvpea",
            "bafybeid3d4e3c4a5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6",
            "bafybeif4e3d4a5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6g7",
            "bafybeigdyzwa5ez6mrn3yk97kcrf4qkuuygwgxv3wqhxqjx6m72nzlvpea"
        ];
    }

    function testMint() public {
        rabbits.safeMint(address(0x1), NFTs[0]);
        assertEq(rabbits.ownerOf(0), address(0x1),
                 "Token should be minted to specified address.");
    }

    function testGetURI9() public {
        rabbits.safeMint(address(0x1), NFTs[9]);
        string memory tokenURI = rabbits.tokenURI(0);
        assertEq(tokenURI, string.concat(baseURI, NFTs[9]));
    }

    function test_RevertTokenIndex() public {
        //vm.expectRevert(ERC721NonexistentToken.selector);
        vm.expectRevert();
        rabbits.tokenURI(0);
    }

    function testEnumerableTotalSupply() public {
        string[5] memory mintedNFTs;

        for (uint256 i = 0; i < 5; i++){
            mintedNFTs[i] = NFTs[i];
        }

        for( uint256 i = 0; i < mintedNFTs.length; i++){
            rabbits.safeMint(address(1),mintedNFTs[i]);
        }

        assertEq(mintedNFTs.length, rabbits.totalSupply());
    }

    function testEnumerableTokenByIndex() public {
        for ( uint256 i = 0; i < NFTs.length; i++) {
            rabbits.safeMint(address(1), NFTs[i]);
        }

        assertEq(NFTs.length, rabbits.totalSupply());

        uint256 tokenID = rabbits.tokenByIndex(4);
        assertEq(NFTs[4], NFTs[tokenID]);

        tokenID = rabbits.tokenByIndex(3);
        assertEq(NFTs[3], NFTs[tokenID]);
    }

}
