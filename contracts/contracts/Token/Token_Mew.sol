// SPDX-License-Identifier: GPL-3.0\

pragma solidity >=0.7.0 <0.9.0;
import '../Essential/Essential_SafeMath.sol';
import '../Essential/Essential_Erc20.sol';

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract MewToken is Erc20 {
    using SafeMath for uint;
    
    string  public constant override name = 'MewSuppyChain';
    string  public constant override symbol = 'Mew';
    uint8   public constant override decimals = 18;
    uint    public          override totalSupply;
    
    mapping(address => uint)                     public override balanceOf;
    mapping(address => mapping(address => uint)) public override allowance;

    constructor() {
        totalSupply = 1000000000000000000000000000000;
        balanceOf[msg.sender] = 1000000000000000000000000000000;
    }
    
    function _approve(
        address owner,
        address spender,
        uint value
    )
    private
    {
        allowance[owner][spender] = value;
        emit Approval(owner, spender, value);
    }
    
    function _transfer(
        address from,
        address to,
        uint value
    )
    private
    {
        require(balanceOf[from] >= value);
        balanceOf[from] = balanceOf[from].sub(value);
        balanceOf[to] = balanceOf[to].add(value);
        emit Transfer(from, to, value);
    }
    
    function approve(
        address spender,
        uint value
    )
    external
    override
    returns (bool)
    {
        _approve(msg.sender, spender, value);
        return true;
    }
    
    function transfer(
        address to,
        uint value
    )
    external
    override
    returns (bool) {
        _transfer(msg.sender, to, value);
        return true;
    }
    
    function transferFrom(
        address from,
        address to,
        uint value
    )
    external
    override
    returns (bool){
        require(value <= balanceOf[from]);
        require(value <= allowance[from][msg.sender]);
        allowance[from][msg.sender] = allowance[from][msg.sender].sub(value);
        _transfer(from, to, value);
        return true;
    }
    
}