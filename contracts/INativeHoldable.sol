pragma solidity ^0.5.0;

import "./IHoldable.sol";


interface INativeHoldable {
    event NativeHoldCreated(
        address indexed holdIssuer,
        string  operationId,
        address from,
        address to,
        address indexed notary,
        uint256 value,
        uint256 expiration,
        uint256 timeToExpiration
    );

    event NativeHoldExecuted(
        address indexed holdIssuer,
        string operationId,
        address indexed notary,
        uint256 heldValue,
        uint256 transferredValue
    );

    event NativeHoldExecutedAndKeptOpen(
        address indexed holdIssuer,
        string operationId,
        address indexed notary,
        uint256 heldValue,
        uint256 transferredValue);

    event NativeHoldReleased(address indexed holdIssuer, string operationId, IHoldable.HoldStatusCode status);

    event NativeHoldRenewed(
        address indexed holdIssuer,
        string operationId,
        uint256 oldExpiration,
        uint256 newExpiration,
        uint256 newTimeToExpiration
    );
}
