import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/new_product.dart';
import '../bloc/add_product/add_product_bloc.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _discountController = TextEditingController();
  final _stockController = TextEditingController();
  final _brandController = TextEditingController();
  final _categoryController = TextEditingController();
  final _thumbnailController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    _stockController.dispose();
    _brandController.dispose();
    _categoryController.dispose();
    _thumbnailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AddProductBloc>().add(
      AddProductSubmitted(
        NewProduct(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          price: double.parse(_priceController.text.trim()),
          discountPercentage: double.parse(_discountController.text.trim()),
          stock: int.parse(_stockController.text.trim()),
          brand: _brandController.text.trim(),
          category: _categoryController.text.trim(),
          thumbnail: _thumbnailController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddProductBloc, AddProductState>(
      listener: (context, state) {
        if (state is AddProductSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Mahsulot muvaffaqiyatli qo\'shildi!')),
          );
          Navigator.of(context).pop();
        }
        if (state is AddProductError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Product')),
        body: BlocBuilder<AddProductBloc, AddProductState>(
          builder: (context, state) {
            final isLoading = state is AddProductLoading;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildField(
                      controller: _titleController,
                      label: 'Title',
                      enabled: !isLoading,
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Title is required' : null,
                    ),
                    const SizedBox(height: 12),
                    _buildField(
                      controller: _descriptionController,
                      label: 'Description',
                      maxLines: 3,
                      enabled: !isLoading,
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Description is required' : null,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildField(
                            controller: _priceController,
                            label: 'Price',
                            keyboardType: TextInputType.number,
                            enabled: !isLoading,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) return 'Required';
                              if (double.tryParse(v.trim()) == null) return 'Invalid';
                              if (double.parse(v.trim()) <= 0) return 'Must be > 0';
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildField(
                            controller: _discountController,
                            label: 'Discount %',
                            keyboardType: TextInputType.number,
                            enabled: !isLoading,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) return 'Required';
                              final val = double.tryParse(v.trim());
                              if (val == null) return 'Invalid';
                              if (val < 0 || val > 100) return '0–100';
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildField(
                            controller: _stockController,
                            label: 'Stock',
                            keyboardType: TextInputType.number,
                            enabled: !isLoading,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) return 'Required';
                              if (int.tryParse(v.trim()) == null) return 'Invalid';
                              if (int.parse(v.trim()) < 0) return 'Must be ≥ 0';
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildField(
                            controller: _brandController,
                            label: 'Brand',
                            enabled: !isLoading,
                            validator: (v) =>
                                v == null || v.trim().isEmpty ? 'Required' : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildField(
                      controller: _categoryController,
                      label: 'Category',
                      enabled: !isLoading,
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Category is required' : null,
                    ),
                    const SizedBox(height: 12),
                    _buildField(
                      controller: _thumbnailController,
                      label: 'Thumbnail URL',
                      enabled: !isLoading,
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Thumbnail is required' : null,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: isLoading ? null : _submit,
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Add Product'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    bool enabled = true,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
