From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/5] f2fs crypto: add missing locking for
	keyring_key access
Date: Mon,  8 Feb 2016 17:34:17 -0800
Message-ID: <1454981657-25473-5-git-send-email-jaegeuk@kernel.org>
References: <1454981657-25473-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aSxCK-0005YI-Ru
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 09 Feb 2016 01:34:32 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aSxCK-0003bc-4M for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 09 Feb 2016 01:34:32 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>

This patch adopts:
	ext4 crypto: add missing locking for keyring_key access

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto_key.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/crypto_key.c b/fs/f2fs/crypto_key.c
index 2d491ee..9094fca 100644
--- a/fs/f2fs/crypto_key.c
+++ b/fs/f2fs/crypto_key.c
@@ -202,9 +202,11 @@ retry:
 		res = -ENOKEY;
 		goto out;
 	}
+	down_read(&keyring_key->sem);
 	ukp = user_key_payload(keyring_key);
 	if (ukp->datalen != sizeof(struct f2fs_encryption_key)) {
 		res = -EINVAL;
+		up_read(&keyring_key->sem);
 		goto out;
 	}
 	master_key = (struct f2fs_encryption_key *)ukp->data;
@@ -215,10 +217,12 @@ retry:
 				"f2fs: key size incorrect: %d\n",
 				master_key->size);
 		res = -ENOKEY;
+		up_read(&keyring_key->sem);
 		goto out;
 	}
 	res = f2fs_derive_key_aes(ctx.nonce, master_key->raw,
 				  raw_key);
+	up_read(&keyring_key->sem);
 	if (res)
 		goto out;
 
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
