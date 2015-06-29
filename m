From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 09/12] f2fs: shrink nat_cache entries
Date: Mon, 29 Jun 2015 11:39:33 -0700
Message-ID: <1435603176-63219-9-git-send-email-jaegeuk@kernel.org>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Z9dyh-0000hD-7T
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 18:40:23 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z9dye-0004fz-9T for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 18:40:23 +0000
In-Reply-To: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch registers shrinking nat_cache entries.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c     |  6 +++---
 fs/f2fs/segment.c  |  8 ++++++--
 fs/f2fs/shrinker.c | 11 +++++++++--
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d9c5242..318ee86 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -328,11 +328,11 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 int try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	int nr = nr_shrink;
 
-	if (available_free_memory(sbi, NAT_ENTRIES))
+	if (!down_write_trylock(&nm_i->nat_tree_lock))
 		return 0;
 
-	down_write(&nm_i->nat_tree_lock);
 	while (nr_shrink && !list_empty(&nm_i->nat_entries)) {
 		struct nat_entry *ne;
 		ne = list_first_entry(&nm_i->nat_entries,
@@ -341,7 +341,7 @@ int try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink)
 		nr_shrink--;
 	}
 	up_write(&nm_i->nat_tree_lock);
-	return nr_shrink;
+	return nr - nr_shrink;
 }
 
 /*
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1eb3437..dec3afb 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -305,8 +305,12 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 	/* try to shrink extent cache when there is no enough memory */
 	f2fs_shrink_extent_tree(sbi, EXTENT_CACHE_SHRINK_NUMBER);
 
-	/* check the # of cached NAT entries and prefree segments */
-	if (try_to_free_nats(sbi, NAT_ENTRY_PER_BLOCK) ||
+	/* check the # of cached NAT entries */
+	if (!available_free_memory(sbi, NAT_ENTRIES))
+		try_to_free_nats(sbi, NAT_ENTRY_PER_BLOCK);
+
+	/* checkpoint is the only way to shrink partial cached entries */
+	if (!available_free_memory(sbi, NAT_ENTRIES) ||
 			excess_prefree_segs(sbi) ||
 			!available_free_memory(sbi, INO_ENTRIES))
 		f2fs_sync_fs(sbi->sb, true);
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index a680145..3350ac3 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -18,6 +18,11 @@ static LIST_HEAD(f2fs_list);
 static DEFINE_SPINLOCK(f2fs_list_lock);
 static unsigned int shrinker_run_no;
 
+static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
+{
+	return NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
+}
+
 unsigned long f2fs_shrink_count(struct shrinker *shrink,
 				struct shrink_control *sc)
 {
@@ -37,7 +42,8 @@ unsigned long f2fs_shrink_count(struct shrinker *shrink,
 		}
 		spin_unlock(&f2fs_list_lock);
 
-		/* TODO: count # of objects */
+		/* shrink clean nat cache entries */
+		count += __count_nat_entries(sbi);
 
 		spin_lock(&f2fs_list_lock);
 		p = p->next;
@@ -76,7 +82,8 @@ unsigned long f2fs_shrink_scan(struct shrinker *shrink,
 
 		sbi->shrinker_run_no = run_no;
 
-		/* TODO: shrink caches */
+		/* shrink clean nat cache entries */
+		freed += try_to_free_nats(sbi, nr);
 
 		spin_lock(&f2fs_list_lock);
 		p = p->next;
-- 
2.1.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
