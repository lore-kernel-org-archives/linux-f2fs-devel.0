From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: wake up discard_thread iff there is a
 candidate
Date: Thu, 24 Aug 2017 12:03:12 -0700
Message-ID: <20170824190312.10883-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1dkxPT-0006NG-M2
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Aug 2017 19:03:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dkxPS-0006Bl-Tl
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Aug 2017 19:03:19 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch fixes to avoid needless wake ups.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c |  3 +--
 fs/f2fs/segment.h | 25 +++++++++++++++++++++++++
 fs/f2fs/sysfs.c   |  6 +-----
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8306beace7cb..8375257b6b26 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1494,8 +1494,7 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		kmem_cache_free(discard_entry_slab, entry);
 	}
 
-	dcc->discard_wake = 1;
-	wake_up_interruptible_all(&dcc->discard_wait_queue);
+	wake_up_discard_thread(sbi, false);
 }
 
 static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index b9b4f85ffeb6..5099e12ee808 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -798,3 +798,28 @@ static inline long nr_pages_to_write(struct f2fs_sb_info *sbi, int type,
 	wbc->nr_to_write = desired;
 	return desired - nr_to_write;
 }
+
+static inline void wake_up_discard_thread(struct f2fs_sb_info *sbi, bool force)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	bool wakeup = false;
+	int i;
+
+	if (force)
+		goto wake_up;
+
+	mutex_lock(&dcc->cmd_lock);
+	for (i = MAX_PLIST_NUM - 1;
+			i >= 0 && plist_issue(dcc->pend_list_tag[i]); i--) {
+		if (!list_empty(&dcc->pend_list[i])) {
+			wakeup = true;
+			break;
+		}
+	}
+	mutex_unlock(&dcc->cmd_lock);
+	if (wakeup)
+		return;
+wake_up:
+	dcc->discard_wake = 1;
+	wake_up_interruptible_all(&dcc->discard_wait_queue);
+}
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index b9ad9041559f..962735dc9c63 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -178,13 +178,9 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	if (!strcmp(a->attr.name, "iostat_enable") && *ui == 0)
 		f2fs_reset_iostat(sbi);
 	if (!strcmp(a->attr.name, "gc_urgent") && t == 1 && sbi->gc_thread) {
-		struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-
 		sbi->gc_thread->gc_wake = 1;
 		wake_up_interruptible_all(&sbi->gc_thread->gc_wait_queue_head);
-
-		dcc->discard_wake = 1;
-		wake_up_interruptible_all(&dcc->discard_wait_queue);
+		wake_up_discard_thread(sbi, true);
 	}
 
 	return count;
-- 
2.14.0.rc1.383.gd1ce394fe2-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
