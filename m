From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: [RFC PATCH V2 12/14] ext4: Compute logical block and the
 page range to be encrypted
Date: Sun, 14 Apr 2019 17:08:02 +0530
Message-ID: <20190414113804.26769-13-chandan@linux.ibm.com>
References: <20190414113804.26769-1-chandan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1hFdSn-00015E-Bn
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 14 Apr 2019 11:38:21 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hFdSl-005cic-Rd
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 14 Apr 2019 11:38:20 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3EBYKqQ091618
 for <linux-f2fs-devel@lists.sourceforge.net>; Sun, 14 Apr 2019 07:38:13 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ruuvjcs17-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Sun, 14 Apr 2019 07:38:13 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Sun, 14 Apr 2019 12:38:12 +0100
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

For subpage-sized blocks, the initial logical block number mapped by a
page can be different from page->index. Hence this commit adds code to
compute the first logical block mapped by the page and also the page
range to be encrypted.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
---
 fs/ext4/page-io.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 3e9298e6a705..75485ee9e800 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -418,6 +418,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 {
 	struct page *data_page = NULL;
 	struct inode *inode = page->mapping->host;
+	u64 page_blk;
 	unsigned block_start;
 	struct buffer_head *bh, *head;
 	int ret = 0;
@@ -478,10 +479,14 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 
 	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) && nr_to_submit) {
 		gfp_t gfp_flags = GFP_NOFS;
+		unsigned int page_bytes;
+
+		page_bytes = round_up(len, i_blocksize(inode));
+		page_blk = page->index << (PAGE_SHIFT - inode->i_blkbits);
 
 	retry_encrypt:
-		data_page = fscrypt_encrypt_page(inode, page, PAGE_SIZE, 0,
-						page->index, gfp_flags);
+		data_page = fscrypt_encrypt_page(inode, page, page_bytes, 0,
+						page_blk, gfp_flags);
 		if (IS_ERR(data_page)) {
 			ret = PTR_ERR(data_page);
 			if (ret == -ENOMEM && wbc->sync_mode == WB_SYNC_ALL) {
-- 
2.19.1
