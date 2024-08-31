// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract StakeERC20{
    error ZeroAddressDetected();
    error ZeroValueNotAllowed();
    error NotOwner();
    error NoActiveStake();
    error NoRewardsToClaim();


    address public owner;
    address public tokenAddress;
    uint256 public totalStakedInContract;
    uint256 public rewardRate = 1; //reward earned per second
    
    event Staked(address indexed user, uint256 indexed amount);


    struct Stake {
        // address user;
        uint256 tokenAmount;
        uint256 startTime;
        uint256 duration;
        uint256 expectedReward;
        bool isStaked;
        bool isClaimed; //to track claiming
    }

    mapping (address => Stake[]) userStakes;
    //track all stakes in the contract
    Stake[] public allStakes;

    constructor (address _tokenAddress) {
        owner = msg.sender;
        tokenAddress = _tokenAddress;
        rewardRate = 5; //setting a fixed reward rate of 0.5 token per sec
    }

    function addStake(uint256 _amount, uint256 _duration) external {

        if (msg.sender == address(0)){
            revert ZeroAddressDetected();
        }

        if (_amount == 0){
            revert ZeroValueNotAllowed();
        }

        Stake memory newStake = Stake({
            tokenAmount: _amount,
            startTime: block.timestamp,
            duration: _duration,
            expectedReward: 0,
            isStaked: true,
            isClaimed:false
        });

        IERC20(tokenAddress).transferFrom(msg.sender, address(this), _amount);
        userStakes[msg.sender].push(newStake);
        totalStakedInContract += _amount;

        allStakes.push(newStake); //add to all stakes array

        emit Staked(msg.sender,_amount);
    }




      function claimReward() external {
        Stake[] storage stakes = userStakes[msg.sender]; 
        if (stakes.length == 0){
            revert NoActiveStake();
        }
        
        uint256 totalReward = 0;
        
        for (uint256 i = 0; i < stakes.length; i++){
            Stake storage currentStake = stakes[i]; // the current stake at index i

            if (currentStake.isStaked == true && currentStake.isClaimed == false) {

                uint256 reward = calculateRewardRate(currentStake);
                totalReward += reward;

                currentStake.isClaimed = true;
            }

            if(totalReward == 0){
                revert NoRewardsToClaim();
            }

            IERC20(tokenAddress).transfer(msg.sender,totalReward); //transfer calculated reward to user 
        }
        
    }




    function calculateRewardRate(Stake memory _stake) internal view returns(uint256){
        uint256 reward = 0;
        uint256 stakingTime = _stake.startTime + _stake.duration;

            uint256 Si = _stake.tokenAmount; // amount staked by user 

            uint256 Ti = totalStakedInContract; // total amount staked in the contract

            reward = (Si * rewardRate * stakingTime) / (Ti * 100);// Divide by 100 to make the reward rate from 5 to 0.5 
        

        return reward;
    }


    function getStakes() external view returns(Stake[] memory ) {
        return allStakes;
    }

    function getAnyStake(address _user) external view returns(Stake[] memory ) {
        return userStakes[_user];
    }

    
    function getContractBalance() external view returns (uint256) {
        onlyOwner();
        return IERC20(tokenAddress).balanceOf(address(this));
    }

    function onlyOwner() private view{
        if(msg.sender != owner){
            revert NotOwner();
        }
    }




}