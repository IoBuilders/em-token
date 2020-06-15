pragma solidity ^0.5.0;


interface ICrossLedgerLink {

    enum CrossLedgerTransferStatus {
        NonEstablished,
        Ordered,
        Accepted,
        Revoked,
        Acknowledged,
        TransferInExecuted,
        TransferOutExecuted
    }

    enum CrossLedgerTransferType {
        TransferIn,
        TransferOut
    }

    /**
    * @notice Initiates the cross ledger value transfer process.
    *
    * Amount is held.
    *
    * @param _operationId The user operation id.
    * @param _amount amount that will be transferred from the origin
    *                account.
    * @param _to The address in the destination chain where the same currency
    *            tokens will be minted.
    * @param _currency ISO currency code
    * @param _chainId destination chain id
    *
    * @return messageHash Message hash is unique for each request.
    */
    function orderTransfer(
        string calldata _operationId,
        uint256 _amount,
        address _to,
        string calldata _currency,
        uint256 _chainId
    )
    external
    returns (bytes32 messageHash);

    /**
     * @notice Returns is a given address has cross ledger operator rights.
     *
     * @param _operator The address of the operator
     *
     * @return bool
     */
    function isCrossLedgerOperator(address _operator)
    external
    view
    returns (bool);

    /**
     * @notice Returns if a given chain id of blockchain network is activated and can therefore be used
     *         in orderTransfer as parameter.
     *
     * @param _chainId The numeric identifier of the blockchain
     *
     * @return bool
     */
    function isChainActive(uint256 _chainId)
    external
    view
    returns (bool);

    /**
     * @notice Returns if a given currency is activated for a given blockchain network and can therefore be used
     *         in orderTransfer as parameter.
     *
     * @param _currency The 3 character currency code specified in ISO 4217
     * @param _chainId The numeric identifier of the blockchain
     *
     * @return bool
     */
    function isCurrencyActiveForChain(string calldata _currency, uint256 _chainId)
    external
    view
    returns (bool);

    /**
     * @notice Returns all the data of a specific cross ledger value transfer.
     *
     * @param _operationId The transfer operation id.
     *
     * @return amount  amount that will be transferred
     * @return from The address in the origin chain where the same currency
     *              tokens will be burned.
     * @return to The address in the destination chain where the same currency
     *            tokens will be minted.
     * @return currency ISO 4217 currency code
     * @return originChainId id of the origin chain
     * @return destinationChainId id of the destination chain
     * @return hashLock The execution hashLock
     * @return status The current status of the transfer
     * @return crossLedgerTransferType The type can either be an ingoing or an outgoing transfer
     * @return reason The numeric value of the non acceptance reason set when a transfer is revoked, zero otherwise
     */
    function getTransferData(string calldata _operationId)
    external
    view
    returns (
        uint256 amount,
        address from,
        address to,
        string memory currency,
        uint256 originChainId,
        uint256 destinationChainId,
        bytes32 hashLock,
        CrossLedgerTransferStatus status,
        CrossLedgerTransferType crossLedgerTransferType,
        uint8 reason
    );

    event CrossLedgerTransferOrdered(
        string operationId,
        address indexed from,
        address indexed to,
        uint256 value,
        uint256 originChainId,
        uint256 destinationChainId,
        string currency,
        address initiator,
        bytes32 indexed messageHash
    );
    event CrossLedgerTransferAccepted(
        string operationId,
        address indexed from,
        address indexed to,
        uint256 value,
        uint256 originChainId,
        uint256 destinationChainId,
        string currency,
        address acceptingOperator,
        bytes32 parentMessageHash,
        bytes32 indexed messageHash
    );
    event CrossLedgerTransferRevoked(
        string operationId,
        address revokeOperator,
        bytes32 parentMessageHash,
        bytes32 indexed messageHash,
        uint8 reason
    );
    event CrossLedgerTransferAcknowledged(
        string operationId,
        address indexed from,
        address indexed to,
        uint256 originChainId,
        uint256 destinationChainId,
        address acknowledgeOperator,
        bytes32 parentMessageHash,
        bytes32 indexed messageHash,
        bytes32 hashLock
    );
    event CrossLedgerTransferInExecuted(
        string operationId,
        bytes32 parentMessageHash,
        bytes32 indexed messageHash,
        address transferInOperator,
        bytes32 unlockSecret
    );
    event CrossLedgerTransferOutExecuted(
        string operationId,
        bytes32 parentMessageHash,
        bytes32 indexed messageHash,
        address transferOutOperator,
        bytes32 unlockSecret
    );
    event CrossLedgerChainActivated(uint256 indexed chainId, address indexed account);
    event CrossLedgerChainDeactivated(uint256 indexed chainId, address indexed account);
    event CrossLedgerCurrencyActivated(string currency, uint256 indexed chainId, address indexed account);
    event CrossLedgerCurrencyDeactivated(string currency, uint256 indexed chainId, address indexed account);
}
