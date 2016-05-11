From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH 2/4] f2fs: introduce f2fs_fault_info for
	fault injection
Date: Wed, 11 May 2016 17:08:15 +0800
Message-ID: <1462957697-6900-2-git-send-email-shengyong1@huawei.com>
References: <1462957697-6900-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1b0QAi-0003Wa-1M
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 11 May 2016 09:11:12 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1b0QAf-0003jQ-0R
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 11 May 2016 09:11:12 +0000
In-Reply-To: <1462957697-6900-1-git-send-email-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

This patch introduces a new struct f2fs_fault_info and a global f2fs_fault
to save fault injection status.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/f2fs.h  | 12 ++++++++++++
 fs/f2fs/super.c |  1 +
 2 files changed, 13 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 052f5a8..e18390b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -48,6 +48,18 @@ enum {
 	FAULT_MAX,
 };
 
+struct f2fs_fault_info {
+	unsigned int inject_rate;
+	atomic_t inject_ops;
+	unsigned int inject_kmalloc;
+	unsigned int inject_page_alloc;
+	unsigned int inject_nid_alloc;
+	unsigned int inject_orphan;
+	unsigned int inject_block;
+	unsigned int inject_dir_depth;
+};
+
+extern struct f2fs_fault_info f2fs_fault;
 extern u32 f2fs_fault_rate;
 extern atomic_t f2fs_ops;
 extern char *fault_name[FAULT_MAX];
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0e54e84..069dc44 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -40,6 +40,7 @@ static struct kmem_cache *f2fs_inode_cachep;
 static struct kset *f2fs_kset;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
+struct f2fs_fault_info f2fs_fault;
 u32 f2fs_fault_rate = 0;
 atomic_t f2fs_ops;
 
-- 
2.7.1


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
