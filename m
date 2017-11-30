From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5/7] f2fs: clean up hash codes
Date: Thu, 30 Nov 2017 19:28:21 +0800
Message-ID: <20171130112823.100494-5-yuchao0@huawei.com>
References: <20171130112823.100494-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eKN1S-00057m-0e
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 11:28:54 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eKN1Q-0000wW-Kc
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 11:28:53 +0000
In-Reply-To: <20171130112823.100494-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

f2fs_chksum and f2fs_crc32 use the same 'crc32' crypto engine, also
their implementation are almost the same, except with different
shash description context.

Introduce __f2fs_crc32 to wrap the common codes, and reuse it in
f2fs_chksum and f2fs_crc32.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 46 +++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f6477aa76ba9..b4796f064580 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1258,33 +1258,7 @@ static inline bool is_idle(struct f2fs_sb_info *sbi)
 /*
  * Inline functions
  */
-static inline u32 f2fs_crc32(struct f2fs_sb_info *sbi, const void *address,
-			   unsigned int length)
-{
-	SHASH_DESC_ON_STACK(shash, sbi->s_chksum_driver);
-	u32 *ctx = (u32 *)shash_desc_ctx(shash);
-	u32 retval;
-	int err;
-
-	shash->tfm = sbi->s_chksum_driver;
-	shash->flags = 0;
-	*ctx = F2FS_SUPER_MAGIC;
-
-	err = crypto_shash_update(shash, address, length);
-	BUG_ON(err);
-
-	retval = *ctx;
-	barrier_data(ctx);
-	return retval;
-}
-
-static inline bool f2fs_crc_valid(struct f2fs_sb_info *sbi, __u32 blk_crc,
-				  void *buf, size_t buf_size)
-{
-	return f2fs_crc32(sbi, buf, buf_size) == blk_crc;
-}
-
-static inline u32 f2fs_chksum(struct f2fs_sb_info *sbi, u32 crc,
+static inline u32 __f2fs_crc32(struct f2fs_sb_info *sbi, u32 crc,
 			      const void *address, unsigned int length)
 {
 	struct {
@@ -1305,6 +1279,24 @@ static inline u32 f2fs_chksum(struct f2fs_sb_info *sbi, u32 crc,
 	return *(u32 *)desc.ctx;
 }
 
+static inline u32 f2fs_crc32(struct f2fs_sb_info *sbi, const void *address,
+			   unsigned int length)
+{
+	return __f2fs_crc32(sbi, F2FS_SUPER_MAGIC, address, length);
+}
+
+static inline bool f2fs_crc_valid(struct f2fs_sb_info *sbi, __u32 blk_crc,
+				  void *buf, size_t buf_size)
+{
+	return f2fs_crc32(sbi, buf, buf_size) == blk_crc;
+}
+
+static inline u32 f2fs_chksum(struct f2fs_sb_info *sbi, u32 crc,
+			      const void *address, unsigned int length)
+{
+	return __f2fs_crc32(sbi, crc, address, length);
+}
+
 static inline struct f2fs_inode_info *F2FS_I(struct inode *inode)
 {
 	return container_of(inode, struct f2fs_inode_info, vfs_inode);
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
