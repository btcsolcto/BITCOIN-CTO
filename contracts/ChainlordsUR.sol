
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ChainlordsUR is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;

    constructor() ERC721("Bitcoin CTO Chainlords", "CTO-UR") {
        tokenCounter = 0;
    }

    function mintTo(address recipient, string memory tokenURI) public onlyOwner {
        uint256 tokenId = tokenCounter;
        _safeMint(recipient, tokenId);
        _setTokenURI(tokenId, tokenURI);
        tokenCounter += 1;
    }
}
