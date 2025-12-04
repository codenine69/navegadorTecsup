import 'package:flutter/material.dart';

 const Color primaryColor = Color(0xFF1E3A8A);  
const Color secondaryColor = Color(0xFFF3F4F6);  
const Color accentColor = Color(0xFF3B82F6);  

void main() {
  runApp(const NavegadorApp());
}

class NavegadorApp extends StatelessWidget {
  const NavegadorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navicury Smart Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: secondaryColor,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
 
 // 1. PÁGINA DE INICIO (HOME PAGE) 

 class HomePage extends StatelessWidget {
  const HomePage({super.key});
 
  final String backgroundImageUrl = 'https://www.reliant.com/content/dam/reliant/en/media/blogs/thermostat_75-800x400.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      appBar: AppBar(
        title: const Text('Navicury', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,  
      body: Stack(
        children: [
          //   IMAGEN DE FONDO   
          Image.network(
            backgroundImageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
     
          ),

          //  CONTENIDO CENTRAL  
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              
                const Text(
                  'Navicury',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, 
                  ),
                ),
                const SizedBox(height: 50),
                
               
                GestureDetector(
                  onTap: () {
                   
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SpacesAndEquipmentPage(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                    
                      Image.network(
                        'https://placehold.co/80x80/808080/FFFFFF?text=%F0%9F%96%A4', 
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.fingerprint,
                                size: 80, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Presiona para entrar',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
     
      ),
    );
  }
}
 
// 2. PÁGINA DE ESPACIOS Y EQUIPOS 
 

class SpacesAndEquipmentPage extends StatelessWidget {
  const SpacesAndEquipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navicury')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ESPACIOS 
            const Text('Espacios',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor)),
            const SizedBox(height: 10),
            // Fila de botones  
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['A', 'B', 'C']
                  .map((space) => SpaceButton(spaceName: space))
                  .toList(),
            ),
            const Divider(height: 40, thickness: 1),

            //  EQUIPOS CONECTADOS
            const Text('Equipos conectados',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor)),
            const SizedBox(height: 10),

          
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.5,
              children: const [
                EquipmentCard(
                    name: 'TV Cuarto',
                    iconUrl:
                        'https://placehold.co/60x60/9CA3AF/FFFFFF?text=TV',
                    manufacturer: 'Sony',
                    model: 'Bravia 4K',
                    mac: 'AA:BB:CC:DD:EE:FF'),
                EquipmentCard(
                    name: 'Refrigeradora',
                    iconUrl:
                        'https://placehold.co/60x60/9CA3AF/FFFFFF?text=REF',
                    manufacturer: 'LG',
                    model: 'SmartInstaView',
                    mac: '00:11:22:33:44:55'),
                EquipmentCard(
                    name: 'Puerta Sala',
                    iconUrl:
                        'https://placehold.co/60x60/9CA3AF/FFFFFF?text=DOOR',
                    manufacturer: 'Yale',
                    model: 'DigitalLock',
                    mac: '1A:2B:3C:4D:5E:6F'),
                EquipmentCard(
                    name: 'Cochera',
                    iconUrl:
                        'https://placehold.co/60x60/9CA3AF/FFFFFF?text=CAR',
                    manufacturer: 'LiftMaster',
                    model: '8550W',
                    mac: 'FE:DC:BA:98:76:54'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget para los botones de Espacios 
class SpaceButton extends StatelessWidget {
  final String spaceName;
  const SpaceButton({required this.spaceName, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SettingsPage(spaceName: spaceName),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: primaryColor, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Text(
          spaceName,
          style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor),
        ),
      ),
    );
  }
}

// Widget para las tarjetas de Equipos 
class EquipmentCard extends StatelessWidget {
  final String name;
  final String iconUrl;
  final String manufacturer;
  final String model;
  final String mac;

  const EquipmentCard({
    required this.name,
    required this.iconUrl,
    required this.manufacturer,
    required this.model,
    required this.mac,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
           
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EquipmentDetailPage(
                  name: name,
                  manufacturer: manufacturer,
                  model: model,
                  mac: mac),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                iconUrl,
                width: 40,
                height: 40,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.devices, size: 40, color: accentColor),
              ),
              const Spacer(),
              Text(
                name,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

 
// 3. PÁGINA DE AJUSTES 
 
class SettingsPage extends StatefulWidget {
  final String spaceName;
  const SettingsPage({required this.spaceName, super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _lightValue1 = 51.0;
  double _lightValue2 = 51.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajustes: ${widget.spaceName}')),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ajustar',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
              const SizedBox(height: 20),
              // Primer Slider de Luz
              const Text('Luz Principal', style: TextStyle(fontSize: 16)),
              Slider(
                value: _lightValue1,
                min: 0,
                max: 100,
                divisions: 100,
                label: _lightValue1.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _lightValue1 = value;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('0', style: TextStyle(fontSize: 12)),
                  Text('${_lightValue1.round()}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  const Text('100', style: TextStyle(fontSize: 12)),
                ],
              ),
              const Divider(height: 30),

              // Segundo Slider de Luz
              const Text('Luz Ambiente', style: TextStyle(fontSize: 16)),
              Slider(
                value: _lightValue2,
                min: 0,
                max: 100,
                divisions: 100,
                label: _lightValue2.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _lightValue2 = value;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('0', style: TextStyle(fontSize: 12)),
                  Text('${_lightValue2.round()}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  const Text('100', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 
// 4. PÁGINA DE DETALLE DE EQUIPO  
 
 
class EquipmentDetailPage extends StatefulWidget {
  final String name;
  final String manufacturer;
  final String model;
  final String mac;

  const EquipmentDetailPage({
    required this.name,
    required this.manufacturer,
    required this.model,
    required this.mac,
    super.key,
  });

  @override
  State<EquipmentDetailPage> createState() => _EquipmentDetailPageState();
}

class _EquipmentDetailPageState extends State<EquipmentDetailPage> {
  // Estado para el botón
  bool _isPoweredOn = false;

  void _togglePower() {
    setState(() {
      _isPoweredOn = !_isPoweredOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
              const Divider(height: 20),
              _buildDetailRow('Fabricante', widget.manufacturer),
              _buildDetailRow('Modelo', widget.model),
              _buildDetailRow('MAC', widget.mac),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _togglePower,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isPoweredOn ? Colors.red : primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    _isPoweredOn ? 'Apagar' : 'Encender',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Estado: ${_isPoweredOn ? 'Encendido' : 'Apagado'}',
                  style: TextStyle(
                    color: _isPoweredOn ? Colors.green.shade600 : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //  filas de detalle
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}