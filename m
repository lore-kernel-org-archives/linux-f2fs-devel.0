From: Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 11/13] ext4: decrypt only the needed blocks in
 ext4_block_write_begin()
Date: Wed,  1 May 2019 15:45:13 -0700
Message-ID: <20190501224515.43059-12-ebiggers@kernel.org>
References: <20190501224515.43059-1-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hLxzX-0006s1-GN
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 May 2019 22:46:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hLxzW-004Tjo-8S
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 May 2019 22:46:19 +0000
In-Reply-To: <20190501224515.43059-1-ebiggers@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fscrypt@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-mtd@lists.infradead.org, Chandan Rajendra <chandan@linux.ibm.com>, linux-f2fs-devel@lists.sourceforge.net

From: Chandan Rajendra <chandan@linux.ibm.com>

In ext4_block_write_begin(), only decrypt the blocks that actually need
to be decrypted (up to two blocks which intersect the boundaries of the
region that will be written to), rather than assuming blocksize ==
PAGE_SIZE and decrypting the whole page.

This is in preparation for allowing encryption on ext4 filesystems with
blocksize != PAGE_SIZE.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
(EB: rebase onto previous changes and improve the commit message)
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/inode.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9382e1bcefe49..d24c50e4598f0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1160,8 +1160,10 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 	int err = 0;
 	unsigned blocksize = inode->i_sb->s_blocksize;
 	unsigned bbits;
-	struct buffer_head *bh, *head, *wait[2], **wait_bh = wait;
+	struct buffer_head *bh, *head, *wait[2];
+	int nr_wait = 0;
 	bool decrypt = false;
+	int i;
 
 	BUG_ON(!PageLocked(page));
 	BUG_ON(from > PAGE_SIZE);
@@ -1213,24 +1215,31 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 		    !buffer_unwritten(bh) &&
 		    (block_start < from || block_end > to)) {
 			ll_rw_block(REQ_OP_READ, 0, 1, &bh);
-			*wait_bh++ = bh;
+			wait[nr_wait++] = bh;
 			decrypt = IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode);
 		}
 	}
 	/*
 	 * If we issued read requests, let them complete.
 	 */
-	while (wait_bh > wait) {
-		wait_on_buffer(*--wait_bh);
-		if (!buffer_uptodate(*wait_bh))
+	for (i = 0; i < nr_wait; i++) {
+		wait_on_buffer(wait[i]);
+		if (!buffer_uptodate(wait[i]))
 			err = -EIO;
 	}
 	if (unlikely(err)) {
 		page_zero_new_buffers(page, from, to);
 	} else if (decrypt) {
-		err = fscrypt_decrypt_pagecache_blocks(page, PAGE_SIZE, 0);
-		if (err)
-			clear_buffer_uptodate(*wait_bh);
+		for (i = 0; i < nr_wait; i++) {
+			int err2;
+
+			err2 = fscrypt_decrypt_pagecache_blocks(page, blocksize,
+								bh_offset(wait[i]));
+			if (err2) {
+				clear_buffer_uptodate(wait[i]);
+				err = err2;
+			}
+		}
 	}
 
 	return err;
-- 
2.21.0.593.g511ec345e18-goog
