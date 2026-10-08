import 'package:nexa/features/products/domain/models/products.dart';

final List<Product> dummyProducts = [
  // --- TOPS ---
  const Product(
    id: "1",
    title: "Minimal Heavyweight Tee",
    category: "Tops",
    price: 48.00,
    rating: 4.8,
    reviewsCount: 215,
    description:
        "Crafted from 280 GSM combed organic cotton. Features a high ribbed collar, dropped shoulder seams, and a boxy silhouette.",
    images: [
      "https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=800&q=80",
    ],
    isFavorite: false,
  ),
  const Product(
    id: "2",
    title: "Regular Fit Piqué Polo",
    category: "Tops",
    price: 68.00,
    rating: 4.6,
    reviewsCount: 142,
    description:
        "Breathable cotton piqué knit with a classic spread collar, two-button mother-of-pearl placket, and ribbed sleeve cuffs.",
    images: [
      "https://images.unsplash.com/photo-1581655353564-df123a1eb820?auto=format&fit=crop&w=800&q=80",
    ],
    isFavorite: true,
  ),
  const Product(
    id: "3",
    title: "Structured Mockneck Longsleeve",
    category: "Tops",
    price: 75.00,
    rating: 4.7,
    reviewsCount: 88,
    description:
        "Double-knit interlock jersey with subtle stretch. High stand collar and clean blind-stitched hemline.",
    images: [
      "https://images.unsplash.com/photo-1618354691373-d851c5c3a990?auto=format&fit=crop&w=800&q=80",
    ],
    isFavorite: false,
  ),
  const Product(
    id: "4",
    title: "Relaxed Linen Overshirt",
    category: "Tops",
    price: 95.00,
    rating: 4.5,
    reviewsCount: 64,
    description:
        "Pure French flax linen garment-washed for a soft drape. Twin chest patch pockets and straight square hem.",
    images: [
      "https://images.unsplash.com/photo-1596755094514-f87e34085b2c?auto=format&fit=crop&w=800&q=80",
    ],
    isFavorite: false,
  ),
  const Product(
    id: "5",
    title: "Brushed French Terry Crewneck",
    category: "Tops",
    price: 88.00,
    rating: 4.9,
    reviewsCount: 310,
    description:
        "420 GSM unbrushed loopback cotton terry with vintage raglan sleeves and flatlock reinforced seams.",
    images: [
      "https://images.unsplash.com/photo-1556905055-8f358a7a47b2?auto=format&fit=crop&w=800&q=80",
    ],
    isFavorite: true,
  ),
  const Product(
    id: "6",
    title: "Cropped Wool Harrington Jacket",
    category: "Outerwear",
    price: 210.00,
    rating: 4.8,
    reviewsCount: 94,
    description:
        "Heavy double-faced wool blend with a satin lining. Two-way matte silver metal zipper and angled welt pockets.",
    images: [
      "https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&w=800&q=80",
    ],
    isFavorite: true,
  ),
  const Product(
    id: "7",
    title: "Technical Ripstop Windbreaker",
    category: "Outerwear",
    price: 165.00,
    rating: 4.7,
    reviewsCount: 120,
    description:
        "Water-repellent nylon ripstop shell featuring taped seams, bungee-adjustable hood, and storm flap closure.",
    images: [
      "https://images.unsplash.com/photo-1544441893-675973e31985?auto=format&fit=crop&w=800&q=80",
    ],
    isFavorite: false,
  ),
  const Product(
    id: "8",
    title: "Minimal Raglan Trench Coat",
    category: "Outerwear",
    price: 285.00,
    rating: 4.9,
    reviewsCount: 57,
    description:
        "Structured cotton gabardine weave cut long with a storm shield back, hidden button fly, and interior storm pocket.",
    images: [
      "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?auto=format&fit=crop&w=800&q=80",
    ],
    isFavorite: false,
  ),
  const Product(
    id: "9",
    title: "Down-Filled Modular Vest",
    category: "Outerwear",
    price: 145.00,
    rating: 4.6,
    reviewsCount: 78,
    description:
        "700-fill power responsibly sourced goose down with matte micro-ripstop exterior and fleece-lined hand pockets.",
    images: [
      "https://images.unsplash.com/photo-1548883354-7622d03aca27?auto=format&fit=crop&w=800&q=80",
    ],
    isFavorite: false,
  ),
  const Product(
    id: "10",
    title: "Double-Breasted Overcoat",
    category: "Outerwear",
    price: 340.00,
    rating: 4.9,
    reviewsCount: 112,
    description:
        "Tailored from Italian Melton virgin wool. Peak lapels, structured shoulders, horn buttons, and deep back vent.",
    images: [
      "https://images.unsplash.com/photo-1544022613-e87ca75a784a?auto=format&fit=crop&w=800&q=80",
    ],
    isFavorite: true,
  ),
  const Product(
    id: "11",
    title: "Wide-Leg Pleated Trousers",
    category: "Bottoms",
    price: 120.00,
    rating: 4.8,
    reviewsCount: 184,
    description:
        "Deep double front pleats cut in fluid tropical wool. High-rise waist with side adjusters and full pooling break.",
    images: [
      "https://images.unsplash.com/photo-1509631179647-0177331693ae?auto=format&fit=crop&w=800&q=80",
    ],
    isFavorite: true,
  ),
  const Product(
    id: "12",
    title: "Relaxed Straight Raw Denim",
    category: "Bottoms",
    price: 135.00,
    rating: 4.7,
    reviewsCount: 220,
    description:
        "13.5 oz Japanese selvedge denim unwashed for custom break-in. Custom gunmetal rivets and classic button fly.",
    images: [
      "https://images.unsplash.com/photo-1542272604-780c96856592?auto=format&fit=crop&w=800&q=80",
    ],
    isFavorite: false,
  ),
  const Product(
    id: "13",
    title: "Tailored Minimal Chino",
    category: "Bottoms",
    price: 90.00,
    rating: 4.5,
    reviewsCount: 160,
    description:
        "Mid-weight combed cotton twill with 2% elastane flex. Clean waistband without external branding and coin pocket.",
    images: [
      "https://images.unsplash.com/photo-1473966968600-fa801b869a1a?auto=format&fit=crop&w=800&q=80",
    ],
    isFavorite: false,
  ),
  const Product(
    id: "14",
    title: "Technical Drawstring Cargos",
    category: "Bottoms",
    price: 140.00,
    rating: 4.6,
    reviewsCount: 95,
    description:
        "Structured matte nylon with articulated knees, concealed zippered thigh pockets, and adjustable toggle cuffs.",
    images: [
      "https://images.unsplash.com/photo-1624378439575-d8705ad7ae80?auto=format&fit=crop&w=800&q=80",
    ],
    isFavorite: false,
  ),
  const Product(
    id: "15",
    title: "Heavyweight Terry Sweatpants",
    category: "Bottoms",
    price: 85.00,
    rating: 4.9,
    reviewsCount: 260,
    description:
        "450 GSM organic loopback cotton. Elasticated drawstring waistband, deep side pockets, and relaxed straight hems.",
    images: [
      "https://images.unsplash.com/photo-1552902865-b72c031ac5ea?auto=format&fit=crop&w=800&q=80",
    ],
    isFavorite: true,
  ),
  const Product(
    id: "16",
    title: "Monochrome Low-Top Sneaker",
    category: "Footwear",
    price: 175.00,
    rating: 4.8,
    reviewsCount: 340,
    description:
        "Full-grain calfskin leather upper paired with a durable Margom rubber cupsole and waxed cotton laces.",
    images: [
      "https://images.unsplash.com/photo-1549298916-b41d501d3772?auto=format&fit=crop&w=800&q=80",
    ],
    isFavorite: true,
  ),
  const Product(
    id: "17",
    title: "Suede Penny Loafers",
    category: "Footwear",
    price: 195.00,
    rating: 4.6,
    reviewsCount: 82,
    description:
        "Hand-stitched Italian reverse calf suede with unlined construction for immediate comfort and leather outsoles.",
    images: [
      "https://images.unsplash.com/photo-1533867617858-e7b97e060509?auto=format&fit=crop&w=800&q=80",
    ],
    isFavorite: false,
  ),
  const Product(
    id: "18",
    title: "Vibram Commando Boots",
    category: "Footwear",
    price: 240.00,
    rating: 4.9,
    reviewsCount: 110,
    description:
        "Goodyear-welted waxed suede leather atop an aggressive Vibram lug sole. Speed hook lacing and padded ankle collar.",
    images: [
      "https://images.unsplash.com/photo-1608256246200-53e635b5b65f?auto=format&fit=crop&w=800&q=80",
    ],
    isFavorite: false,
  ),
  const Product(
    id: "19",
    title: "Technical Trail Runner",
    category: "Footwear",
    price: 160.00,
    rating: 4.7,
    reviewsCount: 195,
    description:
        "Breathable engineered mesh with TPU welded overlays, speed lacing system, and multi-directional traction lugs.",
    images: [
      "https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?auto=format&fit=crop&w=800&q=80",
    ],
    isFavorite: false,
  ),
  const Product(
    id: "20",
    title: "Structured Mule Slipper",
    category: "Footwear",
    price: 110.00,
    rating: 4.5,
    reviewsCount: 74,
    description:
        "Slip-on mule featuring oiled nubuck leather, an anatomical cork footbed, and EVA shock-absorbing outsole.",
    images: [
      "https://images.unsplash.com/photo-1603808033192-082d6919d3e1?auto=format&fit=crop&w=800&q=80",
    ],
    isFavorite: false,
  ),
]..sort((a, b) => (int.parse(a.id) % 5).compareTo(int.parse(b.id) % 5));
