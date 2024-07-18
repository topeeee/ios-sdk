//
//  File.swift
//  compliance-sdk-ios
//
//  Created by Tope Ajibuwa on 03/05/2024.
//

import Foundation
import CryptoKit
import UIKit

class NetworkingRX {
    
    static func resizeAndCompressImage(image: UIImage, to size: CGSize) -> UIImage? {
            let renderer = UIGraphicsImageRenderer(size: size)
            return renderer.image { _ in
                image.draw(in: CGRect(origin: .zero, size: size))
            }
        }
    
    static func hash(data: Data, using hashFunction: any HashFunction.Type) -> String {
        let digest = hashFunction.hash(data: data)
        let hashString = digest
            .compactMap { String(format: "%02x", $0) }
            .joined()
        return hashString
    }

    
    static func submitData(faceImage: UIImage, idImage: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        // Resize and compress images
        guard let resizedFaceImage = resizeAndCompressImage(image: faceImage, to: CGSize(width: 640, height: 480)),
              let resizedIDImage = resizeAndCompressImage(image: idImage, to: CGSize(width: 640, height: 480)) else {
            // Handle resizing failure
            print("Error: Failed to resize and compress images.")
            completion(.failure("Error: Failed to resize and compress images." as! Error))
            return
        }

        // Convert images to Base64 encoded strings
        let faceImageData = resizedFaceImage.jpegData(compressionQuality: 0.9)!
        let idImageData = resizedIDImage.jpegData(compressionQuality: 0.9)!

        let faceBase64String = faceImageData.base64EncodedString()
        let idBase64String = idImageData.base64EncodedString()
        let PUBLIC_KEY = "GinJjXphs2qykFHScCVFMrKxiSbVGEtDRQR"
        let valPRIVATE_KEY = "yN4R5v7M3bhxs6r4z9SoHzPRVmYNQy4erDt"
        let nin = "00000000000"
        
        let message = "yN4R5v7M3bhxs6r4z9SoHzPRVmYNQy4erDt00000000000".data(using: .utf8)!
        
        let hashStringSHA512 = hash(data: message, using: SHA512.self)

        // Construct media array for the request
        let mediaArray: [[String: Any]] = [
            ["media": faceBase64String, "type": 2, "mediaType": "image"],
            ["media": faceBase64String, "type": 6, "mediaType": "image"],
            ["media": faceBase64String, "type": 6, "mediaType": "image"],
            ["media": faceBase64String, "type": 6, "mediaType": "image"],
            ["media": faceBase64String, "type": 6, "mediaType": "image"],
            ["media": faceBase64String, "type": 6, "mediaType": "image"],
            ["media": faceBase64String, "type": 6, "mediaType": "image"],
            ["media": faceBase64String, "type": 6, "mediaType": "image"],
            ["media": faceBase64String, "type": 6, "mediaType": "image"],
            ["media": idBase64String, "type": 3, "mediaType": "image"]
        ]

        // Construct request parameters
        var parameters: [String: Any] = [
            "nin": nin,
            "meta": [:],
            "media": mediaArray,
            "livelinessCheck": true,
            "hash": hashStringSHA512,
        ]
        
        let combinedString = valPRIVATE_KEY + nin

        // Hash the combined string using SHA-512
        if let combinedData = combinedString.data(using: .utf8) {
            let hashedData = SHA512.hash(data: combinedData)
            let hashString = hashedData.compactMap { String(format: "%02x", $0) }.joined()
            
            // Store the hash in a variable
            let combinedStringHash = hashString
            
            // Assign hash to parameters
            parameters["hash"] = combinedStringHash
            
            // Now parameters["hash"] contains the SHA-512 hash of combinedString
            print("Parameters with hash:", parameters)
        } else {
            print("Error: Failed to convert combined string to data.")
        }

        // Construct the request
        let url = URL(string: "https://compliance-data-service.dev-flutterwave.com/data/api/v1/nin/verify")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(PUBLIC_KEY, forHTTPHeaderField: "publicKey")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Convert parameters to JSON data
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error serializing JSON: \(error)")
            completion(.failure("Error serializing JSON: \(error)" as! Error))
            return
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error uploading images: \(error)")
                    completion(.failure(error))
                    return
                }

                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    if responseString.contains("\"status\":\"error\"") {
                        // Extract the error message
                        if let errorMessage = responseString.extractStringBetween("\"message\":\"", "\"") {
                            print("Error message received: \(errorMessage)")
                            completion(.failure(NSError(domain: "YourAppDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                            return
                        }
                    }

                    // If no error status found, return success with the response string
                    print("Response: \(responseString)")
                    completion(.success(responseString))
                } else {
                    let error = NSError(domain: "YourAppDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse response data"])
                    completion(.failure(error))
                }
            }
        }.resume()
    }

}
