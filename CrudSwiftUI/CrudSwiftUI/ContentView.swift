import SwiftUI
import CoreData

struct ContentView: View {
    let coreDM: CoreDataManager
    @State var idPedido = ""
    @State var cliente = ""
    @State var articulo = ""
    @State var fechaEntrega = ""
    @State var direccion = ""
    @State var total = ""
    @State var estado = ""
    @State var newidPedido = ""
    @State var newcliente = ""
    @State var newarticulo = ""
    @State var newfechaEntrega = ""
    @State var newdireccion = ""
    @State var newtotal = ""
    @State var newestado = ""
    @State var seleccionado: Pedidos?
    @State var prodArray = [Pedidos]()
    @State var isTapped = false


    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: VStack{
                    TextField("Pedido ID", text: self.$newidPedido)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Cliente", text: self.$newcliente)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Articulo", text: self.$newarticulo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Fecha de Entrega", text: self.$newfechaEntrega)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Direccion", text: self.$newdireccion)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Total", text: self.$newtotal)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Estado" , text: self.$newestado)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button("Guardar"){
                        coreDM.guardarPedidos(idPedido: newidPedido, cliente: newcliente, articulo: newarticulo, fechaEntrega: newfechaEntrega, direccion: newdireccion, total: newtotal, estado: newestado)
                        newidPedido = ""
                        newcliente = ""
                        newarticulo = ""
                        newfechaEntrega = ""
                        newdireccion = ""
                        newtotal = ""
                        newestado = ""
                        mostrarPedidos()
                    }
                }.padding()){
                    Text("Agregar")
                }
                
                

                List{
                    ForEach(prodArray, id: \.self){
                        prod in
                        VStack{
                            Text(" PedidoID: ") + Text(prod.idPedido ?? "")
                        }
                        .onTapGesture{
                            seleccionado = prod
                            idPedido = prod.idPedido ?? ""
                            cliente = prod.cliente ?? ""
                            articulo = prod.articulo ?? ""
                            fechaEntrega = prod.fechaEntrega ?? ""
                            direccion = prod.direccion ?? ""
                            total = prod.total ?? ""
                            estado = prod.estado ?? ""
                            isTapped.toggle()
                        }
                    }.onDelete(perform: {
                        indexSet in
                        indexSet.forEach({ index in
                        let pedidos = prodArray[index]
                            coreDM.borrarPedidos(pedidos: pedidos)
                        mostrarPedidos()
                        })
                    })
                }.padding()
                    .onAppear(perform: {mostrarPedidos()})
                
                NavigationLink("",destination: VStack{
                    TextField("Pedido ID", text: self.$idPedido)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Cliente", text: self.$cliente)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Articulo", text: self.$articulo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Fecha de Entrega", text: self.$fechaEntrega)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Direccion", text: self.$direccion)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Total", text: self.$total)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Estado" , text: self.$estado)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button("Actualizar"){
                        seleccionado?.idPedido = idPedido
                        seleccionado?.cliente = cliente
                        seleccionado?.articulo = articulo
                        seleccionado?.fechaEntrega = fechaEntrega
                        seleccionado?.direccion = direccion
                        seleccionado?.total = total
                        seleccionado?.estado = estado
                        coreDM.actualizarPedidos(pedidos: seleccionado!)
                        idPedido = ""
                        cliente = ""
                        articulo = ""
                        fechaEntrega = ""
                        direccion = ""
                        total = ""
                        estado = ""
                        mostrarPedidos()
                    }
                }.padding(), isActive: $isTapped)
                    
            }
        }
    }
    func mostrarPedidos(){
            prodArray = coreDM.leerTodosLosPedidos()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
