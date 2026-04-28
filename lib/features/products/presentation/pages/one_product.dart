import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/one_product/product_bloc.dart';

class OneProduct extends StatefulWidget {
  final int productId;

  const OneProduct({super.key, required this.productId});

  @override
  State<OneProduct> createState() => _OneProductState();
}

class _OneProductState extends State<OneProduct> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(SingleProductRequested(id: widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          if (state is ProductLoaded) {
            final p = state.product;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(p.thumbnail, width: double.infinity, height: 250, fit: BoxFit.cover),
                  const SizedBox(height: 16),
                  Text(p.title, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text('\$${p.price}', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(p.description),
                  const SizedBox(height: 8),
                  Text('Category: ${p.category}'),
                  Text('Brand: ${p.brand}'),
                  Text('Rating: ${p.rating}'),
                  Text('Stock: ${p.stock}'),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
