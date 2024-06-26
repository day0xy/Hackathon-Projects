// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.13;

import "src/Donate/Main.sol";
import "src/Donate/DonateMain.sol";
import "src/uitls/DonationTool.sol";
import "src/vote/DAO.sol";
import "src/uitls/GovernTool.sol";
import "src/vote/GovernImp.sol";

contract front is DonationT,GovernorImpV2{

    address private main;
    address payable private donateMain;
    address private DaoA;
    address private governImp;

    constructor(address _main,address payable _donateMain,address _Dao,address _governImp) {
        main = _main;
        donateMain = _donateMain;
        DaoA = _Dao;
        governImp = _governImp;
    }

    function register() external {
        Main(main).register();
    }

    function donate(uint donationCampaignId,uint amount) external payable {
        DonateMain(donateMain).donate(donationCampaignId, amount);
        // (bool sent,) = donateMain.call{value:amount}(abi.encodeWithSignature("donate(uint,uint)", donationCampaignId,amount));
        // require(sent,"front::front:Fallback");
    }

    function isAdmin(address _address) external view returns(bool) {
        return Dao(DaoA).isAdmin(_address);
    }

    function castVote(uint proposalId,uint8 support) external {
        DonateMain(donateMain).castVote(proposalId, support);
    }

    function state(uint _proposalId) external view returns(ProposalState) {
        return GovernImp(governImp).state(_proposalId);
    }

}