From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs crypto: sync with ext4's fname padding
Date: Fri, 12 Feb 2016 18:56:34 -0800
Message-ID: <1455332195-76333-2-git-send-email-jaegeuk@kernel.org>
References: <1455332195-76333-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aUQO6-0003az-MS
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 13 Feb 2016 02:56:46 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aUQO5-0001oO-V3
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 13 Feb 2016 02:56:46 +0000
In-Reply-To: <1455332195-76333-1-git-send-email-jaegeuk@kernel.org>
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

This patch fixes wrong adoption on fname padding.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto_fname.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/crypto_fname.c b/fs/f2fs/crypto_fname.c
index 905c065..73741fb 100644
--- a/fs/f2fs/crypto_fname.c
+++ b/fs/f2fs/crypto_fname.c
@@ -267,13 +267,13 @@ int f2fs_fname_crypto_alloc_buffer(struct inode *inode,
 				   u32 ilen, struct f2fs_str *crypto_str)
 {
 	unsigned int olen;
-	int padding = 16;
+	int padding = 32;
 	struct f2fs_crypt_info *ci = F2FS_I(inode)->i_crypt_info;
 
 	if (ci)
 		padding = 4 << (ci->ci_flags & F2FS_POLICY_FLAGS_PAD_MASK);
-	if (padding < F2FS_CRYPTO_BLOCK_SIZE)
-		padding = F2FS_CRYPTO_BLOCK_SIZE;
+	if (ilen < F2FS_CRYPTO_BLOCK_SIZE)
+		ilen = F2FS_CRYPTO_BLOCK_SIZE;
 	olen = f2fs_fname_crypto_round_up(ilen, padding);
 	crypto_str->len = olen;
 	if (olen < F2FS_FNAME_CRYPTO_DIGEST_SIZE * 2)
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
