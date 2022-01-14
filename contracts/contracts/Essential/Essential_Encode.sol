pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract Encode {
    function CreateAddress(
        string memory ProductName,
        string memory AnotherString,
        uint32        Timestamp,
        address       ManagerAddress,
        uint          ID
    )
    internal
    view
    returns (address)
    {
        require(msg.sender == ManagerAddress);
        bytes20 EncodeData = bytes20(keccak256(abi.encodePacked(ProductName, AnotherString, Timestamp, ManagerAddress, ID)));
        address Address = address(EncodeData);
        return Address;
    }
}