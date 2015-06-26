From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] f2fs crypto: Delete an unnecessary check before the function
 call "key_put"
Date: Fri, 26 Jun 2015 17:33:22 +0200
Message-ID: <558D70C2.4080406@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.so
 urceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <5317A59D.4@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: Changman Lee <cm224.lee@samsung.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 26 Jun 2015 17:28:55 +0200

The key_put() function tests whether its argument is NULL and then
returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 fs/f2fs/crypto_key.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/crypto_key.c b/fs/f2fs/crypto_key.c
index 95b8f93..9f77de2 100644
--- a/fs/f2fs/crypto_key.c
+++ b/fs/f2fs/crypto_key.c
@@ -92,8 +92,7 @@ static void f2fs_free_crypt_info(struct f2fs_crypt_info *ci)
 	if (!ci)
 		return;
 
-	if (ci->ci_keyring_key)
-		key_put(ci->ci_keyring_key);
+	key_put(ci->ci_keyring_key);
 	crypto_free_ablkcipher(ci->ci_ctfm);
 	kmem_cache_free(f2fs_crypt_info_cachep, ci);
 }
-- 
2.4.4

