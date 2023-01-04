//
//  ModelTests.swift
//  MyRidesOrDiesTests
//
//  Created by Lisandro Falconi on 04/01/2023.
//

import XCTest
@testable import MyRidesOrDies

final class ModelTests: XCTestCase {
    
    private var provider: ContactsProvider!
    
    override func setUp() {
        self.provider = .shared
    }
    
    override func tearDown() {
        self.provider = nil
    }

    func testContactIsEmpty() {
        let contact = Contact.empty(context: provider.viewContext)
        XCTAssertEqual(contact.name, "")
        XCTAssertEqual(contact.phoneNumber, "")
        XCTAssertEqual(contact.email, "")
        XCTAssertEqual(contact.notes, "")
        XCTAssertFalse(contact.isFavourite)
        XCTAssertTrue(Calendar.current.isDateInToday(contact.dob))
        
    }
    func testContactIsNotValid() {
        let contact = Contact.empty(context: provider.viewContext)
        XCTAssertFalse(contact.isValid)
    }
    func testContactIsValid() {
        let contact = Contact.preview(context: provider.viewContext)
        XCTAssertTrue(contact.isValid)
    }
    func testContactBirthdayIsValid()  {
        let contact = Contact.preview(context: provider.viewContext)
        XCTAssertTrue(contact.isBirthday)
    }
    func testContactBirthdayIsNotValid() throws {
        let contact = try XCTUnwrap(Contact.makePreview(count: 2, in: provider.viewContext).last)
        XCTAssertFalse(contact.isBirthday)
    }
    func testMakeContactPreviewIsValid()  {
        let count = 5
        let contacts = Contact.makePreview(count: count, in: provider.viewContext)
        
        for i in 0..<contacts.count {
            let item = contacts[i]
            XCTAssertEqual(item.name, "item \(i)")
            XCTAssertEqual(item.email, "test_\(i)@mail.com")
            XCTAssertNotNil(item.isFavourite, "test_\(i)@mail.com")
            XCTAssertEqual(item.phoneNumber, "54922\(i)5259090")
            
            
            // Date
            let dateToCompare = Calendar.current.date(byAdding: .day,value: -i, to: .now)
            let dobDay = Calendar.current.dateComponents([.day], from: item.dob,to: dateToCompare!).day
            
            XCTAssertEqual(dobDay, 0)
            XCTAssertEqual(item.notes, "This is a preview for item \(i)")
        }
    }
    func testFilterFaveContactsRequestIsValid()  {
        let request = Contact.filter(with: .init(filter: .favs))
        XCTAssertEqual("isFavourite == 1", request.predicateFormat)
    }
    func testFilterAllFaveContactsRequestIsValid()  {
        let request = Contact.filter(with: .init(filter: .all))
        XCTAssertEqual("TRUEPREDICATE", request.predicateFormat)
    }
    func testFilterAllWithQueryContactsRequestIsValid()  {
        let query = "lisandro"
        let request = Contact.filter(with: .init(query: query, filter: .all))
        XCTAssertEqual("name CONTAINS[cd] \"\(query)\"", request.predicateFormat)
    }
    func testFilterFaveWithQueryContactsRequestIsValid()  {
        let query = "lisandro"
        let request = Contact.filter(with: .init(query: query, filter: .favs))
        XCTAssertEqual("name CONTAINS[cd] \"\(query)\" AND isFavourite == 1", request.predicateFormat)
    }

}
