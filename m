From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/5] f2fs crypto: fix spelling typo in comment
Date: Mon,  8 Feb 2016 17:34:14 -0800
Message-ID: <1454981657-25473-2-git-send-email-jaegeuk@kernel.org>
References: <1454981657-25473-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aSxCG-0000PM-Cv
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 09 Feb 2016 01:34:28 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aSxCF-0003bX-Mz for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 09 Feb 2016 01:34:28 +0000
In-Reply-To: <1454981657-25473-1-git-send-email-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Laurent Navet <laurent.navet@gmail.com>

This patch adopts:
	ext4 crypto: fix spelling typo in comment

Signed-off-by: Laurent Navet <laurent.navet@gmail.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/crypto_key.c b/fs/f2fs/crypto_key.c
index fc0e3cc..2d491ee 100644
--- a/fs/f2fs/crypto_key.c
+++ b/fs/f2fs/crypto_key.c
@@ -33,7 +33,7 @@ static void derive_crypt_complete(struct crypto_async_request *req, int rc)
 
 /**
  * f2fs_derive_key_aes() - Derive a key using AES-128-ECB
- * @deriving_key: Encryption key used for derivatio.
+ * @deriving_key: Encryption key used for derivation.
  * @source_key:   Source key to which to apply derivation.
  * @derived_key:  Derived key.
  *
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
