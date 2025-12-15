#!/usr/bin/env node

const crypto = require('crypto');

function generateSecret(length = 32) {
  return crypto.randomBytes(length).toString('base64');
}

function generateAppKeys() {
  return Array.from({ length: 4 }, () => generateSecret()).join(',');
}

console.log('=== Strapi Secrets ===');
console.log('Copy these to your GitHub Secrets:');
console.log('');
console.log(`APP_KEYS=${generateAppKeys()}`);
console.log(`API_TOKEN_SALT=${generateSecret()}`);
console.log(`ADMIN_JWT_SECRET=${generateSecret()}`);
console.log(`TRANSFER_TOKEN_SALT=${generateSecret()}`);
console.log(`JWT_SECRET=${generateSecret()}`);
console.log(`DB_PASSWORD=${generateSecret(16)}`);
console.log('');
console.log('=== End Secrets ===');