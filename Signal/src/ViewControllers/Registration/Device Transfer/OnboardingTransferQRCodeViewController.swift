//
//  Copyright (c) 2020 Open Whisper Systems. All rights reserved.
//

import Foundation
import MultipeerConnectivity

public class OnboardingTransferQRCodeViewController: OnboardingBaseViewController {

    private let qrCodeView = QRCodeView()

    override public func loadView() {
        view = UIView()
        view.addSubview(primaryView)
        primaryView.autoPinEdgesToSuperviewEdges()

        view.backgroundColor = Theme.backgroundColor

        let titleLabel = self.titleLabel(
            text: NSLocalizedString("DEVICE_TRANSFER_QRCODE_TITLE",
                                    comment: "The title for the device transfer qr code view")
        )
        primaryView.addSubview(titleLabel)
        titleLabel.accessibilityIdentifier = "onboarding.transferQRCode.titleLabel"
        titleLabel.setContentHuggingHigh()

        let explanationLabel = self.explanationLabel(
            explanationText: NSLocalizedString("DEVICE_TRANSFER_QRCODE_EXPLANATION",
                                               comment: "The explanation for the device transfer qr code view")
        )
        explanationLabel.accessibilityIdentifier = "onboarding.transferQRCode.bodyLabel"
        explanationLabel.setContentHuggingHigh()

        qrCodeView.setContentHuggingVerticalLow()

        let explanationLabel2 = self.explanationLabel(
            explanationText: NSLocalizedString("DEVICE_TRANSFER_QRCODE_EXPLANATION2",
            comment: "The second explanation for the device transfer qr code view")
        )
        explanationLabel2.setContentHuggingHigh()

        let cancelButton = self.linkButton(title: CommonStrings.cancelButton, selector: #selector(didTapCancel))

        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            explanationLabel,
            qrCodeView,
            explanationLabel2,
            UIView.vStretchingSpacer(),
            cancelButton
        ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 12
        primaryView.addSubview(stackView)
        stackView.autoPinEdgesToSuperviewMargins()
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        deviceTransferService.addObserver(self)

        do {
            let url = try deviceTransferService.startAcceptingTransfersFromOldDevices(
                mode: onboardingController.onboardingMode == .provisioning ? .linked : .primary
            )
            try qrCodeView.setQR(url: url)
        } catch {
            owsFailDebug("error \(error)")
        }
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        deviceTransferService.removeObserver(self)
        deviceTransferService.stopAcceptingTransfersFromOldDevices()
    }

    // MARK: - Events

    @objc
    func didTapCancel() {
        Logger.info("")

        guard let navigationController = navigationController else {
            return owsFailDebug("unexpectedly missing nav controller")
        }

        onboardingController.pushStartDeviceRegistrationView(onto: navigationController)
    }

    override func shouldShowBackButton() -> Bool {
        // Never show the back buton here
        return false
    }
}

extension OnboardingTransferQRCodeViewController: DeviceTransferServiceObserver {
    func deviceTransferServiceDiscoveredNewDevice(peerId: MCPeerID, discoveryInfo: [String: String]?) {}

    func deviceTransferServiceDidStartTransfer(progress: Progress) {
        onboardingController.accountTransferInProgress(fromViewController: self, progress: progress)
    }

    func deviceTransferServiceDidEndTransfer(error: DeviceTransferService.Error?) {
        if let error = error {
            owsFailDebug("unexpected error while rendering QR code \(error)")
        }
    }
}
