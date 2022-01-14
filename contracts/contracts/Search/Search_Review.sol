// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "../Factory/Factory_Review.sol";

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract ReviewSearch is ReviewFactory{
    function SearchReviewByAddress(
        address Address
    )
    public
    view
    returns(Review memory)
    {
        return AddressToReview[Address];
    }
    
    function SearchReviewByReviewerAddress(
        address ReviewerAddress
    )
    public
    view
    returns(uint[] memory)
    {
        uint ReviewAmount = ReviewList.length;
        uint ManagerReviewAmount = 0;
        uint Count = 0;
        
        for(uint i = 0; i < ReviewAmount; i++){
            if(ReviewList[i].ReviewerAddress == ReviewerAddress){
                ManagerReviewAmount++;
            }
        }
        
        uint[] memory result = new uint[](ManagerReviewAmount);
        
        for(uint i = 0; i < ReviewAmount; i++){
            if(ReviewList[i].ReviewerAddress == ReviewerAddress){
                result[Count] = i;
                Count++;
            }
        }
        
        return result;
    }
    
    function SearchReviewByID(
        uint ID
    )
    public
    view
    returns(Review memory)
    {
        return ReviewList[ID];
    }
}