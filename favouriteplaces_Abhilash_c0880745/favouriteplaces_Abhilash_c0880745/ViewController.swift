import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    let tableView = UITableView()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)
        cell.textLabel?.text = favoritePlaces[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favoritePlaces.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBOutlet weak var favouritePlaces: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PlaceCell")
    }
}

var favoritePlaces:[String] = []
func addPlace(place:String){
    favoritePlaces.append(place)
}

class AddPlaceViewController: UIViewController {
    let placeNameTextField = UITextField()
    let addButton = UIButton()
}
