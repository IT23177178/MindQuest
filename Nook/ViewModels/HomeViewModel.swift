
import SwiftUI

@MainActor
@Observable
final class HomeViewModel {

    let moods = Mood.featured

    let movies: [Movie] = [

        // MARK: - Featured Playable Story

        Movie(
            title: "Snow Bear",
            subtitle: "A little story about friendship",
            mood: "Wind Down",
            description: "Enjoy a gentle, ten-minute 2D animated short about a snow bear.",
            artworkName: "snow-bear",
            isPlayable: true
        ),

        // MARK: - Rainy Day

        Movie(
            title: "The Many Adventures of Winnie the Pooh",
            subtitle: "Little adventures with old friends",
            mood: "Rainy Day",
            description: "Join Winnie the Pooh and his friends for gentle adventures in the Hundred Acre Wood.",
            artworkName: "WinnieThePooh"
        ),

        Movie(
            title: "My Neighbor Totoro",
            subtitle: "A magical forest adventure",
            mood: "Rainy Day",
            description: "Two sisters discover a magical world of forest spirits and unexpected friendship.",
            artworkName: "MyNeighborTotoro"
        ),

        Movie(
            title: "Ponyo",
            subtitle: "A magical seaside adventure",
            mood: "Rainy Day",
            description: "A young boy befriends a mysterious fish-girl whose wish to become human changes their world.",
            artworkName: "Ponyo"
        ),

        Movie(
            title: "The Snowman",
            subtitle: "A winter night to remember",
            mood: "Rainy Day",
            description: "A young boy experiences a magical adventure with a snowman he brings to life.",
            artworkName: "TheSnowman"
        ),

        Movie(
            title: "The Bear and the Hare",
            subtitle: "A woodland Christmas tale",
            mood: "Rainy Day",
            description: "A heartwarming animated Christmas story set in a snowy woodland.",
            artworkName: "TheBearAndTheHare"
        ),

        Movie(
            title: "The Secret World of Arrietty",
            subtitle: "A tiny world full of wonder",
            mood: "Rainy Day",
            description: "A tiny Borrower living beneath a family's floorboards discovers friendship and a world much larger than her own.",
            artworkName: "TheSecretWorldOfArrietty"
        ),

        Movie(
            title: "Paddington",
            subtitle: "A bear finds a home",
            mood: "Rainy Day",
            description: "A polite bear from Peru discovers a new home and unexpected adventures in London.",
            artworkName: "Paddington"
        ),

        // MARK: - Fantasy

        Movie(
            title: "The Secret of Kells",
            subtitle: "An illuminated world of magic",
            mood: "Fantasy",
            description: "A young boy discovers courage, creativity and ancient mysteries in a walled medieval town.",
            artworkName: "TheSecretOfKells"
        ),

        Movie(
            title: "Song of the Sea",
            subtitle: "A journey through Irish folklore",
            mood: "Fantasy",
            description: "A brother and sister embark on a magical journey inspired by Irish legends.",
            artworkName: "SongOfTheSea"
        ),

        Movie(
            title: "Mary and the Witch's Flower",
            subtitle: "A flower with extraordinary powers",
            mood: "Fantasy",
            description: "A curious girl discovers a mysterious flower that leads her to a school of magic.",
            artworkName: "MaryAndTheWitchsFlower"
        ),

        Movie(
            title: "The Chronicles of Narnia: The Lion, the Witch and the Wardrobe",
            subtitle: "Beyond the wardrobe",
            mood: "Fantasy",
            description: "Four siblings enter a magical land filled with extraordinary creatures and an epic adventure.",
            artworkName: "NarniaLionWitchWardrobe"
        ),

        Movie(
            title: "The Chronicles of Narnia: Prince Caspian",
            subtitle: "Return to a magical kingdom",
            mood: "Fantasy",
            description: "The Pevensie siblings return to Narnia to help Prince Caspian reclaim his kingdom.",
            artworkName: "NarniaPrinceCaspian"
        ),

        // MARK: - Nature

        Movie(
            title: "Wonders of the Reef",
            subtitle: "Discover life beneath the waves",
            mood: "Nature",
            description: "Explore the colourful marine life and remarkable ecosystems found in coral reefs.",
            artworkName: "WondersOfTheReef"
        ),

        Movie(
            title: "The Black Stallion",
            subtitle: "An extraordinary bond",
            mood: "Nature",
            description: "A boy and a wild horse form a remarkable friendship after surviving a shipwreck.",
            artworkName: "TheBlackStallion"
        ),

        Movie(
            title: "The Secret of Roan Inish",
            subtitle: "A mystery by the sea",
            mood: "Nature",
            description: "A young girl explores family legends and the mysteries of a remote Irish island.",
            artworkName: "TheSecretOfRoanInish"
        ),

        Movie(
            title: "Duma",
            subtitle: "A journey across the wild",
            mood: "Nature",
            description: "A boy sets out on an adventurous journey across the African landscape with a cheetah.",
            artworkName: "Duma"
        ),

        Movie(
            title: "The Green Planet",
            subtitle: "A closer look at plant life",
            mood: "Nature",
            description: "Discover the fascinating lives of plants and the remarkable ways they interact with their surroundings.",
            artworkName: "TheGreenPlanet"
        ),

        Movie(
            title: "Blue Planet",
            subtitle: "Explore our ocean world",
            mood: "Nature",
            description: "Discover the extraordinary animals and environments that make up our oceans.",
            artworkName: "BluePlanet"
        ),

        // MARK: - Wind Down

        Movie(
            title: "Puffin Rock",
            subtitle: "Little discoveries on a big island",
            mood: "Wind Down",
            description: "Join Oona, Baba and their friends as they explore the gentle wonders of their island home.",
            artworkName: "PuffinRock"
        ),

        Movie(
            title: "Sarah & Duck",
            subtitle: "Quietly curious adventures",
            mood: "Wind Down",
            description: "Join Sarah and her best friend Duck for imaginative adventures in their everyday world.",
            artworkName: "SarahAndDuck"
        ),

        Movie(
            title: "Stillwater",
            subtitle: "Stories that help us understand",
            mood: "Wind Down",
            description: "Three siblings learn about themselves and the world with help from a wise panda named Stillwater.",
            artworkName: "Stillwater"
        ),

        Movie(
            title: "The Snowy Day",
            subtitle: "A little wonder in the snow",
            mood: "Wind Down",
            description: "Experience the simple joys and discoveries of a child exploring a snowy neighbourhood.",
            artworkName: "TheSnowyDay"
        ),

        Movie(
            title: "Mister Rogers' Neighborhood",
            subtitle: "A welcoming place to learn",
            mood: "Wind Down",
            description: "Enjoy thoughtful conversations, gentle lessons and visits to the Neighborhood of Make-Believe.",
            artworkName: "MisterRogersNeighborhood"
        ),

        Movie(
            title: "Tumble Leaf",
            subtitle: "Discover something new every day",
            mood: "Wind Down",
            description: "Follow Fig the fox on playful adventures as he discovers how the world works.",
            artworkName: "TumbleLeaf"
        )
    ]

    // MARK: - Featured Story

    var featuredMovie: Movie? {
        movies.first
    }

    // MARK: - Filter by Mood

    func movies(for mood: Mood) -> [Movie] {
        movies.filter { $0.mood == mood.title }
    }

    // MARK: - Playable Movie

    var playableMovie: Movie? {
        movies.first { $0.isPlayable }
    }
}
