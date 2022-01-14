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
contract ProcessFactory is Event, Encode, Constant{
    struct Process {
        uint        ID;
        string      CompanyName;
        string      Status;
        string      Image;
        uint32      Timestamp;
        address     MerchandiseAddress;
        address     ManagerAddress;
        address     ProcessAddress;
        address     PrevProcessAddress;
    }

    StakePool                   private _Stake = StakePool(StakeContractAddress);
    Process[]                   public ProcessList;
    mapping(address => Process) public AddressToProcess;
    
    function CreateProcess(
        string memory CompanyName,
        string memory Status,
        string memory Image,
        address       MerchandiseAddress,
        address       PrevProcessAddress
    )
    public
    {
        require(_Stake.StakeForFunction("Process",msg.sender) == true);
        address ProcessAddress = CreateAddress(CompanyName, Image,  uint32(block.timestamp), msg.sender, ProcessList.length);
        Process memory NewProcess = Process(ProcessList.length, CompanyName, Status, Image,  uint32(block.timestamp), MerchandiseAddress, msg.sender, ProcessAddress, PrevProcessAddress);
        ProcessList.push(NewProcess);
        AddressToProcess[ProcessAddress] = NewProcess;
        emit NewEvent(msg.sender, ProcessAddress);
    }
}