//
//  Sever-Convenience.swift
//  course_material_app
//
//  Created by MIRKO on 5/4/16.
//  Copyright © 2016 hku_project. All rights reserved.
//

import Foundation

//
//  Glassdoor.swift
//  mock_interview
//
//  Created by MIRKO on 4/26/16.
//  Copyright © 2016 XZM. All rights reserved.
//

import Foundation

class Server : NSObject {
    typealias CompletionHander = (result: AnyObject!, error: NSError?) -> Void
    
    var session: NSURLSession
    
    override init() {
        session = NSURLSession.sharedSession()
        super.init()
    }
    
    // MARK: - All purpose task method for data
    
    func taskForUser(user_id: Int, completionHandler: CompletionHander) -> NSURLSessionDataTask {
        

        let urlString = "https://afternoon-sands-99165.herokuapp.com/get_posts.php" + "?user_id=" + String(user_id)
        print(urlString)
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        
        let task = session.dataTaskWithRequest(request) {data, response, downloadError in
            
            if let error = downloadError {
                print("Error encountered. breakpoint = 1")
                print(error)
            } else {
                print("Step 3 - taskForResource's completionHandler is invoked.")
                Server.parseJSONWithCompletionHandler(data!, completionHandler: completionHandler)
            }
        }
        
        task.resume()
        
        return task
        
        
    }
    
    func taskForResource(completionHandler: CompletionHander) -> NSURLSessionDataTask {
        
        
        let urlString = "https://afternoon-sands-99165.herokuapp.com/get_posts.php"
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        print("task is called")
        
        let task = session.dataTaskWithRequest(request) {data, response, downloadError in
            
            if let error = downloadError {
                print("Error encountered. breakpoint = 1")
                print(error)
            } else {
                print("Step 3 - taskForResource's completionHandler is invoked.")
                Server.parseJSONWithCompletionHandler(data!, completionHandler: completionHandler)
            }
        }
        
        task.resume()
        
        return task

    }
    

    
    // Parsing the JSON
    
    class func parseJSONWithCompletionHandler(data: NSData, completionHandler: CompletionHander) {
        var parsingError: NSError? = nil
        
        let parsedResult: AnyObject?
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
        } catch let error as NSError {
            parsingError = error
            parsedResult = nil
        }
        
        if let error = parsingError {
            completionHandler(result: nil, error: error)
        } else {
            print("Step 4 - parseJSONWithCompletionHandler is invoked.")
            completionHandler(result: parsedResult, error: nil)
        }
    }
    
    

    // MARK: - Shared Instance
    
    class func sharedInstance() -> Server {
        
        struct Singleton {
            static var sharedInstance = Server()
        }
        
        return Singleton.sharedInstance
    }
    
}
