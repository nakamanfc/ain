// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import '../Essential/Essential_SafeMath.sol';
import '../Essential/Essential_Event.sol';
import '../Token/Token_Mew.sol';

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract StakePool is Event {
    MewToken                                    public _MewToken;
    uint                                        public StakeValue;
    address                                     public StakeWallet;
    address                                     public StakeAddress;
    address[]                                   public Staker;
    mapping(address => Pool)                    public AddressToPool;
    mapping(address => bool)                    public AddressToBool;
    mapping(string => mapping(address => bool)) public TypeAndAddressToBool;
    
    constructor(MewToken mewtoken){
        _MewToken = mewtoken;
        StakeWallet = address(this);
        StakeValue = 10000 * 10 ** 18;
    }
    
    struct Pool {
        address StakerAddress;
        string  Type;
        uint    StakeValue;
        uint32  StartTime;
        uint32  EndTime;
        bool    Status;
    }
    
    function Staking(string memory Type)
    external
    {
        require(AddressToBool[msg.sender] == false);
        _MewToken.transferFrom(msg.sender, StakeWallet, StakeValue);
        Pool memory NewPool = Pool(msg.sender, Type, StakeValue, uint32(block.timestamp), 0, true);
        AddressToPool[msg.sender] = NewPool;
        Staker.push(msg.sender);
        TypeAndAddressToBool[Type][msg.sender] = true;
        AddressToBool[msg.sender] = true;
        emit Stake(msg.sender, uint32(block.timestamp), StakeValue);
    }
    
    function UnStaking()
    external
    {
        require(msg.sender == AddressToPool[msg.sender].StakerAddress);
        require(AddressToPool[msg.sender].Status == true);
        AddressToPool[msg.sender].EndTime = uint32(block.timestamp);
        AddressToPool[msg.sender].Status = false;
        TypeAndAddressToBool[AddressToPool[msg.sender].Type][msg.sender] = false;
        AddressToBool[msg.sender] = false;
        _MewToken.transfer(msg.sender, AddressToPool[msg.sender].StakeValue);
        emit UnStake(msg.sender, uint32(block.timestamp), AddressToPool[msg.sender].StakeValue);
    }
    
    function StakeForFunction(
        string memory Type,
        address       StakerAddress
    )
    external
    view
    returns(bool)
    {
        return TypeAndAddressToBool[Type][StakerAddress];
    }
}




















