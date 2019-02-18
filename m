From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: [RFC PATCH 07/10] fsverity: Add call back to determine
 readpage limit
Date: Mon, 18 Feb 2019 15:34:30 +0530
Message-ID: <20190218100433.20048-8-chandan@linux.ibm.com>
References: <20190218100433.20048-1-chandan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1gvfn5-0000s2-87
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Feb 2019 10:04:47 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gvfmy-00EUQu-V9
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Feb 2019 10:04:47 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1IA3trf060326
 for <linux-f2fs-devel@lists.sourceforge.net>; Mon, 18 Feb 2019 05:04:35 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qqsn8u0gk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Mon, 18 Feb 2019 05:04:35 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Mon, 18 Feb 2019 10:04:34 -0000
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

Ext4 and F2FS store verity metadata beyond i_size. This commit adds a
call back pointer to "struct fsverity_operations" which helps in
determining the the real file size limit upto which data can be read
from the file.

This call back will be required in order to get do_mpage_readpage()
to read files having verity metadata appended beyond i_size.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
---
 fs/ext4/super.c          | 18 ++++++++++++++++++
 include/linux/fsverity.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2d7781ab6824..4493ddc357c6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1428,6 +1428,23 @@ static struct page *ext4_read_verity_metadata_page(struct inode *inode,
 	return read_mapping_page(inode->i_mapping, index, NULL);
 }
 
+static loff_t ext4_readpage_limit(struct inode *inode)
+{
+#ifdef CONFIG_FS_VERITY
+	if (IS_VERITY(inode)) {
+		if (inode->i_verity_info)
+			/* limit to end of metadata region */
+			return fsverity_full_i_size(inode);
+		/*
+		 * fsverity_info is currently being set up and no user reads are
+		 * allowed yet.  It's easiest to just not enforce a limit yet.
+		 */
+		return inode->i_sb->s_maxbytes;
+	}
+#endif
+	return i_size_read(inode);
+}
+
 static bool ext4_verity_required(struct inode *inode, pgoff_t index)
 {
 	if (index < ((i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT))
@@ -1441,6 +1458,7 @@ static const struct fsverity_operations ext4_verityops = {
 	.get_metadata_end	= ext4_get_verity_metadata_end,
 	.read_metadata_page	= ext4_read_verity_metadata_page,
 	.verity_required	= ext4_verity_required,
+	.readpage_limit		= ext4_readpage_limit,
 };
 #endif /* CONFIG_FS_VERITY */
 
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index b83712d6c79a..fc8113acbbfe 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -19,6 +19,7 @@ struct fsverity_operations {
 	int (*get_metadata_end)(struct inode *inode, loff_t *metadata_end_ret);
 	struct page *(*read_metadata_page)(struct inode *inode, pgoff_t index);
 	bool (*verity_required)(struct inode *inode, pgoff_t index);
+	loff_t (*readpage_limit)(struct inode *inode);
 };
 
 #ifdef CONFIG_FS_VERITY
-- 
2.19.1
