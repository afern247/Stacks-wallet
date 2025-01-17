//
//  WalletFormView.swift
//  Famwalt
//
//  Created by Shreyas Papinwar on 12/06/21.
//

import SwiftUI

struct WalletFormView: View {
    @EnvironmentObject var store: WalletStore
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var form: WalletForm
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                  TextField("test eth", text: $form.name)
                }
                Section(header: Text("address📝")) {
                  TextField("demo.eth", text: $form.address)
                }
            }
            .navigationBarTitle("Wallet Form", displayMode: .inline)
            .navigationBarItems(
              leading: Button("Cancel", action: dismiss),
              trailing: Button(
                form.updating ? "Update" : "Save",
                action: form.updating ? updateWallet : saveWallet))
        }
        
    }
}

// MARK: - Actions
extension WalletFormView {
    func dismiss() {
      presentationMode.wrappedValue.dismiss()
    }

    func saveWallet() {
      store.create(
        name: form.name,
        address: form.address
      )
      dismiss()
    }

    func updateWallet() {
      if let walletID = form.walletID {
        store.update(
          walletID: walletID,
          name: form.name,
          address: form.address)
        dismiss()
      }
    }
}

struct WalletFormView_Previews: PreviewProvider {
    static var previews: some View {
        WalletFormView(form: WalletForm())
    }
}
