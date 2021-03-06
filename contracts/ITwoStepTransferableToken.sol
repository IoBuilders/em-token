pragma solidity ^0.5.0;

import "./IHoldable.sol";


interface ITwoStepTransferableToken {
    /**
     * @notice Orders a clearable transfer on behalf of the msg.sender in favor of `target`. A notary is responsible to either release or revoke the transfer.
     * @param transferId The unique ID to identify the clearable transfer
     * @param target The address of the payee, to whom the tokens are to be paid if released
     * @param amount The amount to be transferred.
     */
    function orderTransfer(string calldata transferId, address target, uint256 amount) external returns (bool);

    /**
     * @notice Releases a clearable transfer, which means that the tokens are transferred from the payer to the payee. Only a notary can successfully execute this action.
     * @param transferId The unique ID to identify the clearable transfer
     */
    function releaseTransfer(string calldata transferId) external returns (bool);

    /**
     * @notice Revokes a clearable transfer, which means that the amount that is held is available again to the payer and no transfer is done. Only the assigned notary can successfully execute this action.
     * @param transferId The unique ID to identify the clearable transfer
     */
    function revokeTransferByNotary(string calldata transferId) external;

    /**
     * @notice Is emitted when a clearable transfer is ordered.
     */
    event TransferOrdered(
        string transferId,
        address indexed origin,
        address indexed target,
        uint256 amount,
        uint256 expiration
    );

    /**
     * @notice Is emitted when a clearable transfer is released.
     */
    event TransferReleased(
        string transferId,
        address notary,
        address indexed origin,
        address indexed target,
        uint256 amount
    );

    /**
     * @notice Is emitted when a clearable transfer is revoked.
     */
    event TransferRevoked(
        string transferId,
        address notary,
        address indexed origin,
        address indexed target,
        uint256 amount,
        IHoldable.HoldStatusCode status
    );
}
