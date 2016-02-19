From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2 3/7] f2fs: reorder nat cache lock in
	cache_nat_entry
Date: Fri, 19 Feb 2016 18:12:28 +0800
Message-ID: <01d101d16afe$3497b510$9dc71f30$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aWi4M-00017A-14
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 Feb 2016 10:13:50 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aWi4J-0002ut-62
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 Feb 2016 10:13:50 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O2S034A1HQOLLA0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 Feb 2016 19:13:40 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

When lookuping nat entry in cache_nat_entry, if we fail to hit nat cache,
we try to load nat entries a) from journal of current segment cache or b)
from NAT pages for updating, during the process, write lock of
nat_tree_lock will be held to avoid inconsistent condition in between
nid cache and nat cache caused by racing among nat entry shrinker,
checkpointer, nat entry updater.

But this way may cause low efficient when updating nat cache, because it
serializes accessing in journal cache or reading NAT pages.

Here, we reorder lock and update flow as below to enhance accessing
concurrency:

 - get_node_info
  - down_read(nat_tree_lock)
  - lookup nat cache --- hit -> unlock & return
  - lookup journal cache --- hit -> unlock & goto update
  - up_read(nat_tree_lock)
update:
  - down_write(nat_tree_lock)
  - cache_nat_entry
   - lookup nat cache --- nohit -> update
  - up_write(nat_tree_lock)

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
v2:
 - update commit log for readability and more details.

 fs/f2fs/node.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 94b8016..966176b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -257,15 +257,20 @@ static struct nat_entry *grab_nat_entry(struct f2fs_nm_info *nm_i, nid_t nid)
 	return new;
 }
 
-static void cache_nat_entry(struct f2fs_nm_info *nm_i, nid_t nid,
+static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
 						struct f2fs_nat_entry *ne)
 {
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct nat_entry *e;
 
 	e = __lookup_nat_cache(nm_i, nid);
 	if (!e) {
 		e = grab_nat_entry(nm_i, nid);
 		node_info_from_raw_nat(&e->ni, ne);
+	} else {
+		f2fs_bug_on(sbi, nat_get_ino(e) != ne->ino ||
+				nat_get_blkaddr(e) != ne->block_addr ||
+				nat_get_version(e) != ne->version);
 	}
 }
 
@@ -371,15 +376,12 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
 		ni->ino = nat_get_ino(e);
 		ni->blk_addr = nat_get_blkaddr(e);
 		ni->version = nat_get_version(e);
-	}
-	up_read(&nm_i->nat_tree_lock);
-	if (e)
+		up_read(&nm_i->nat_tree_lock);
 		return;
+	}
 
 	memset(&ne, 0, sizeof(struct f2fs_nat_entry));
 
-	down_write(&nm_i->nat_tree_lock);
-
 	/* Check current segment summary */
 	down_read(&curseg->journal_rwsem);
 	i = lookup_journal_in_cursum(journal, NAT_JOURNAL, nid, 0);
@@ -398,8 +400,10 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
 	node_info_from_raw_nat(ni, &ne);
 	f2fs_put_page(page, 1);
 cache:
+	up_read(&nm_i->nat_tree_lock);
 	/* cache nat entry */
-	cache_nat_entry(NM_I(sbi), nid, &ne);
+	down_write(&nm_i->nat_tree_lock);
+	cache_nat_entry(sbi, nid, &ne);
 	up_write(&nm_i->nat_tree_lock);
 }
 
-- 
2.7.0



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
