// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract Ad_Interact{

    struct Interaction{
        address customer;
        string ad_Id;
        uint256 timestamp;
    }

    Interaction[] public interactions;

     event Interacted(address indexed customer, string ad_Id, uint timestamp);

    function logInteraction(string memory ad_Id) public{

        Interaction memory i = Interaction({
            customer: msg.sender,
            ad_Id: ad_Id,
            timestamp: block.timestamp
        });

        interactions.push(i);
        
        emit Interacted(msg.sender, ad_Id, block.timestamp);

    }
    function getInteractions() public view returns(Interaction[] memory){
        return interactions;
    }

}