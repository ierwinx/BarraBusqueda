import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tabla: UITableView!
    
    let animales: [String] = [
        "Perro","Gato","Lobo","Raton","Leon","Pajaro","Marmota","Nutria","Castor","Caballo", "Cerdo", "Gallina", "Gallo", "Toro", "Jirafa", "Pikachu", "Koala", "Guepardo", "Oso", "Aguila"
    ]
    
    var filtroAnimales: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filtroAnimales = animales
        
        tabla.delegate = self
        tabla.dataSource = self
        
        creaBarra()
    }
    
    private func creaBarra() {
        let barra = UISearchController(searchResultsController: nil)
        barra.searchResultsUpdater = self
        self.navigationItem.searchController = barra
    }
    
}

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let busqueda = searchController.searchBar.text
        
        if busqueda?.replacingOccurrences(of: " ", with: "") == "" {
            filtroAnimales = animales
        } else {
            filtroAnimales = animales.filter { animal -> Bool in
                let parecido = animal.lowercased().contains(busqueda?.lowercased() ?? "")
                return parecido
            }
        }
        
        self.tabla.reloadData()
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtroAnimales.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        celda.textLabel?.text = filtroAnimales[indexPath.row]
        return celda
    }
    
    
}
