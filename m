From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: [RFC PATCH V2 11/14] fscrypt_encrypt_page: Loop across
 all blocks mapped by a page range
Date: Sun, 14 Apr 2019 17:08:01 +0530
Message-ID: <20190414113804.26769-12-chandan@linux.ibm.com>
References: <20190414113804.26769-1-chandan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1hFdSg-0001XS-Ub
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 14 Apr 2019 11:38:14 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hFdSf-003ybt-Rc
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 14 Apr 2019 11:38:14 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3EBYDZ2144984
 for <linux-f2fs-devel@lists.sourceforge.net>; Sun, 14 Apr 2019 07:38:08 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ruvqkbaqs-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Sun, 14 Apr 2019 07:38:08 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Sun, 14 Apr 2019 12:38:07 +0100
In-Reply-To: <20190414113804.26769-1-chandan@linux.ibm.com>
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
Cc: tytso@mit.edu, ebiggers@kernel.org, Chandan Rajendra <chandan@linux.ibm.com>, adilger.kernel@dilger.ca, jaegeuk@kernel.org

For subpage-sized blocks, this commit now encrypts all blocks mapped by
a page range.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
---
 fs/crypto/crypto.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 4f0d832cae71..84d11d8eb7e3 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -242,18 +242,26 @@ struct page *fscrypt_encrypt_page(const struct inode *inode,
 {
 	struct fscrypt_ctx *ctx;
 	struct page *ciphertext_page = page;
+	int i, page_nr_blks;
 	int err;
 
 	BUG_ON(len % FS_CRYPTO_BLOCK_SIZE != 0);
 
+	page_nr_blks = len >> inode->i_blkbits;
+
 	if (inode->i_sb->s_cop->flags & FS_CFLG_OWN_PAGES) {
 		/* with inplace-encryption we just encrypt the page */
-		err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk_num, page,
-					     ciphertext_page, len, offs,
-					     gfp_flags);
-		if (err)
-			return ERR_PTR(err);
-
+		for (i = 0; i < page_nr_blks; i++) {
+			err = fscrypt_do_page_crypto(inode, FS_ENCRYPT,
+						lblk_num, page,
+						ciphertext_page,
+						i_blocksize(inode), offs,
+						gfp_flags);
+			if (err)
+				return ERR_PTR(err);
+			++lblk_num;
+			offs += i_blocksize(inode);
+		}
 		return ciphertext_page;
 	}
 
@@ -269,12 +277,17 @@ struct page *fscrypt_encrypt_page(const struct inode *inode,
 		goto errout;
 
 	ctx->control_page = page;
-	err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk_num,
-				     page, ciphertext_page, len, offs,
-				     gfp_flags);
-	if (err) {
-		ciphertext_page = ERR_PTR(err);
-		goto errout;
+
+	for (i = 0; i < page_nr_blks; i++) {
+		err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk_num,
+					page, ciphertext_page, i_blocksize(inode), offs,
+					gfp_flags);
+		if (err) {
+			ciphertext_page = ERR_PTR(err);
+			goto errout;
+		}
+		++lblk_num;
+		offs += i_blocksize(inode);
 	}
 	SetPagePrivate(ciphertext_page);
 	set_page_private(ciphertext_page, (unsigned long)ctx);
-- 
2.19.1
