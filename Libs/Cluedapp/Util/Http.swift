//
//  Http.swift
//
//  Created by Theo Fitchat on 2015/12/29.
//  Copyright © 2016 Cluedapp. All rights reserved.
//

#if os(OSX)
    import AppKit
#endif

public enum MultipartItem {
    case FileName
    case Data
    case Mime
    case Value
}

public class Http {
    public class func get (url: String, _ handleResponse: ((data: AnyObject?, response: NSURLResponse?, error: AnyObject?) -> ())?) {
        // Send request
        print("Http.get: Begin request to \(url)")
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!) {(data, response, error) in
            print("Http.get: Response received")

            handleResponse?(data: data, response: response, error: error)
            }.resume()
    }

    public class func post (url: String, _ data: AnyObject? = nil, _ handleResponse: ((data: AnyObject?, response: NSURLResponse?, error: AnyObject?) -> ())?) {
        // Build HTTP query
        var query = Strings.Empty
        if let data = data {
            for (key, val) in data as! NSDictionary {
                if query != Strings.Empty { query += "&" }
                query += "\(key)=\(val)"
            }
            print("Http.post: Query = \(query)")
        } else {
            print("Http.post: data == nil -> Empty query string")
        }

        // Calculate post data length
        let postData = query.dataUsingEncoding(NSUTF8StringEncoding)!
        let postLength = String(postData.length)

        // Setup POST request to send URL-encoded data and receive JSON
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        request.setValue(postLength, forHTTPHeaderField: "Content-Length")
        request.setValue(Strings.UrlEncodedMimeType, forHTTPHeaderField: "Content-Type")
        request.setValue(Strings.JsonMimeType, forHTTPHeaderField: "Accept")

        // Send request
        print("Http.post: Begin request to \(url)")
        NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            print("Http.post: Response received")

            handleResponse?(data: data, response: response, error: error)
            }.resume()
    }

    // data: ["key": [.FileName (optional), .Mime (optional), .Data (required if binary data), .Value (required if string data)]
    public class func postMultipartFormData (url: String, _ data: [String : [MultipartItem : AnyObject?]], _ handleResponse: ((data: AnyObject?, response: NSURLResponse?, error: AnyObject?) -> ())?) {
        // Setup POST request to send multipart-encoded data and receive JSON
        let boundary = "Boundary-\(NSUUID().UUIDString)"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.setValue("\(Strings.FormDataMimeType); boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue(Strings.JsonMimeType, forHTTPHeaderField: "Accept")

        let body = NSMutableData()
        for (key, item) in data {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"%@\r\n".format(item[.FileName] == nil ? Strings.Empty : ";filename=\"\(item[.FileName])\""))
            if let mime = item[.Mime] {
                body.append("Content-Type: \(mime)\r\n")
            }
            body.append("\r\n")
            if let data = item[.Data] {
                body.appendData(data as! NSData)
            } else if let value = item[.Value] as? String {
                body.append(value)
            }
            body.append("\r\n")
        }

        body.append("--\(boundary)--\r\n")
        request.HTTPBody = body

        // Send request
        print("Http.postMultipartFormData: Begin request to \(url)")
        NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            print("Http.postMultipartData: Response received")

            handleResponse?(data: data, response: response, error: error)
            }.resume()
    }
}
