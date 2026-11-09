// Creates backend/.env for local development. Run: npm run setup
import { randomBytes } from 'node:crypto';
import { existsSync, writeFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { createInterface } from 'node:readline';
import { fileURLToPath } from 'node:url';

const envPath = join(dirname(fileURLToPath(import.meta.url)), '..', '.env');
const rl = createInterface({ input: process.stdin });
const lines = rl[Symbol.asyncIterator]();
async function ask(question) {
  process.stdout.write(question);
  const { value } = await lines.next();
  return value ?? '';
}
const secret = () => randomBytes(48).toString('base64url');

if (existsSync(envPath)) {
  const answer = await ask('.env already exists. Replace it? (y/N) ');
  if (answer.trim().toLowerCase() !== 'y') {
    console.log('Kept the existing .env');
    rl.close();
    process.exit(0);
  }
}

const user = (await ask('MongoDB username [mohamedhessan139_db_user]: ')).trim() || 'mohamedhessan139_db_user';
const password = (await ask('MongoDB password: ')).trim();
rl.close();
if (!password) {
  console.error('Password is required.');
  process.exit(1);
}

const hosts = [
  'ac-d2obq57-shard-00-00.vcypdvj.mongodb.net:27017',
  'ac-d2obq57-shard-00-01.vcypdvj.mongodb.net:27017',
  'ac-d2obq57-shard-00-02.vcypdvj.mongodb.net:27017',
].join(',');
const uri =
  `mongodb://${encodeURIComponent(user)}:${encodeURIComponent(password)}@${hosts}/` +
  '?ssl=true&replicaSet=atlas-vtxorf-shard-0&authSource=admin&retryWrites=true&w=majority';

writeFileSync(
  envPath,
  [
    '# LOCAL ONLY - never commit this file',
    `MONGODB_URI=${uri}`,
    'MONGODB_DB=kashkool',
    `JWT_SECRET=${secret()}`,
    `CRON_SECRET=${secret()}`,
    'PUBLIC_BASE_URL=http://localhost:3000',
    'REQUIRE_SUBSCRIPTION=false',
    'ALLOW_DEV_LOGIN=true',
    '',
  ].join('\n'),
);
console.log('.env created. Now run: npm run dev');
