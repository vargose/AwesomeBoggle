
import UIKit

class DictionaryService {
    let appID = "61df400e"
    let appKey = "8a7f36710ddeeec19716e47ad2eedc0c"
    let language = "en"
    let baseUrl = URL(string:"https://od-api.oxforddictionaries.com:443/api/v1/")!
    
    func checkValidityOf(word: String, callback: @escaping (String, Bool) -> ()){
        let wordToCheck = word.lowercased()
        let url = baseUrl.appendingPathComponent("entries/\(language)/\(wordToCheck)")
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(appID, forHTTPHeaderField:"app_id")
        request.addValue(appKey, forHTTPHeaderField:"app_key")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (dataOptional, responseOptional, errorOptional) in
            let httpResponse  = responseOptional as! HTTPURLResponse
            print(httpResponse.statusCode)
            
            if let data = dataOptional {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! Dictionary<String, Any>
                    let results = jsonObject["results"] as! Array<Dictionary<String, Any>>
                    let wordResult = results.first!["id"] as! String
                    callback(wordResult, true)
                } catch {
                    callback(wordToCheck, false)
                }
            } else {
                callback(wordToCheck, false)
            }
        }
        task.resume()

        
    }
}
