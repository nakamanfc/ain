// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "../Essential/Essential_Event.sol";
import "../Essential/Essential_Encode.sol";

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract ReviewFactory is Event, Encode{
    struct Review {
        uint        ID;
        string      Comment;
        uint8       Rate;
        uint32      Timestamp;
        address     ServiceAddress;
        address     ReviewerAddress;
        address     ReviewAddress;
    }

    Review[]                   public ReviewList;
    mapping(address => Review) public AddressToReview;
    
    function CreateReview(
        string memory Comment,
        uint8         Rate,
        address       ServiceAddress
    )
    public
    {
        address ReviewAddress = CreateAddress(Comment, Comment,  uint32(block.timestamp), msg.sender, ReviewList.length);
        Review memory NewReview = Review(ReviewList.length, Comment, Rate,  uint32(block.timestamp), ServiceAddress, msg.sender, ReviewAddress);
        ReviewList.push(NewReview);
        AddressToReview[ServiceAddress] = NewReview;
        emit NewReviewEvent(msg.sender, ReviewAddress, Comment, Rate);
    }
}