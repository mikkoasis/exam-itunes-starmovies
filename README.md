# Clear iOS Developer Exam

![Main screen](https://user-images.githubusercontent.com/1173902/90076802-3f1a9a00-dd33-11ea-8964-14d46e262cf1.png)
![Main screen dark](https://user-images.githubusercontent.com/1173902/90076704-05499380-dd33-11ea-818b-d5ec0a2ebd0e.png)
![Detail screen](https://user-images.githubusercontent.com/1173902/90076709-067ac080-dd33-11ea-868b-dbacbb53183a.png)
![Detail screen dark with favourite toggle](https://user-images.githubusercontent.com/1173902/90077797-a6394e00-dd35-11ea-8f49-ab8935804a3a.png)
![Landscape support1](https://user-images.githubusercontent.com/1173902/90076717-0a0e4780-dd33-11ea-9ff4-732d54c2dacd.png)
![Landscape support2](https://user-images.githubusercontent.com/1173902/90076720-0c70a180-dd33-11ea-8e35-220e47d40e27.png)
![iPad support](https://user-images.githubusercontent.com/1173902/90076726-0e3a6500-dd33-11ea-9030-225c4e3a5956.png)

## Features

- [x] Load "Star" movies from iTunes API
- [x] Display movie detail with high resolution photo and description
- [x] Favourite a movie
- [x] Persist favourite movies
- [x] Pull-to-refresh and Load more support
- [x] Dark mode support
- [x] Portrait and landscape support
- [x] Universal app support

## Requirements

- iOS 11.0+
- Xcode 11.5

## Installation and Usage

- Open the project on directory `./Clear/Clear.xcworkspace`
- Select your preferred iOS simulator and run
- Favourite a movie by tapping on an item from list, then tap the "Add to favourites" button on the next screen
- Try dark mode support by pressing `⌘⇧A` while on the simulator
- Try landscape support by pressing `⌘←` or `⌘→` while on the simulator

## Testing

- Unit tests added mainly focused on the viewModels
- Garnered up to 64.2% test coverage

![Unit test coverage](https://user-images.githubusercontent.com/1173902/90077607-2f03ba00-dd35-11ea-8eb5-e85cbced9a44.png)

