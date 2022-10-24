//
//  ChuckNorrisService.swift
//  ChuckHW
//
//  Created by Yair Kerem on 29/06/2022.
//

import UIKit

class ChuckNorrisService {
    static let shared: ChuckNorrisService = ChuckNorrisService()
    static let defaultImage = "https://springframework.guru/wp-content/uploads/2016/12/chuck-norris-dont-write-code.jpg"
    
    private init() {
        //Making the init private prevents us from creating an instance of ChuckNorrisService and forces us to use the "shared" singleton instead. The init is empty because we have nothing to initialize. If we didn't give countOfJokes a value in its declaration for example we would have needed to set it here.
    }
    
    var chuckJokes: [Joke] = []
    var countOfJokes: Int = 30
    
    func chuckNorrisTitle() -> String {
        return "\(chuckJokes.count) Chuck Norris jokes:"
    }
    
    func getChuckImage(chuckNorrisImage: String) async -> UIImage? {
        let chuckNorrisImageName = "chuckNorris.jpg"
        //        I've removed the following getImage (from storage) because I use multiple imagesן
        //        if let chuckNorrisImage = StorageService.getImage(imageName: chuckNorrisImageName) {
        //            return(chuckNorrisImage)
        //
        //        }
        
        // Else go download the image
        let mainImageStr = chuckNorrisImage
        guard let mainImageURL = URL(string: mainImageStr) else {
            return nil
        }
        
        let (data, _) = try! await URLSession.shared.data(from: mainImageURL)
        if let image = UIImage(data: data) {
            StorageService.saveImage(data: data, imageName: chuckNorrisImageName)
            return image
        }
        return nil
    }
    
    
    func getChuckJokes() async {
        let jokeURLstr = "https://api.chucknorris.io/jokes/random"
        guard let jokeURL = URL(string: jokeURLstr) else {
            return
        }
        for _ in 1...countOfJokes {
            if let joke = await getJoke(jokeURL: jokeURL) {
                self.chuckJokes.append(joke)
            }
            if self.chuckJokes.count == self.countOfJokes {
                return()
            }
        }
    }
    
    func getJoke(jokeURL: URL) async -> Joke? {
        let (data, _) = try! await URLSession.shared.data(from: jokeURL)
        do {
            let joke = try JSONDecoder().decode(Joke.self, from: data)
            return joke
        } catch (let error) {
            print("error:\(error)")
            return nil
        }
    }
    func update(joke: Joke) {
        let changedJokeIndex = ChuckNorrisService.shared.chuckJokes.firstIndex { currentJoke in
            currentJoke.id == joke.id
        }
        
        if let changedJokeIndex = changedJokeIndex {
            ChuckNorrisService.shared.chuckJokes[changedJokeIndex] = joke
        }
    }
    
    func replaceHeroImage(listIndex: Int) -> String {
        let imageList = [
            //            "http://www.fubiz.net/wp-content/uploads/2014/02/10-Chuck-Norris1.jpg",
            "https://images.fineartamerica.com/images/artworkimages/mediumlarge/1/4-chuck-norris-collection-martial-arts-fine-art.jpg",
            "https://i.pinimg.com/originals/20/6d/40/206d40f84ba4d32b791c272f1a4c25b1.jpg",
            "https://www.toonpool.com/user/1667/files/chuck_norris_261525.jpg",
            "https://i.pinimg.com/736x/e5/60/38/e56038e6688e004a0981c1a50d2d21d9.jpg",
            "https://ih1.redbubble.net/image.1910518061.6558/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg",
            "https://cdn.entertainment-focus.com/wp-content/uploads/2017/04/nonstopchuck-feat.jpg",
            "https://i.pinimg.com/236x/9f/fb/a8/9ffba82dd1a1d4ad12595f1dd7733355--chuck-norris-birthday-funny-jokes.jpg",
            "https://images.baklol.com/12_jpeg798d374ebbe96baa27b1a617ecf8e8c7.jpeg",
            "https://static1.srcdn.com/wordpress/wp-content/uploads/2020/03/Chuck-Norris-Stunt-Double-Meme.jpg?q=50&fit=crop&w=737&h=552&dpr=1.5",
        ]
        if listIndex >= 0 && listIndex < imageList.count {
            return imageList[listIndex]
        }
        return ChuckNorrisService.defaultImage
    }
}
