import Foundation
import CoreData

class CoreDataManager{
    let persistentContainer: NSPersistentContainer

    init(){
        persistentContainer = NSPersistentContainer(name: "Pedidos")
        persistentContainer.loadPersistentStores(completionHandler:{
            (descripcion, error) in
            if let error = error {
                fatalError("Core data failed \(error.localizedDescription)")
            }
        })
    }

    func guardarPedidos(idPedido: String, cliente: String, articulo: String, fechaEntrega: String, direccion: String, total: String, estado: String){
        let pedidos = Pedidos(context: persistentContainer.viewContext)
        pedidos.idPedido = idPedido
        pedidos.cliente = cliente
        pedidos.articulo =  articulo
        pedidos.fechaEntrega = fechaEntrega
        pedidos.direccion = direccion
        pedidos.total = total
        pedidos.estado = estado
        
        do{
            try persistentContainer.viewContext.save()
            print("producto guardado")
        }
        catch{
            print("failed to save error")
        }
    }

    func leerTodosLosPedidos() -> [Pedidos]{
        let fetchRequest: NSFetchRequest<Pedidos> = Pedidos.fetchRequest()

        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch{
            return []
        }
    }

    func borrarPedidos(pedidos: Pedidos){
        persistentContainer.viewContext.delete(pedidos)

        do{
            try persistentContainer.viewContext.save()
        }catch{
            persistentContainer.viewContext.rollback()
            print("Failed to save context")
        }
    }

    func actualizarPedidos(pedidos: Pedidos){
        let fetchRequest: NSFetchRequest<Pedidos> = Pedidos.fetchRequest()
        let predicate = NSPredicate(format: "idPedido = %@", pedidos.idPedido ?? "")
        fetchRequest.predicate = predicate


        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            let p = datos.first
            p?.idPedido = pedidos.idPedido
            try persistentContainer.viewContext.save()
            print("Pedido Actualizado")
        }catch{
            print("failed to save error en \(error)")
        }
    }

    func leerPedidos(idPedido: String) -> Pedidos?{
        let fetchRequest: NSFetchRequest<Pedidos> = Pedidos.fetchRequest()
        let predicate = NSPredicate(format: "idPedido = %@", idPedido)
        fetchRequest.predicate = predicate
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            return datos.first
        }catch{
            print("failed to save error en \(error)")
        }
        return nil
    }
}
