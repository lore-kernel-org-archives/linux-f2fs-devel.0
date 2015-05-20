From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/4] f2fs crypto: assign GFP_KERNEL for
	f2fs_derive_key_aes
Date: Tue, 19 May 2015 17:43:26 -0700
Message-ID: <1432082606-55975-4-git-send-email-jaegeuk@kernel.org>
References: <1432082606-55975-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Yus6v-0007t1-6r
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 May 2015 00:43:49 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Yus6u-0001qX-GK for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 May 2015 00:43:49 +0000
In-Reply-To: <1432082606-55975-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

The f2fs_derive_key_aes is called not from data path, so we can use GFP_KERNEL.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto_key.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/crypto_key.c b/fs/f2fs/crypto_key.c
index 2f5a45b..49f9e31 100644
--- a/fs/f2fs/crypto_key.c
+++ b/fs/f2fs/crypto_key.c
@@ -56,7 +56,7 @@ static int f2fs_derive_key_aes(char deriving_key[F2FS_AES_128_ECB_KEY_SIZE],
 		goto out;
 	}
 	crypto_ablkcipher_set_flags(tfm, CRYPTO_TFM_REQ_WEAK_KEY);
-	req = ablkcipher_request_alloc(tfm, GFP_NOFS);
+	req = ablkcipher_request_alloc(tfm, GFP_KERNEL);
 	if (!req) {
 		res = -ENOMEM;
 		goto out;
@@ -137,7 +137,7 @@ int _f2fs_get_encryption_info(struct inode *inode)
 		return -EINVAL;
 	res = 0;
 
-	crypt_info = kmem_cache_alloc(f2fs_crypt_info_cachep, GFP_NOFS);
+	crypt_info = kmem_cache_alloc(f2fs_crypt_info_cachep, GFP_KERNEL);
 	if (!crypt_info)
 		return -ENOMEM;
 
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
