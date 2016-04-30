/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import CoreData

protocol PersonPickerDelegate: class {
  func didSelectPerson(person: Person)
}

class PeopleTableViewController: UITableViewController {
  var managedObjectContext: NSManagedObjectContext!
  var people = [Person]()

  // for person select mode
  weak var pickerDelegate: PersonPickerDelegate?
  var selectedPerson: Person?

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "People"

    reloadData()
  }

  func reloadData() {
    let fetchRequest = NSFetchRequest(entityName: "Person")

    do {
      if let results = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Person] {
        people = results
        tableView.reloadData()
      }
    } catch {
      fatalError("There was an error fetching the list of people!")
    }
  }

  // MARK: - Table view data source

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return people.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("PersonCell", forIndexPath: indexPath)

    let person = people[indexPath.row]
    cell.textLabel?.text = person.name

    if let selectedPerson = selectedPerson where selectedPerson == person {
      cell.accessoryType = .Checkmark
    } else {
      cell.accessoryType = .None
    }

    return cell
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let pickerDelegate = pickerDelegate {
      let person = people[indexPath.row]
      selectedPerson = person
      pickerDelegate.didSelectPerson(person)

      tableView.reloadData()
    }

    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}
