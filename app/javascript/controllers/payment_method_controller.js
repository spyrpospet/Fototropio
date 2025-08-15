import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="payment-method"
export default class extends Controller {
  static targets = ['bankTransferInstructions', 'installments']

  connect() {
  }

  change(event) {
    const value = event.currentTarget.querySelector('input').value

    if (value === 'bank_transfer')
      this.bankTransferInstructionsTarget.classList.remove('hidden')
    else
      this.bankTransferInstructionsTarget.classList.add('hidden')

    if(this.hasInstallmentsTarget) {
      if (value === 'credit_debit_card')
        this.installmentsTarget.classList.remove('hidden')
      else
        this.installmentsTarget.classList.add('hidden')
    }
  }
}
