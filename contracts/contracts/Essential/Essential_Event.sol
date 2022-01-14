// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract Event {
    event NewEvent(
        address     Manager,
        address     Genesis
    );
    
    event NewChangeTransportEvent(
        string      Status,
        address     Transporter,
        address     TransportAddress
    );
    
    event NewReviewEvent(
        address     Reviewer,
        address     Review,
        string      Comment,
        uint8       rate
    );
    
    event Stake(
        address StakerAddress,
        uint32  TimeStamp,
        uint    Amount
    );
    
    event UnStake(
        address StakerAddress,
        uint32  TimeStamp,
        uint    Amount
    );
}