From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: [RFC PATCH 06/10] Introduce REQ_POST_READ_PROC bio flag
Date: Mon, 18 Feb 2019 15:34:29 +0530
Message-ID: <20190218100433.20048-7-chandan@linux.ibm.com>
References: <20190218100433.20048-1-chandan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1gvfn6-0005RK-7m
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Feb 2019 10:04:48 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gvfmv-005dA3-8P
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Feb 2019 10:04:48 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1IA3mZN050824
 for <linux-f2fs-devel@lists.sourceforge.net>; Mon, 18 Feb 2019 05:04:31 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qqtk286u8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Mon, 18 Feb 2019 05:04:31 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Mon, 18 Feb 2019 10:04:30 -0000
In-Reply-To: <20190218100433.20048-1-chandan@linux.ibm.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org
Cc: tytso@mit.edu, ebiggers@kernel.org, Chandan Rajendra <chandan@linux.ibm.com>, adilger.kernel@dilger.ca, jaegeuk@kernel.org

Ext4 and F2FS currently use a non-NULL value stored at bio->bi_private
to determine if the contents of the bio need to be "post processed"
i.e. whether its contents need to be decrypted and/or verified. For
block size < page size scenario, bio->bi_private would hold a pointer to
buffer_head. Hence, this commit adds the new flag REQ_POST_READ_PROC to
be able to decisively check for post process requirement for a bio.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
---
 fs/ext4/readpage.c        | 11 +++++++++--
 fs/post_read_process.c    |  2 +-
 include/linux/blk_types.h |  2 ++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 8943fc41fd33..c7dbab35deaa 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -245,6 +245,7 @@ int ext4_mpage_readpages(struct address_space *mapping,
 		}
 		if (bio == NULL) {
 			struct bio_post_read_ctx *ctx;
+			unsigned int op_flags = 0;
 
 			bio = bio_alloc(GFP_KERNEL,
 				min_t(int, nr_pages, BIO_MAX_PAGES));
@@ -259,8 +260,14 @@ int ext4_mpage_readpages(struct address_space *mapping,
 			bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
 			bio->bi_end_io = mpage_end_io;
 			bio->bi_private = ctx;
-			bio_set_op_attrs(bio, REQ_OP_READ,
-						is_readahead ? REQ_RAHEAD : 0);
+
+			if (is_readahead)
+				op_flags |= REQ_RAHEAD;
+
+			if (ctx)
+				op_flags |= REQ_POST_READ_PROC;
+
+			bio_set_op_attrs(bio, REQ_OP_READ, op_flags);
 		}
 
 		length = first_hole << blkbits;
diff --git a/fs/post_read_process.c b/fs/post_read_process.c
index 1f8663d70247..66c1c6e57e70 100644
--- a/fs/post_read_process.c
+++ b/fs/post_read_process.c
@@ -104,7 +104,7 @@ void put_bio_post_read_ctx(struct bio_post_read_ctx *ctx)
 
 bool bio_post_read_required(struct bio *bio)
 {
-	return bio->bi_private && !bio->bi_status;
+	return bio->bi_opf & REQ_POST_READ_PROC;
 }
 
 static int __init bio_init_post_read_processing(void)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 5c7e7f859a24..6904945c8c40 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -320,6 +320,7 @@ enum req_flag_bits {
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 	__REQ_BACKGROUND,	/* background IO */
 	__REQ_NOWAIT,           /* Don't wait if request will block */
+	__REQ_POST_READ_PROC,
 
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
@@ -346,6 +347,7 @@ enum req_flag_bits {
 #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
 #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
+#define REQ_POST_READ_PROC	(1ULL << __REQ_POST_READ_PROC)
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 #define REQ_HIPRI		(1ULL << __REQ_HIPRI)
 
-- 
2.19.1
