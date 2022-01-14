// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "../Factory/Factory_Process.sol";

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract ProcessSearch is ProcessFactory{
    function SearchProcessByAddress(
        address Address
    )
    public
    view
    returns(Process memory)
    {
        return AddressToProcess[Address];
    }
    
    function SearchProcessByManagerAddress(
        address ManagerAddress
    )
    public
    view
    returns(uint[] memory)
    {
        uint ProcessAmount = ProcessList.length;
        uint ManagerProcessAmount = 0;
        uint Count = 0;
        
        for(uint i = 0; i < ProcessAmount; i++){
            if(ProcessList[i].ManagerAddress == ManagerAddress){
                ManagerProcessAmount++;
            }
        }
        
        uint[] memory result = new uint[](ManagerProcessAmount);
        
        for(uint i = 0; i < ProcessAmount; i++){
            if(ProcessList[i].ManagerAddress == ManagerAddress){
                result[Count] = i;
                Count++;
            }
        }
        
        return result;
    }
    
    function SearchProcessByID(
        uint ID
    )
    public
    view
    returns(Process memory)
    {
        return ProcessList[ID];
    }
}