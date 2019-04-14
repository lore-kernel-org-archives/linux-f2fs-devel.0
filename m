From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: [RFC PATCH V2 09/14] ext4: Decrypt all boundary blocks
 when doing buffered write
Date: Sun, 14 Apr 2019 17:07:59 +0530
Message-ID: <20190414113804.26769-10-chandan@linux.ibm.com>
References: <20190414113804.26769-1-chandan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1hFdSZ-0001VE-8F
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 14 Apr 2019 11:38:07 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hFdSY-0055DD-1h
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 14 Apr 2019 11:38:07 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3EBYDa9043171
 for <linux-f2fs-devel@lists.sourceforge.net>; Sun, 14 Apr 2019 07:38:00 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ruvktkun7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Sun, 14 Apr 2019 07:38:00 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Sun, 14 Apr 2019 12:37:59 +0100
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

With subpage sized blocks, ext4_block_write_begin() can have up to two
blocks to decrypt. Hence this commit invokes fscrypt_decrypt_page() for
each of those blocks.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
---
 fs/ext4/inode.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1327e04334df..51744a3c3964 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1156,12 +1156,14 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 	unsigned to = from + len;
 	struct inode *inode = page->mapping->host;
 	unsigned block_start, block_end;
-	sector_t block;
+	sector_t block, page_blk_nr;
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
@@ -1213,25 +1215,36 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
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
-		err = fscrypt_decrypt_page(page->mapping->host, page,
-				PAGE_SIZE, 0, page->index);
-		if (err)
-			clear_buffer_uptodate(*wait_bh);
+		page_blk_nr = (sector_t)page->index << (PAGE_SHIFT - bbits);
+
+		for (i = 0; i < nr_wait; i++) {
+			int err2;
+
+			block = page_blk_nr + (bh_offset(wait[i]) >> bbits);
+			err2 = fscrypt_decrypt_page(page->mapping->host, page,
+						wait[i]->b_size,
+						bh_offset(wait[i]),
+						block);
+			if (err2) {
+				clear_buffer_uptodate(wait[i]);
+				err = err2;
+			}
+		}
 	}
 
 	return err;
-- 
2.19.1
