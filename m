From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/5] f2fs crypto: check for too-short encrypted
	file names
Date: Mon,  8 Feb 2016 17:34:16 -0800
Message-ID: <1454981657-25473-4-git-send-email-jaegeuk@kernel.org>
References: <1454981657-25473-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aSxCJ-0005K0-L4
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 09 Feb 2016 01:34:31 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aSxCI-00076W-VI for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 09 Feb 2016 01:34:31 +0000
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
	ext4 crypto: check for too-short encrypted file names

An encrypted file name should never be shorter than an 16 bytes, the
AES block size.  The 3.10 crypto layer will oops and crash the kernel
if ciphertext shorter than the block size is passed to it.

Fortunately, in modern kernels the crypto layer will not crash the
kernel in this scenario, but nevertheless, it represents a corrupted
directory, and we should detect it and mark the file system as
corrupted so that e2fsck can fix this.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto_fname.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/crypto_fname.c b/fs/f2fs/crypto_fname.c
index e7aa67c..905c065 100644
--- a/fs/f2fs/crypto_fname.c
+++ b/fs/f2fs/crypto_fname.c
@@ -317,7 +317,10 @@ int f2fs_fname_disk_to_usr(struct inode *inode,
 		oname->len = iname->len;
 		return oname->len;
 	}
-
+	if (iname->len < F2FS_CRYPTO_BLOCK_SIZE) {
+		printk("encrypted inode too small");
+		return -EUCLEAN;
+	}
 	if (F2FS_I(inode)->i_crypt_info)
 		return f2fs_fname_decrypt(inode, iname, oname);
 
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
