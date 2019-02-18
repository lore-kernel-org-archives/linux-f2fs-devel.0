From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: [RFC PATCH 08/10] fsverity: Add call back to verify file
 holes
Date: Mon, 18 Feb 2019 15:34:31 +0530
Message-ID: <20190218100433.20048-9-chandan@linux.ibm.com>
References: <20190218100433.20048-1-chandan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1gvfnB-0005SQ-SX
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Feb 2019 10:04:53 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gvfn4-005dAw-02
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Feb 2019 10:04:53 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1IA3tnV060314
 for <linux-f2fs-devel@lists.sourceforge.net>; Mon, 18 Feb 2019 05:04:40 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qqsn8u0js-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Mon, 18 Feb 2019 05:04:39 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Mon, 18 Feb 2019 10:04:38 -0000
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

readpage() implmentations zero out part of the page-cache page mapping a
file hole. This commit adds a call back to "struct fsverity_operations"
which readpage() can invoke to verify the file hole.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
---
 fs/ext4/super.c          | 1 +
 include/linux/fsverity.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4493ddc357c6..94e0d4b56653 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1459,6 +1459,7 @@ static const struct fsverity_operations ext4_verityops = {
 	.read_metadata_page	= ext4_read_verity_metadata_page,
 	.verity_required	= ext4_verity_required,
 	.readpage_limit		= ext4_readpage_limit,
+	.check_hole		= fsverity_check_hole,
 };
 #endif /* CONFIG_FS_VERITY */
 
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index fc8113acbbfe..8bc28b07d550 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -20,6 +20,7 @@ struct fsverity_operations {
 	struct page *(*read_metadata_page)(struct inode *inode, pgoff_t index);
 	bool (*verity_required)(struct inode *inode, pgoff_t index);
 	loff_t (*readpage_limit)(struct inode *inode);
+	bool (*check_hole)(struct inode *inode, struct page *page);
 };
 
 #ifdef CONFIG_FS_VERITY
-- 
2.19.1
