
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ChainlordsUR is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;
    uint256 public constant MINT_PRICE = 0.12 ether;
    string public baseURI;
    mapping(address => bool) public hasMinted;

    constructor(string memory _baseURI) ERC721("Bitcoin CTO Chainlords", "CTO-UR") {
        tokenCounter = 0;
        baseURI = _baseURI;
    }

    function mintTo(address recipient, string memory tokenURI) public onlyOwner {
        uint256 tokenId = tokenCounter;
        _safeMint(recipient, tokenId);
        _setTokenURI(tokenId, tokenURI);
        tokenCounter += 1;
    }

    function publicMint() public payable {
        require(!hasMinted[msg.sender], "You have already minted.");
        require(msg.value == MINT_PRICE, "Incorrect ETH amount.");
        
        uint256 tokenId = tokenCounter;
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, string(abi.encodePacked(baseURI, "/", _uint2str(tokenId), ".json")));
        hasMinted[msg.sender] = true;
        tokenCounter += 1;
    }

    function _uint2str(uint256 value) internal pure returns (string memory) {
        if (value == 0) return "0";
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}
