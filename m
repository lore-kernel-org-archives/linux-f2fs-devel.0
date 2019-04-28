From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: [PATCH V2 12/13] fscrypt_zeroout_range: Encrypt all
 zeroed out blocks of a page
Date: Sun, 28 Apr 2019 10:01:20 +0530
Message-ID: <20190428043121.30925-13-chandan@linux.ibm.com>
References: <20190428043121.30925-1-chandan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1hKbTU-0006PD-Ll
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 28 Apr 2019 04:31:36 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hKbTT-00HGbQ-FI
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 28 Apr 2019 04:31:36 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3S4TYLM055035
 for <linux-f2fs-devel@lists.sourceforge.net>; Sun, 28 Apr 2019 00:31:29 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2s54gjs13g-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Sun, 28 Apr 2019 00:31:29 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Sun, 28 Apr 2019 05:31:28 +0100
In-Reply-To: <20190428043121.30925-1-chandan@linux.ibm.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org
Cc: hch@infradead.org, tytso@mit.edu, ebiggers@kernel.org, Chandan Rajendra <chandan@linux.ibm.com>, adilger.kernel@dilger.ca, jaegeuk@kernel.org

For subpage-sized blocks, this commit adds code to encrypt all zeroed
out blocks mapped by a page.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
---
 fs/crypto/bio.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 856f4694902d..46dd2ec50c7d 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -108,29 +108,23 @@ EXPORT_SYMBOL(fscrypt_pullback_bio_page);
 int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 				sector_t pblk, unsigned int len)
 {
-	struct fscrypt_ctx *ctx;
 	struct page *ciphertext_page = NULL;
 	struct bio *bio;
+	u64 total_bytes, page_bytes;
 	int ret, err = 0;
 
-	BUG_ON(inode->i_sb->s_blocksize != PAGE_SIZE);
-
-	ctx = fscrypt_get_ctx(inode, GFP_NOFS);
-	if (IS_ERR(ctx))
-		return PTR_ERR(ctx);
+	total_bytes = len << inode->i_blkbits;
 
-	ciphertext_page = fscrypt_alloc_bounce_page(ctx, GFP_NOWAIT);
-	if (IS_ERR(ciphertext_page)) {
-		err = PTR_ERR(ciphertext_page);
-		goto errout;
-	}
+	while (total_bytes) {
+		page_bytes = min_t(u64, total_bytes, PAGE_SIZE);
 
-	while (len--) {
-		err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk,
-					     ZERO_PAGE(0), ciphertext_page,
-					     PAGE_SIZE, 0, GFP_NOFS);
-		if (err)
+		ciphertext_page = fscrypt_encrypt_page(inode, ZERO_PAGE(0),
+						page_bytes, 0, lblk, GFP_NOFS);
+		if (IS_ERR(ciphertext_page)) {
+			err = PTR_ERR(ciphertext_page);
+			ciphertext_page = NULL;
 			goto errout;
+		}
 
 		bio = bio_alloc(GFP_NOWAIT, 1);
 		if (!bio) {
@@ -141,9 +135,8 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 		bio->bi_iter.bi_sector =
 			pblk << (inode->i_sb->s_blocksize_bits - 9);
 		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
-		ret = bio_add_page(bio, ciphertext_page,
-					inode->i_sb->s_blocksize, 0);
-		if (ret != inode->i_sb->s_blocksize) {
+		ret = bio_add_page(bio, ciphertext_page, page_bytes, 0);
+		if (ret != page_bytes) {
 			/* should never happen! */
 			WARN_ON(1);
 			bio_put(bio);
@@ -156,12 +149,15 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 		bio_put(bio);
 		if (err)
 			goto errout;
-		lblk++;
-		pblk++;
+
+		lblk += page_bytes >> inode->i_blkbits;
+		pblk += page_bytes >> inode->i_blkbits;
+		total_bytes -= page_bytes;
 	}
 	err = 0;
 errout:
-	fscrypt_release_ctx(ctx);
+	if (!IS_ERR_OR_NULL(ciphertext_page))
+		fscrypt_restore_control_page(ciphertext_page);
 	return err;
 }
 EXPORT_SYMBOL(fscrypt_zeroout_range);
-- 
2.19.1
