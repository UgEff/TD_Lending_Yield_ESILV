pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface ILendingPool {
    //IPool = ILendinPool
    function deposit(
        address asset, 
        uint256 amount, 
        address onBehalfOf, 
        uint16 referralCode
    ) external;

    function borrow(
        address asset,
        uint256 amount,
        uint256 interestRateMode,
        uint16 referralCode,
        address onBehalfOf
    ) external;

    function withdraw(
    address asset,
    uint256 amount,
    address to
    ) external returns (uint256);

    function repay(
    address asset,
    uint256 amount,
    uint256 rateMode,
    address onBehalfOf
    ) external returns (uint256);
}

contract Loan {
    address private aaveLendingPoolAddress = 0x4bd5643ac6f66a5237E18bfA7d47cF22f1c9F210; // Adresse AAVE Lending Pool
    address private daiAddress = 0x75Ab5AB1Eef154C0352Fc31D2428Cef80C7F8B33; // Adresse 
    address private USDCAddress = 0x9FD21bE27A2B059a288229361E2fA632D8D2d074; // Adresse USDC
    address private AAVE = 0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9;
    address private DAI = 0x75Ab5AB1Eef154C0352Fc31D2428Cef80C7F8B33;
    address private aDAIAddress = 0x31f30d9A5627eAfeC4433Ae2886Cf6cc3D25E772;
    address variableDebtUSDCAddress = 0xcfc2d9b9498cBd6F71E5E46d46082C76C4F6C695;
    IERC20 private dai = IERC20(DAI);
    IERC20 private aDAI = IERC20(aDAIAddress);
    IERC20 private aUSDCDebt = IERC20(variableDebtUSDCAddress);

    IERC20 private daiToken = IERC20(daiAddress);
    ILendingPool private lendingPool = ILendingPool(aaveLendingPoolAddress);

    
    function depositSomeTokens() external {
        // Approbation pour que Aave puisse retirer les DAI de ce contrat
        uint256 amountToDeposit = 10000000000000000000; // 1 DAI
        require(daiToken.balanceOf(address(this)) >= amountToDeposit, "Not enough tokens to deposit");
        daiToken.approve(aaveLendingPoolAddress, amountToDeposit);

        // Dépôt des DAI dans Aave
        lendingPool.deposit(daiAddress, amountToDeposit, address(this), 0);
    }

    //fonction pour emprunter des USDC
    //Q6

    function borrowSomeTokens() external{
    uint amountToBorrow = 1e18;
    require(aDAI.balanceOf(address(this)) > 2*amountToBorrow, "Not enough deposit to borrow");
    lendingPool.borrow(USDCAddress, amountToBorrow, 2, 0, address(this));
    // AAVE.borrow(USDCAddress, amountToBorrow, 1, 0, address(this));
    }

    function repaySomeTokens() external returns (uint){
    uint amountToRepay = aUSDCDebt.balanceOf(address(this));
    require (amountToRepay > 0, "No debt to repay");
    aUSDCDebt.approve(aaveLendingPoolAddress, amountToRepay);
    lendingPool.repay(USDCAddress, amountToRepay, 1, address(this));  
    return amountToRepay; 
    }

    
    //Q-8
    function withdrawSomeTokens() external returns (uint){
    uint amountToWithdraw = aDAI.balanceOf(address(this));
        require (amountToWithdraw > 0, "No deposit to withdraw");
        lendingPool.withdraw(DAI, amountToWithdraw, address(this));
    }
}