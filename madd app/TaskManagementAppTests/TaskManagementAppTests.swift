//
//  madd_appUITestsLaunchTests.swift
//  madd appUITests
//
//  Created by Thusith Hettiarachchi on 2024-04-19.
//

import XCTest
import CoreData
@testable import TaskManagementApp

final class TaskManagementAppTests: XCTestCase {
    
    var sut: AddTaskViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
              sut = storyboard.instantiateViewController(identifier: "AddTaskViewController") as? AddTaskViewController
              sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
               try super.tearDownWithError()
    }

    func testExample() throws {
        // Given
                let name = "Test Task"
                let type = "Test Type"
                let date = Date()
                let description = "Test Description"
                let duration: Float = 3.0
                sut.taskName.text = name
                sut.taskType.text = type
                sut.taskDate.setDate(date, animated: false)
                sut.taskDesc.text = description
                sut.taskDuration.setValue(duration, animated: false)
        
        sut.btnSave(UIButton())
        
        let context = DBManager.share.context
                let tasksFetchRequest: NSFetchRequest<TaskManageEntity> = TaskManageEntity.fetchRequest()
                tasksFetchRequest.predicate = NSPredicate(format: "name == %@", name)
                do {
                    let tasks = try context.fetch(tasksFetchRequest)
                    XCTAssert(tasks.count == 1, "Task should be saved")
                    let task = tasks.first!
                    XCTAssert(task.name == name, "Task name should be \(name)")
                    XCTAssert(task.type == type, "Task type should be \(type)")
                    XCTAssert(task.taskdate == date, "Task date should be \(date)")
                    XCTAssert(task.shortdescription == description, "Task description should be \(description)")
                    XCTAssert(task.taskduration == Int16(duration), "Task duration should be \(duration)")
                    XCTAssert(task.image != nil, "Task should have an image")
                    XCTAssert(task.taskstatus == false, "Task status should be false")
                } catch {
                    XCTFail("Error fetching tasks: \(error.localizedDescription)")
                }
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
