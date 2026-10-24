import { readFile } from "node:fs/promises";
import { applicationDefault, initializeApp } from "firebase-admin/app";
import { getFirestore } from "firebase-admin/firestore";

const projectId = process.env.GOOGLE_CLOUD_PROJECT || "nexa-31f08";
const inputPath =
  process.argv.find((argument) => argument.endsWith(".json")) ??
  "tools/firestore-seed/products.json";
const overwrite = process.argv.includes("--overwrite");
const credentialPath = process.env.GOOGLE_APPLICATION_CREDENTIALS;

if (!credentialPath) {
  throw new Error(
    "Set GOOGLE_APPLICATION_CREDENTIALS to a Firebase service-account JSON path.",
  );
}

const products = JSON.parse(
  (await readFile(inputPath, "utf8")).replace(/^\uFEFF/, ""),
);
if (!Array.isArray(products) || products.length === 0) {
  throw new Error(`No products found in ${inputPath}.`);
}

const ids = new Set();
for (const product of products) {
  if (
    !product ||
    typeof product.id !== "string" ||
    !product.id ||
    typeof product.title !== "string" ||
    typeof product.category !== "string" ||
    typeof product.price !== "number" ||
    typeof product.rating !== "number" ||
    !Number.isInteger(product.reviewsCount) ||
    typeof product.description !== "string" ||
    !Array.isArray(product.images) ||
    !product.images.every((image) => typeof image === "string") ||
    ids.has(product.id)
  ) {
    throw new Error("Product export contains invalid or duplicate records.");
  }
  ids.add(product.id);
}

initializeApp({ credential: applicationDefault(), projectId });
const collection = getFirestore().collection("products");
const existing = await Promise.all(
  products.map((product) => collection.doc(product.id).get()),
);
const conflicts = existing.filter((document) => document.exists);
if (conflicts.length > 0 && !overwrite) {
  throw new Error(
    `${conflicts.length} product documents already exist. Pass --overwrite to replace matching IDs.`,
  );
}

const batch = getFirestore().batch();
for (const product of products) {
  const { id, ...data } = product;
  batch.set(collection.doc(id), data);
}
await batch.commit();
console.log(
  `Uploaded ${products.length} products to ${projectId}/products.`,
);
