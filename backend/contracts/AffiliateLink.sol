// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AffiliateLink {
    address public owner;

    struct Affiliate {
        address affiliateAddress;
        uint256 totalClicks;
        uint256 totalPurchases;
    }

    mapping(bytes32 => Affiliate) public affiliates;
    mapping(bytes32 => bool) public linkExists;

    event AffiliateLinkCreated(bytes32 indexed linkHash, address indexed affiliateAddress);
    event LinkClicked(bytes32 indexed linkHash, address indexed userAddress);
    event PurchaseMade(bytes32 indexed linkHash, address indexed userAddress, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function createAffiliateLink(bytes32 linkHash, address affiliateAddress) external onlyOwner {
        require(!linkExists[linkHash], "Link already exists");

        affiliates[linkHash] = Affiliate({
            affiliateAddress: affiliateAddress,
            totalClicks: 0,
            totalPurchases: 0
        });
        
        linkExists[linkHash] = true;

        emit AffiliateLinkCreated(linkHash, affiliateAddress);
    }

    function trackClick(bytes32 linkHash, address userAddress) external onlyOwner {
        require(linkExists[linkHash], "Link does not exist");

        affiliates[linkHash].totalClicks += 1;

        emit LinkClicked(linkHash, userAddress);
    }

    function trackPurchase(bytes32 linkHash, address userAddress, uint256 amount) external onlyOwner {
        require(linkExists[linkHash], "Link does not exist");

        affiliates[linkHash].totalPurchases += 1;

        emit PurchaseMade(linkHash, userAddress, amount);
    }

    function getAffiliateStats(bytes32 linkHash) external view returns (address, uint256, uint256) {
        require(linkExists[linkHash], "Link does not exist");
        
        Affiliate memory affiliate = affiliates[linkHash];
        return (affiliate.affiliateAddress, affiliate.totalClicks, affiliate.totalPurchases);
    }
}
