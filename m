From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: avoid to use slab memory in
 f2fs_issue_flush for efficiency
Date: Thu, 08 May 2014 17:00:35 +0800
Message-ID: <000101cf6a9c$14428560$3cc79020$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WiKCq-0006oE-TC
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 May 2014 09:01:32 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WiKCo-0008Ht-Lh
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 May 2014 09:01:32 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N5800HQGZQBS900@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 May 2014 18:01:23 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

If we use slab memory in f2fs_issue_flush(), we will face memory pressure and
latency time caused by racing of kmem_cache_{alloc,free}.

Let's alloc memory in stack instead of slab.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/segment.c |   28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2ecbffb..f25f0e0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -25,7 +25,6 @@
 #define __reverse_ffz(x) __reverse_ffs(~(x))
 
 static struct kmem_cache *discard_entry_slab;
-static struct kmem_cache *flush_cmd_slab;
 
 /*
  * __reverse_ffs is copied from include/asm-generic/bitops/__ffs.h since
@@ -238,30 +237,28 @@ repeat:
 int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 {
 	struct flush_cmd_control *fcc = SM_I(sbi)->cmd_control_info;
-	struct flush_cmd *cmd;
-	int ret;
+	struct flush_cmd cmd;
 
 	if (!test_opt(sbi, FLUSH_MERGE))
 		return blkdev_issue_flush(sbi->sb->s_bdev, GFP_KERNEL, NULL);
 
-	cmd = f2fs_kmem_cache_alloc(flush_cmd_slab, GFP_ATOMIC | __GFP_ZERO);
-	init_completion(&cmd->wait);
+	init_completion(&cmd.wait);
+	cmd.next = NULL;
 
 	spin_lock(&fcc->issue_lock);
 	if (fcc->issue_list)
-		fcc->issue_tail->next = cmd;
+		fcc->issue_tail->next = &cmd;
 	else
-		fcc->issue_list = cmd;
-	fcc->issue_tail = cmd;
+		fcc->issue_list = &cmd;
+	fcc->issue_tail = &cmd;
 	spin_unlock(&fcc->issue_lock);
 
 	if (!fcc->dispatch_list)
 		wake_up(&fcc->flush_wait_queue);
 
-	wait_for_completion(&cmd->wait);
-	ret = cmd->ret;
-	kmem_cache_free(flush_cmd_slab, cmd);
-	return ret;
+	wait_for_completion(&cmd.wait);
+
+	return cmd.ret;
 }
 
 int create_flush_cmd_control(struct f2fs_sb_info *sbi)
@@ -2036,17 +2033,10 @@ int __init create_segment_manager_caches(void)
 			sizeof(struct discard_entry));
 	if (!discard_entry_slab)
 		return -ENOMEM;
-	flush_cmd_slab = f2fs_kmem_cache_create("flush_command",
-			sizeof(struct flush_cmd));
-	if (!flush_cmd_slab) {
-		kmem_cache_destroy(discard_entry_slab);
-		return -ENOMEM;
-	}
 	return 0;
 }
 
 void destroy_segment_manager_caches(void)
 {
 	kmem_cache_destroy(discard_entry_slab);
-	kmem_cache_destroy(flush_cmd_slab);
 }
-- 
1.7.10.4



------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
