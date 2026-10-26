import 'package:flutter/material.dart';
import 'payment_page.dart';

const Color appBrown = Color(0xFF795548);
const Color appCream = Color(0xFFFFF8EE);
const Color appOrange = Color(0xFFFFB74D);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedCategory = 'All';
  String _searchQuery = '';

  // List ng mga produkto na may tunay na Image URLs
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Lucky Me Pancit Canton',
      'price': 15.00,
      'category': 'Pagkain',
      'imageUrl': 'https://images.unsplash.com/photo-1612927601601-6638404737ce?w=500&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Cup Noodles',
      'price': 30.00,
      'category': 'Pagkain',
      'imageUrl': 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=500&auto=format&fit=crop&q=60',
    },
    {
      'name': 'SkyFlakes Biscuits',
      'price': 8.00,
      'category': 'Pagkain',
      'imageUrl': 'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=500&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Potato Chips',
      'price': 18.00,
      'category': 'Pagkain',
      'imageUrl': 'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=500&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Coca-Cola Can',
      'price': 20.00,
      'category': 'Inumin',
      'imageUrl': 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=500&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Bottled Water',
      'price': 15.00,
      'category': 'Inumin',
      'imageUrl': 'https://images.unsplash.com/photo-1548839140-29a749e1bc4e?w=500&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Fruit Juice',
      'price': 12.00,
      'category': 'Inumin',
      'imageUrl': 'https://images.unsplash.com/photo-1600271886742-f049cd451bba?w=500&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Hot Coffee',
      'price': 10.00,
      'category': 'Inumin',
      'imageUrl': 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=500&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Sardinas (Canned Goods)',
      'price': 25.00,
      'category': 'De-lata',
      'imageUrl': 'https://images.unsplash.com/photo-1534483509719-3feaee7c30da?w=500&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Corned Beef',
      'price': 35.00,
      'category': 'De-lata',
      'imageUrl': 'https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Evaporated Milk',
      'price': 18.00,
      'category': 'De-lata',
      'imageUrl': 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=500&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Laundry Detergent',
      'price': 12.00,
      'category': 'Panglinis',
      'imageUrl': 'https://images.unsplash.com/photo-1585832770485-e68a5fcfad52?w=500&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Dishwashing Soap',
      'price': 10.00,
      'category': 'Panglinis',
      'imageUrl': 'https://images.unsplash.com/photo-1607613009820-a29f7bb81c04?w=500&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Shampoo Sachet',
      'price': 7.00,
      'category': 'Personal Care',
      'imageUrl': 'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?w=500&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Toothpaste',
      'price': 15.00,
      'category': 'Personal Care',
      'imageUrl': 'https://images.unsplash.com/photo-1559598467-f8b76c8155d0?w=500&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Tissue Roll',
      'price': 10.00,
      'category': 'Personal Care',
      'imageUrl': 'https://images.unsplash.com/photo-1584556812952-905ffd0c611a?w=500&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Candies',
      'price': 1.00,
      'category': 'Meryenda',
      'imageUrl': 'https://images.unsplash.com/photo-1582058091505-f87a2e55a40f?w=500&auto=format&fit=crop&q=60',
    },
    {
      'name': 'Chocolates',
      'price': 15.00,
      'category': 'Meryenda',
      'imageUrl': 'https://images.unsplash.com/photo-1511381939415-e44015466834?w=500&auto=format&fit=crop&q=60',
    },
  ];

  final Map<String, int> cart = {};

  final List<String> categories = [
    'All',
    'Pagkain',
    'Inumin',
    'De-lata',
    'Panglinis',
    'Personal Care',
    'Meryenda',
  ];

  List<Map<String, dynamic>> get filteredProducts {
    return products.where((product) {
      final matchesCategory = _selectedCategory == 'All' ||
          product['category'] == _selectedCategory;

      final matchesSearch = product['name']
          .toString()
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();
  }

  int get cartCount {
    return cart.values.fold(
      0,
      (sum, quantity) => sum + quantity,
    );
  }

  double get cartTotal {
    double total = 0;

    for (final entry in cart.entries) {
      final product = products.firstWhere(
        (product) => product['name'] == entry.key,
      );

      total += (product['price'] as num).toDouble() * entry.value;
    }

    return total;
  }

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      final name = product['name'] as String;
      cart[name] = (cart[name] ?? 0) + 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['name']} added to cart!'),
        duration: const Duration(milliseconds: 900),
        backgroundColor: appBrown,
      ),
    );
  }

  void openCart() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: appCream,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            void changeQuantity(String name, int change) {
              setState(() {
                final newQuantity = (cart[name] ?? 0) + change;

                if (newQuantity <= 0) {
                  cart.remove(name);
                } else {
                  cart[name] = newQuantity;
                }
              });

              setSheetState(() {});
            }

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'My Shopping Cart',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: appBrown,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: cart.isEmpty
                            ? const Center(
                                child: Text(
                                  'Wala pang laman ang cart mo.',
                                ),
                              )
                            : ListView(
                                children: cart.entries.map((entry) {
                                  final product = products.firstWhere(
                                    (p) => p['name'] == entry.key,
                                  );

                                  final price =
                                      (product['price'] as num).toDouble();

                                  return Card(
                                    color: Colors.white,
                                    margin: const EdgeInsets.only(bottom: 8),
                                    child: ListTile(
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          product['imageUrl'] as String,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) =>
                                              Container(
                                            width: 50,
                                            height: 50,
                                            color: Colors.brown.shade50,
                                            child: const Icon(Icons.storefront, color: appBrown),
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        entry.key,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        '₱${price.toStringAsFixed(2)} bawat isa\n'
                                        'Subtotal: ₱${(price * entry.value).toStringAsFixed(2)}',
                                      ),
                                      isThreeLine: true,
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () => changeQuantity(
                                              entry.key,
                                              -1,
                                            ),
                                            icon: const Icon(
                                              Icons.remove_circle_outline,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                          Text(
                                            '${entry.value}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () => changeQuantity(
                                              entry.key,
                                              1,
                                            ),
                                            icon: const Icon(
                                              Icons.add_circle_outline,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                      ),
                      const Divider(thickness: 1.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '₱${cartTotal.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: cart.isEmpty
                              ? null
                              : () {
                                  final checkoutItems =
                                      cart.entries.map((entry) {
                                    final product = products.firstWhere(
                                      (p) => p['name'] == entry.key,
                                    );

                                    final price =
                                        (product['price'] as num).toDouble();

                                    return <String, dynamic>{
                                      'name': product['name'],
                                      'price': price,
                                      'quantity': entry.value,
                                      'subtotal': price * entry.value,
                                    };
                                  }).toList();

                                  final checkoutTotal = cartTotal;

                                  Navigator.pop(sheetContext);

                                  Navigator.of(this.context).push(
                                    MaterialPageRoute<void>(
                                      builder: (_) => PaymentPage(
                                        cartItems: checkoutItems,
                                        totalAmount: checkoutTotal,
                                      ),
                                    ),
                                  );
                                },
                          icon: const Icon(Icons.payment),
                          label: const Text(
                            'Proceed to Checkout',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appBrown,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayedProducts = filteredProducts;

    return Scaffold(
      backgroundColor: appCream,
      appBar: AppBar(
        backgroundColor: appBrown,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.storefront, size: 30),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Sari-Sari Store',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: openCart,
            icon: Badge(
              label: Text('$cartCount'),
              isLabelVisible: cartCount > 0,
              child: const Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
            tooltip: 'Shopping Cart',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Welcome banner
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  appBrown,
                  Color(0xFFA1887F),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Magandang araw! 👋',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Hanap mo, bili mo! Mga paninda para sa araw-araw.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Maghanap ng paninda...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                        icon: const Icon(Icons.close),
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Categories
          SizedBox(
            height: 44,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = categories[index];
                final selected = _selectedCategory == category;

                return ChoiceChip(
                  label: Text(category),
                  selected: selected,
                  selectedColor: appBrown,
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : appBrown,
                    fontWeight: FontWeight.w600,
                  ),
                  onSelected: (_) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // Product heading
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Mga Paninda',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: appBrown,
                  ),
                ),
                Text(
                  '${displayedProducts.length} produkto',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Product grid kasama ang tunay na larawan
          Expanded(
            child: displayedProducts.isEmpty
                ? const Center(
                    child: Text('Walang produktong nakita.'),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 230,
                      mainAxisExtent: 235,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: displayedProducts.length,
                    itemBuilder: (context, index) {
                      final product = displayedProducts[index];
                      final price = (product['price'] as num).toDouble();
                      final imageUrl = product['imageUrl'] as String;

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.brown.shade100,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.brown.withAlpha(15),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    imageUrl,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        color: Colors.grey.shade100,
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: appBrown,
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      color: Colors.grey.shade200,
                                      child: const Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 40,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product['name'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '₱${price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: appBrown,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: double.infinity,
                                height: 32,
                                child: ElevatedButton.icon(
                                  onPressed: () => addToCart(product),
                                  icon: const Icon(
                                    Icons.add_shopping_cart,
                                    size: 15,
                                  ),
                                  label: const Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: appBrown,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}