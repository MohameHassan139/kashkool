import { test, after } from 'node:test';
import assert from 'node:assert/strict';
import { api, closeAll } from './helpers/setup.js';

after(closeAll);

test('public pages are served with HTML content and proper headings', async () => {
  // 1. Privacy Policy
  const privacyRes = await api().get('/privacy').expect(200);
  assert.match(privacyRes.headers['content-type'], /text\/html/);
  assert.ok(privacyRes.text.includes('سياسة الخصوصية'));
  assert.ok(privacyRes.text.includes('Privacy Policy'));
  assert.ok(privacyRes.text.includes('SQLCipher'));

  // 1b. Privacy Policy Alias
  const privacyAliasRes = await api().get('/privacy-policy').expect(200);
  assert.match(privacyAliasRes.headers['content-type'], /text\/html/);

  // 2. Account Deletion
  const deleteRes = await api().get('/account/delete').expect(200);
  assert.match(deleteRes.headers['content-type'], /text\/html/);
  assert.ok(deleteRes.text.includes('حذف الحساب'));
  assert.ok(deleteRes.text.includes('Delete Your Kashkool Account'));

  // 2b. Account Deletion Alias
  const deleteAliasRes = await api().get('/delete-account').expect(200);
  assert.match(deleteAliasRes.headers['content-type'], /text\/html/);

  // 3. Terms of Service
  const termsRes = await api().get('/terms').expect(200);
  assert.match(termsRes.headers['content-type'], /text\/html/);
  assert.ok(termsRes.text.includes('شروط الخدمة'));
  assert.ok(termsRes.text.includes('Terms of Service'));

  // 3b. Terms of Service Alias
  const termsAliasRes = await api().get('/terms-of-service').expect(200);
  assert.match(termsAliasRes.headers['content-type'], /text\/html/);
});
