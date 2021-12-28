// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./utils/ERC20.sol";
import "./utils/AccessControl.sol";

/**
 * @title ERC20 Token
 * @notice mintable only by admins, no approval needed for a contract
 */
contract ERC20Key is ERC20, AccessControl {
    address internal stakingContractAddress;
    address internal swappingContractAddress;
    address internal nftContractAddress;
    address internal influeqContractAddress;

    /**
     * @dev Constructor
     * @param _stakingContractAddress upgradable address
     * @param _swappingContractAddress upgradable address
     */
    constructor(
        string memory name,
        string memory symbol,
        uint _amount,
        address _stakingContractAddress,
        address _swappingContractAddress,
        address _nftContractAddress,
        address _influeqContractAddress
    ) ERC20(name, symbol) {
        stakingContractAddress = _stakingContractAddress;
        swappingContractAddress = _swappingContractAddress;
        nftContractAddress = _nftContractAddress;
        influeqContractAddress = _influeqContractAddress;

        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _mint(_msgSender(), _amount);
    }

    function mint(address account, uint256 amount)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        _mint(account, amount);
    }

    function mintMultiple(
        address[] calldata accounts,
        uint256[] calldata amounts
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        for (uint256 j = 0; j < accounts.length; j++) {
            _mint(accounts[j], amounts[j]);
        }
    }

    function getSwappingContractAddress()
    public
    view
    returns (address)
    {
        return swappingContractAddress;
    }

    function getStakingContractAddress()
    public
    view
    returns (address)
    {
        return stakingContractAddress;
    }
    
    function getNftContractAddress()
    public
    view
    returns (address)
    {
        return nftContractAddress;
    }
    
    function getInflueqContractAddress()
    public
    view
    returns (address)
    {
        return influeqContractAddress;
    }

    function setSwappingContractAddress(address _swappingContractAddress)
    external
    onlyRole(DEFAULT_ADMIN_ROLE)
    {
        require(_swappingContractAddress != swappingContractAddress);
        swappingContractAddress = _swappingContractAddress;
    }

    function setStakingContractAddress(address _stakingContractAddress)
    external
    onlyRole(DEFAULT_ADMIN_ROLE)
    {
        require(_stakingContractAddress != stakingContractAddress);
        stakingContractAddress = _stakingContractAddress;
    }

    function setNftContractAddress(address _nftContractAddress)
    external
    onlyRole(DEFAULT_ADMIN_ROLE)
    {
        require(_nftContractAddress != nftContractAddress);
        nftContractAddress = _nftContractAddress;
    }

    function setInflueqContractAddress(address _influeqContractAddress)
    external
    onlyRole(DEFAULT_ADMIN_ROLE)
    {
        require(_influeqContractAddress != influeqContractAddress);
        influeqContractAddress = _influeqContractAddress;
    }

    function selfDestructContract(address _sendAllEth)
    external
    onlyRole(DEFAULT_ADMIN_ROLE)
    {
        selfdestruct(payable(_sendAllEth));
    }

    receive() external payable {
        revert();
    }
}