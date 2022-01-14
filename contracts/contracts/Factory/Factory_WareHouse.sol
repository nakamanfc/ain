// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "../Essential/Essential_Event.sol";
import "../Essential/Essential_Encode.sol";
import "../Essential/Essential_Constant.sol";
import "../Stake/Stake_Staking.sol";

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract WareHouseFactory is Event, Encode, Constant{
    struct WareHouse {
        uint        ID;
        uint32      TimeStamp;
        string      CompanyName;
        string      Status;
        string      Image;
        address     MerchandiseAddress;
        address     ManagerAddress;
        address     WareMerchandiseAddress;
        address     PrevProcessAddress;
    }

    StakePool                     private _Stake = StakePool(StakeContractAddress);
    WareHouse[]                   public WareHouseList;
    mapping(address => WareHouse) public AddressToWareHouse;
    
    function CreateWareHouse(
        string memory CompanyName,
        string memory Status,
        string memory Image,
        address       MerchandiseAddress,
        address       PrevProcessAddress
    )
    public
    {
        require(_Stake.StakeForFunction("WareHouse",msg.sender) == true);
        address WareMerchandiseAddress = CreateAddress(CompanyName, Image, uint32(block.timestamp), msg.sender, WareHouseList.length);
        WareHouse memory NewWareHouse = WareHouse(WareHouseList.length, uint32(block.timestamp), CompanyName, Status, Image, MerchandiseAddress, msg.sender, WareMerchandiseAddress, PrevProcessAddress);
        WareHouseList.push(NewWareHouse);
        AddressToWareHouse[WareMerchandiseAddress] = NewWareHouse;
        emit NewEvent(msg.sender, WareMerchandiseAddress);
    }
}