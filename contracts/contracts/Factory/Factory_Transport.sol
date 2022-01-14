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
contract TransportFactory is Event, Encode, Constant{
    struct Transport {
        uint        ID;
        string      ShipCompany;
        string      Vehicle;
        string      Status;
        uint32      ReceptionTime;
        uint32      HandoverTime;
        address     TransporterAddress;
        address     MerchandiseAddress;
        address     TransportAddress;
        address     FromAddress;
        address     ToAddress;
    }

    StakePool                     private _Stake = StakePool(StakeContractAddress);
    Transport[]                   internal TransportList;
    mapping(address => Transport) internal AddressToTransport;
    
    function CreateTransport(
        string memory ShipCompany,
        string memory Vehicle,
        string memory Status,
        address       FromAddress,
        address       ToAddress,
        address       MerchandiseAddress
    )
    public
    {
        require(_Stake.StakeForFunction("Transport",msg.sender) == true);
        address TransportAddress = CreateAddress(ShipCompany, Vehicle,  uint32(block.timestamp), msg.sender, TransportList.length);
        Transport memory NewTransport = Transport(TransportList.length, ShipCompany, Vehicle, Status, uint32(block.timestamp), 0, msg.sender, MerchandiseAddress, TransportAddress,FromAddress, ToAddress);
        TransportList.push(NewTransport);
        AddressToTransport[TransportAddress] = NewTransport;
        emit NewEvent(msg.sender, TransportAddress);
    }
    
    function ChangeStatusTransport(
        string memory Status,
        address        TransportAddress
    )
    public
    {
        require(_Stake.StakeForFunction("Transport",msg.sender) == true);
        require(msg.sender == AddressToTransport[TransportAddress].TransporterAddress, "You do not have permission to change the status");
        AddressToTransport[TransportAddress].Status = Status;
        AddressToTransport[TransportAddress].HandoverTime =  uint32(block.timestamp);
        TransportList[AddressToTransport[TransportAddress].ID].Status = Status;
        TransportList[AddressToTransport[TransportAddress].ID].HandoverTime =  uint32(block.timestamp);
        emit NewChangeTransportEvent(Status, msg.sender, TransportAddress);
    }
}