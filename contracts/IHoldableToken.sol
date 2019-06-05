pragma solidity ^0.5.0;

interface IHoldableToken {
    enum Status {PENDING, ACCEPTED, REVOKED_BY_EXPIRATION, REVOKED_BY_NOTARY, REVOKED_BY_TARGET, REVOKED_BY_REGULATOR}

    /**
     * @notice Creates a hold on behalf of the msg.sender in favor of the payee. It specifies a notary who is responsible to either execute or release the hold.
     * @param holdId The unique ID to identify the hold
     * @param target The address of the payee, to whom the tokens are to be paid if released
     * @param amount The amount to be transferred.
     * @param notary The address of the notary who is going to determine whether the hold is to be executed or released.
     */
    function hold(bytes32 holdId, address target, uint256 amount, address notary) external returns (uint256 expiration);

    /**
     * @notice Releases a hold. Release means that the specified value is transferred from the payer to the payee. The implementation must verifies that only the notary is able to successfully call the function.
     * @param holdId The unique ID to identify the hold
     */
    function releaseHold(bytes32 holdId) external returns (address origin, address target, uint256 amount, address notary);

    /**
     * @notice Revokes a hold. Revoke means that the transfer is not executed and the held amount is available again for the payer. Only once that the hold has expired can this action successfully be executed.
     * @param holdId The unique ID to identify the hold
     */
    function revokeByExpiration(bytes32 holdId) external returns (address origin, address target, uint256 amount, address notary, Status status);

    /**
     * @notice Revokes a hold. Revoke means that the transfer is not executed and the held amount is available again for the payer. Only the assigned notary can successfully execute this action.
     * @param holdId The unique ID to identify the hold
     */
    function revokeByNotary(bytes32 holdId) external returns (address origin, address target, uint256 amount, address notary, Status status);

    /**
     * @notice Revokes a hold. Revoke means that the transfer is not executed and the held amount is available again for the payer. Only the target of the transfer can successfully execute this action.
     * @param holdId The unique ID to identify the hold
     */
    function revokeByTarget(bytes32 holdId) external returns (address origin, address target, uint256 amount, address notary, Status status);

    /**
     * @notice Retrieves how much of the balance is currently held and therefore not available for transfer.
     * @param account The address which held balance should be returned
     */
    function heldBalanceOf(address account) external view returns (uint256);

    /**
     * @notice Retrieves the balance of an account including the held balance
     * @param account The address which virtual balance should be returned
     */
    function virtualBalanceOf(address account) external view returns (uint256);

    /**
     * @notice Retrieves the total sum of how many tokens are on hold.
     */
    function totalHeldBalance() external view returns (uint256);

    /**
     * @notice Is emitted when a hold is ordered.
     */
    event HoldOrdered(bytes32 indexed holdId, address indexed origin, address indexed target, uint256 amount, uint256 expiration);

    /**
     * @notice Is emitted when a hold is released.
     */
    event HoldReleased(bytes32 indexed holdId, address notary, address indexed origin, address indexed target, uint256 amount);

    /**
     * @notice Is emitted when a hold is revoked.
     */
    event HoldRevoked(
        bytes32 indexed holdId,
        address notary,
        address indexed origin,
        address indexed target,
        uint256 amount,
        Status status
    );

    /**
    * @notice Is emitted when a hold with an already existing hold id is tried to order
    */
    event HoldIdExists(bytes32 indexed holdId);
}
