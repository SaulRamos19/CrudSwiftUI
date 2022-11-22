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


    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: VStack{
                    TextField("Pedido ID", text: self.$newidPedido)
                        .padding()
                        .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    TextField("Cliente", text: self.$newcliente).multilineTextAlignment(.center)
                    TextField("Articulo", text: self.$newarticulo).multilineTextAlignment(.center)
                    TextField("Fecha de Entrega", text: self.$newfechaEntrega).multilineTextAlignment(.center)
                    TextField("Direccion", text: self.$newdireccion).multilineTextAlignment(.center)
                    TextField("Total", text: self.$newtotal).multilineTextAlignment(.center)
                    TextField("Estado" , text: self.$newestado).multilineTextAlignment(.center)

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
                    }){
                    Text("Agregar")
                }
                
                

                List{
                    ForEach(prodArray, id: \.self){
                        prod in
                        VStack{
                            Text(prod.cliente ?? "")
                        }
                        .onTapGesture{
                            seleccionado = prod
                            idPedido = prod.idPedido ?? ""
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
