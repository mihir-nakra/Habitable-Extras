//
//  ContactControl.swift
//  ContactsTes
//
//  Created by Mukesh Nakra on 5/28/22.
//

import Foundation
import ContactsUI

struct ContactControl {
    func getContacts() -> [Person] {
        var contacts = [CNContact]()
        let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey] as! [CNKeyDescriptor]
            let request = CNContactFetchRequest(keysToFetch: keys)
            
            let contactStore = CNContactStore()
            do {
                try contactStore.enumerateContacts(with: request) {
                    (contact, stop) in
                    // Array containing all unified contacts from everywhere
                    contacts.append(contact)
                }
            }
            catch {
                print("unable to fetch contacts")
            }
        
        var people = [Person]()
        for contact in contacts {
            if (contact.phoneNumbers.count > 0) {
                let firstName: String = contact.givenName
                let lastName: String = contact.familyName
                let phoneNumber: String = contact.phoneNumbers[0].value.stringValue
                var newPerson = Person(firstName: "", phoneNumber: "")
                if lastName != "" {
                    newPerson = Person(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
                } else {
                    newPerson = Person(firstName: firstName, phoneNumber: phoneNumber)
                }
                people.append(newPerson)
            }
        }
        return people
    }
}
