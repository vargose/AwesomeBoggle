
import Foundation

class DictionaryService {
    
    let appId = "61df400e"
    let appKey = "8a7f36710ddeeec19716e47ad2eedc0c"
    let language = "en"
    let baseUrl = URL(string:"https://od-api.oxforddictionaries.com:443/api/v1/")!
    
    
    func checkValidityOf(word:String, callback: @escaping (String, Bool) -> ()) {
        
        let word_id = word.lowercased() //word id is case sensitive and lowercase is required
        let url = baseUrl.appendingPathComponent("entries/\(language)/\(word_id)")
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(appId, forHTTPHeaderField: "app_id")
        request.addValue(appKey, forHTTPHeaderField: "app_key")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            if let data = data {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! Dictionary<String, Any>
                    let results = jsonObject["results"] as! Array<Dictionary<String, Any>>
                    let wordResult = results.first!["id"] as! String
                    print(results.first!["id"]!)
                    callback(wordResult, true)
                } catch {
                    callback(word, false)
                }
            } else {
                callback(word, false)
            }
            
        })
        
        task.resume()
    }
    
    
    func getExampleSentence(for word:String, callback: @escaping (String, String?) -> ()) {
        
        let word_id = word.lowercased()
        let url = baseUrl.appendingPathComponent("entries/\(language)/\(word_id)/sentences")
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(appId, forHTTPHeaderField: "app_id")
        request.addValue(appKey, forHTTPHeaderField: "app_key")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { dataOptional, response, error in
            
            if let data = dataOptional {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! Dictionary<String,Any>
                    let results = jsonObject["results"] as! Array<Dictionary<String, Any>>
                    let entries = results.first!["lexicalEntries"] as! Array<Dictionary<String, Any>>
                    let sentences = entries.first!["sentences"] as! Array<Dictionary<String, Any>>
                    let firstSentence = sentences.first!
                    let firstSentenceText = firstSentence["text"] as! String
                    callback(word, firstSentenceText)
                } catch {
                    callback(word, nil)
                }
            } else {
                callback(word, nil)
            }
        })
        
        task.resume()
    }
    
}
