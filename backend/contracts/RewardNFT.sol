// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RewardNFT is ERC721, Ownable {
    uint256 public tokenCounter;

    mapping(address => uint256[]) public userNFTs;

    event NFTIssued(address indexed user, uint256 indexed tokenId);

    constructor() ERC721("RewardNFT", "RNFT") {
        tokenCounter = 0;
    }

    function issueNFT(address user) external onlyOwner returns (uint256) {
        uint256 newItemId = tokenCounter;
        _mint(user, newItemId);
        userNFTs[user].push(newItemId);
        tokenCounter += 1;

        emit NFTIssued(user, newItemId);

        return newItemId;
    }

    function getUserNFTs(address user) external view returns (uint256[] memory) {
        return userNFTs[user];
    }
}
