// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CrowdTank {
    address public systemAdmin; 

    struct Project {
        address creator;
        string name;
        string description;
        uint fundingGoal;
        uint deadline;
        uint amountRaised;
        bool funded;
    }

    mapping(uint => Project) public projects;
    mapping(uint => mapping(address => uint)) public contributions;
    mapping(uint => bool) public isIdUsed;

    // New variables
    uint public totalCommission; // total commission collected
    mapping(uint => uint) public projectCommission; // commission per project

    // Events
    event ProjectCreated(uint indexed projectId, address indexed creator, string name, string description, uint fundingGoal, uint deadline);
    event ProjectFunded(uint indexed projectId, address indexed contributor, uint amount);
    event FundWithdrawn(uint indexed projectId, address indexed withdrawer, uint amount, string withdrawerType);
    event CommissionWithdrawn(address indexed admin, uint amount);

    // Constructor to set system admin
    constructor() {
        systemAdmin = msg.sender;
    }

    function createProject(
        string memory _name,
        string memory _description,
        uint _fundingGoal,
        uint _durationSeconds,
        uint _id
    ) external {
        require(!isIdUsed[_id], "project Id is already used");
        isIdUsed[_id] = true;
        projects[_id] = Project({
            creator: msg.sender,
            name: _name,
            description: _description,
            fundingGoal: _fundingGoal,
            deadline: block.timestamp + _durationSeconds,
            amountRaised: 0,
            funded: false
        });
        emit ProjectCreated(_id, msg.sender, _name, _description, _fundingGoal, block.timestamp + _durationSeconds);
    }

    function fundProject(uint _projectId) external payable {
        Project storage project = projects[_projectId];
        require(block.timestamp <= project.deadline, "project deadline passed");
        require(!project.funded, "Project already funded");
        require(msg.value > 0, "Must send some ETH");

        uint commission = (msg.value * 5) / 100;
        uint amountToFund = msg.value - commission;

        uint remaining = project.fundingGoal - project.amountRaised;

        uint actualFunded;
        uint refund;

        if (amountToFund > remaining) {
            actualFunded = remaining;
            refund = amountToFund - remaining;
            payable(msg.sender).transfer(refund + commission); // refund both unused funds and commission
            amountToFund = remaining;
            commission = (actualFunded * 5) / 95; // recompute actual commission
        }

        project.amountRaised += amountToFund;
        contributions[_projectId][msg.sender] += amountToFund;
        projectCommission[_projectId] += commission;
        totalCommission += commission;

        emit ProjectFunded(_projectId, msg.sender, msg.value);

        if (project.amountRaised >= project.fundingGoal) {
            project.funded = true;
        }
    }

    function userWithdrawFunds(uint _projectId) external {
        Project storage project = projects[_projectId];
        require(project.amountRaised < project.fundingGoal, "Goal reached, cannot withdraw");
        uint amount = contributions[_projectId][msg.sender];
        require(amount > 0, "Nothing to withdraw");
        contributions[_projectId][msg.sender] = 0;
        payable(msg.sender).transfer(amount);
        emit FundWithdrawn(_projectId, msg.sender, amount, "user");
    }

    function adminWithdrawFunds(uint _projectId) external {
        Project storage project = projects[_projectId];
        require(project.funded, "Funding not completed");
        require(project.creator == msg.sender, "Only project creator can withdraw");
        require(project.deadline <= block.timestamp, "Deadline not reached");

        uint amount = project.amountRaised;
        project.amountRaised = 0; // Prevent reentrancy
        payable(msg.sender).transfer(amount);
        emit FundWithdrawn(_projectId, msg.sender, amount, "admin");
    }

    function withdrawCommission() external {
        require(msg.sender == systemAdmin, "Only system admin can withdraw");
        require(totalCommission > 0, "No commission to withdraw");

        uint amount = totalCommission;
        totalCommission = 0;
        payable(systemAdmin).transfer(amount);
        emit CommissionWithdrawn(systemAdmin, amount);
    }

    function getMyContribution(uint _projectId) external view returns (uint) {
        return contributions[_projectId][msg.sender];
    }
}
