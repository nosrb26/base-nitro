/**
 *Submitted for verification at basescan.org on 2025-01-13
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RacingCar {
    // État de la voiture : mode turbo activé ou désactivé
    bool public isTurboOn;

    // Quantité de nitro utilisée
    uint public nitroUsed;

    // État du mode racing : activé ou désactivé
    bool public isRacingModeOn;

    // Événements pour suivre les actions
    event TurboActivated(bool state);
    event NitroActivated(uint amount);
    event RacingModeToggled(bool state);

    // Constructeur pour initialiser les états
    constructor() {
        isTurboOn = false;
        nitroUsed = 0;
        isRacingModeOn = false;
    }

    // Fonction pour activer ou désactiver le mode turbo
    function toggleTurbo() public {
        isTurboOn = !isTurboOn;
        emit TurboActivated(isTurboOn);
    }

    // Fonction pour activer la nitro avec une quantité random
    function activateNitro() public {
        require(isTurboOn, "Le mode turbo doit etre active pour utiliser la nitro.");
        uint randomNitro = uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % 50 + 1; // Nitro entre 1 et 50
        nitroUsed += randomNitro;
        emit NitroActivated(randomNitro);
    }

    // Fonction pour activer ou désactiver le mode racing
    function toggleRacingMode() public {
        isRacingModeOn = !isRacingModeOn;
        emit RacingModeToggled(isRacingModeOn);
    }

    // Fonction pour récupérer l'état complet de la voiture
    function getCarStatus() public view returns (string memory) {
        string memory turboStatus = isTurboOn ? "active" : "desactive";
        string memory racingModeStatus = isRacingModeOn ? "active" : "desactive";
        return string(abi.encodePacked(
            "Mode Turbo: ", turboStatus, ", Nitro utilisee: ", uintToString(nitroUsed), " unites, Mode Racing: ", racingModeStatus, "."
        ));
    }

    // Fonction utilitaire pour convertir un uint en string
    function uintToString(uint v) internal pure returns (string memory) {
        if (v == 0) {
            return "0";
        }
        uint maxLen = 100;
        bytes memory reversed = new bytes(maxLen);
        uint i = 0;
        while (v != 0) {
            uint remainder = v % 10;
            v = v / 10;
            reversed[i++] = bytes1(uint8(48 + remainder));
        }
        bytes memory s = new bytes(i);
        for (uint j = 0; j < i; j++) {
            s[j] = reversed[i - 1 - j];
        }
        return string(s);
    }
}
