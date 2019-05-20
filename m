From: Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 14/14] ext4: encrypt only up to last block in
 ext4_bio_write_page()
Date: Mon, 20 May 2019 09:29:52 -0700
Message-ID: <20190520162952.156212-15-ebiggers@kernel.org>
References: <20190520162952.156212-1-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hSlBP-0004pW-Nj
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 20 May 2019 16:30:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hSlBO-00BNhc-2Y
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 20 May 2019 16:30:39 +0000
In-Reply-To: <20190520162952.156212-1-ebiggers@kernel.org>
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
Cc: linux-ext4@vger.kernel.org, linux-mtd@lists.infradead.org, Chandan Rajendra <chandan@linux.ibm.com>, linux-f2fs-devel@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

As an optimization, don't encrypt blocks fully beyond i_size, since
those definitely won't need to be written out.  Also add a comment.

This is in preparation for allowing encryption on ext4 filesystems with
blocksize != PAGE_SIZE.

This is based on work by Chandan Rajendra.

Reviewed-by: Chandan Rajendra <chandan@linux.ibm.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/page-io.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 40ee33df57649..a18a47a2a1d1a 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -467,11 +467,19 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 
 	bh = head = page_buffers(page);
 
+	/*
+	 * If any blocks are being written to an encrypted file, encrypt them
+	 * into a bounce page.  For simplicity, just encrypt until the last
+	 * block which might be needed.  This may cause some unneeded blocks
+	 * (e.g. holes) to be unnecessarily encrypted, but this is rare and
+	 * can't happen in the common case of blocksize == PAGE_SIZE.
+	 */
 	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) && nr_to_submit) {
 		gfp_t gfp_flags = GFP_NOFS;
+		unsigned int enc_bytes = round_up(len, i_blocksize(inode));
 
 	retry_encrypt:
-		bounce_page = fscrypt_encrypt_pagecache_blocks(page, PAGE_SIZE,
+		bounce_page = fscrypt_encrypt_pagecache_blocks(page, enc_bytes,
 							       0, gfp_flags);
 		if (IS_ERR(bounce_page)) {
 			ret = PTR_ERR(bounce_page);
-- 
2.21.0.1020.gf2820cf01a-goog
