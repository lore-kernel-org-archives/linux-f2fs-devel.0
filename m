From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: [PATCH V1 03/14] fsverity: Add call back to decide if
 verity check has to be performed
Date: Wed, 24 Apr 2019 10:07:19 +0530
Message-ID: <20190424043730.13683-4-chandan@linux.ibm.com>
References: <20190424043730.13683-1-chandan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1hJ9ed-0006gd-M6
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 04:37:07 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hJ9ec-00A7Hz-3w
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 04:37:07 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3O4Y1ko027446
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 24 Apr 2019 00:37:00 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2s2gn08n4j-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 24 Apr 2019 00:37:00 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Wed, 24 Apr 2019 05:36:58 +0100
In-Reply-To: <20190424043730.13683-1-chandan@linux.ibm.com>
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

Ext4 and F2FS store verity metadata in data extents (beyond
inode->i_size) associated with a file. But other filesystems might
choose alternative means to store verity metadata. Hence this commit
adds a callback function pointer to 'struct fsverity_operations' to help
in deciding if verity operation needs to performed against a page-cache
page holding file data.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
---
 fs/ext4/super.c          | 6 ++++++
 fs/f2fs/super.c          | 6 ++++++
 fs/post_read_process.c   | 4 +++-
 include/linux/fsverity.h | 1 +
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index aba724f82cc3..63d73b360f1d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1428,10 +1428,16 @@ static struct page *ext4_read_verity_metadata_page(struct inode *inode,
 	return read_mapping_page(inode->i_mapping, index, NULL);
 }
 
+static bool ext4_verity_required(struct inode *inode, pgoff_t index)
+{
+	return index < (i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT;
+}
+
 static const struct fsverity_operations ext4_verityops = {
 	.set_verity		= ext4_set_verity,
 	.get_metadata_end	= ext4_get_verity_metadata_end,
 	.read_metadata_page	= ext4_read_verity_metadata_page,
+	.verity_required	= ext4_verity_required,
 };
 #endif /* CONFIG_FS_VERITY */
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2f75f06c784a..cd1299e1f92d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2257,10 +2257,16 @@ static struct page *f2fs_read_verity_metadata_page(struct inode *inode,
 	return read_mapping_page(inode->i_mapping, index, NULL);
 }
 
+static bool f2fs_verity_required(struct inode *inode, pgoff_t index)
+{
+	return index < (i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT;
+}
+
 static const struct fsverity_operations f2fs_verityops = {
 	.set_verity		= f2fs_set_verity,
 	.get_metadata_end	= f2fs_get_verity_metadata_end,
 	.read_metadata_page	= f2fs_read_verity_metadata_page,
+	.verity_required	= f2fs_verity_required,
 };
 #endif /* CONFIG_FS_VERITY */
 
diff --git a/fs/post_read_process.c b/fs/post_read_process.c
index d203fc263091..b60be77c7217 100644
--- a/fs/post_read_process.c
+++ b/fs/post_read_process.c
@@ -86,7 +86,9 @@ struct bio_post_read_ctx *get_bio_post_read_ctx(struct inode *inode,
 		post_read_steps |= 1 << STEP_DECRYPT;
 #ifdef CONFIG_FS_VERITY
 	if (inode->i_verity_info != NULL &&
-		(index < ((i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT)))
+		((inode->i_sb->s_vop->verity_required
+			&& inode->i_sb->s_vop->verity_required(inode, index))
+			|| (inode->i_sb->s_vop->verity_required == NULL)))
 		post_read_steps |= 1 << STEP_VERITY;
 #endif
 	if (post_read_steps) {
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 7c33b42abf1b..b83712d6c79a 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -18,6 +18,7 @@ struct fsverity_operations {
 	int (*set_verity)(struct inode *inode, loff_t data_i_size);
 	int (*get_metadata_end)(struct inode *inode, loff_t *metadata_end_ret);
 	struct page *(*read_metadata_page)(struct inode *inode, pgoff_t index);
+	bool (*verity_required)(struct inode *inode, pgoff_t index);
 };
 
 #ifdef CONFIG_FS_VERITY
-- 
2.19.1
