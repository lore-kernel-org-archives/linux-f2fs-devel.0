From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: [RFC PATCH V2 05/14] fs/mpage.c: Integrate post read
 processing
Date: Sun, 14 Apr 2019 17:07:55 +0530
Message-ID: <20190414113804.26769-6-chandan@linux.ibm.com>
References: <20190414113804.26769-1-chandan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1hFdSH-0008U9-Hh
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 14 Apr 2019 11:37:49 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hFdSF-003yYy-QW
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 14 Apr 2019 11:37:49 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3EBYDvN145582
 for <linux-f2fs-devel@lists.sourceforge.net>; Sun, 14 Apr 2019 07:37:42 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ruwgea8tk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Sun, 14 Apr 2019 07:37:42 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Sun, 14 Apr 2019 12:37:40 +0100
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

This commit adds code to make do_mpage_readpage() to be "post read
processing" aware i.e. for files requiring decryption/verification,
do_mpage_readpage() now allocates a context structure and assigns the
corresponding pointer to bio->bi_private. At endio time, a non-zero
bio->bi_private indicates that after the read operation is performed, the
bio's payload needs to be processed further before handing over the data
to user space.

The context structure is used for tracking the state machine associated
with post read processing.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
---
 fs/mpage.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 3f19da75178b..9c291d6ddab6 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -30,6 +30,10 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 #include <linux/cleancache.h>
+#include <linux/fsverity.h>
+#if defined(CONFIG_FS_ENCRYPTION) || defined(CONFIG_FS_VERITY)
+#include <linux/post_read_process.h>
+#endif
 #include "internal.h"
 
 /*
@@ -50,6 +54,20 @@ static void mpage_end_io(struct bio *bio)
 	int i;
 	struct bvec_iter_all iter_all;
 
+#if defined(CONFIG_FS_ENCRYPTION) || defined(CONFIG_FS_VERITY)
+	if (!bio->bi_status && bio->bi_private) {
+		struct bio_post_read_ctx *ctx;
+
+		ctx = bio->bi_private;
+
+		bio_post_read_processing(ctx);
+		return;
+	}
+
+	if (bio->bi_private)
+		put_bio_post_read_ctx((struct bio_post_read_ctx *)(bio->bi_private));
+#endif
+
 	bio_for_each_segment_all(bv, bio, i, iter_all) {
 		struct page *page = bv->bv_page;
 		page_endio(page, bio_op(bio),
@@ -189,7 +207,13 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 
 	block_in_file = (sector_t)page->index << (PAGE_SHIFT - blkbits);
 	last_block = block_in_file + args->nr_pages * blocks_per_page;
-	last_block_in_file = (i_size_read(inode) + blocksize - 1) >> blkbits;
+#ifdef CONFIG_FS_VERITY
+	if (IS_VERITY(inode) && inode->i_sb->s_vop->readpage_limit)
+		last_block_in_file = inode->i_sb->s_vop->readpage_limit(inode);
+	else
+#endif
+		last_block_in_file = (i_size_read(inode) + blocksize - 1)
+			>> blkbits;
 	if (last_block > last_block_in_file)
 		last_block = last_block_in_file;
 	page_block = 0;
@@ -277,6 +301,14 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	if (first_hole != blocks_per_page) {
 		zero_user_segment(page, first_hole << blkbits, PAGE_SIZE);
 		if (first_hole == 0) {
+#ifdef CONFIG_FS_VERITY
+			if (IS_VERITY(inode)) {
+				if (!fsverity_check_hole(inode, page)) {
+					SetPageError(page);
+					goto confused;
+				}
+			}
+#endif
 			SetPageUptodate(page);
 			unlock_page(page);
 			goto out;
@@ -299,7 +331,11 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 
 alloc_new:
 	if (args->bio == NULL) {
-		if (first_hole == blocks_per_page) {
+#if defined(CONFIG_FS_ENCRYPTION) || defined(CONFIG_FS_VERITY)
+		struct bio_post_read_ctx *ctx;
+#endif
+		if (first_hole == blocks_per_page
+			&& !(IS_ENCRYPTED(inode) || IS_VERITY(inode))) {
 			if (!bdev_read_page(bdev, blocks[0] << (blkbits - 9),
 								page))
 				goto out;
@@ -310,6 +346,15 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 					gfp);
 		if (args->bio == NULL)
 			goto confused;
+
+#if defined(CONFIG_FS_ENCRYPTION) || defined(CONFIG_FS_VERITY)
+		ctx = get_bio_post_read_ctx(inode, args->bio, page->index);
+		if (IS_ERR(ctx)) {
+			bio_put(args->bio);
+			args->bio = NULL;
+			goto confused;
+		}
+#endif
 	}
 
 	length = first_hole << blkbits;
@@ -331,7 +376,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 confused:
 	if (args->bio)
 		args->bio = mpage_bio_submit(REQ_OP_READ, op_flags, args->bio);
-	if (!PageUptodate(page))
+	if (!PageUptodate(page) && !PageError(page))
 		block_read_full_page(page, args->get_block);
 	else
 		unlock_page(page);
-- 
2.19.1
