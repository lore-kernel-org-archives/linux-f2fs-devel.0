From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 2/3] f2fs: move alloc new orphan node out of lock
 protection region
Date: Fri, 10 Jan 2014 18:09:08 +0800
Message-ID: <52CFC6C4.7030309@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1W1Z8o-0007j6-Ef
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Jan 2014 10:16:38 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W1Z8n-0001Eb-Kn for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Jan 2014 10:16:38 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kim <jaegeuk.kim@samsung.com>
Cc: fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>

Move alloc new orphan node out of lock protection region.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/checkpoint.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index af92c74..007f64c 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -219,26 +219,29 @@ void add_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 	struct list_head *head, *this;
 	struct orphan_inode_entry *new = NULL, *orphan = NULL;
 
+	new = f2fs_kmem_cache_alloc(orphan_entry_slab, GFP_ATOMIC);
+	new->ino = ino;
+
 	mutex_lock(&sbi->orphan_inode_mutex);
 	head = &sbi->orphan_inode_list;
 	list_for_each(this, head) {
 		orphan = list_entry(this, struct orphan_inode_entry, list);
-		if (orphan->ino == ino)
-			goto out;
+		if (orphan->ino == ino) {
+			mutex_unlock(&sbi->orphan_inode_mutex);
+			kmem_cache_free(orphan_entry_slab, new);
+			return;
+		}
+
 		if (orphan->ino > ino)
 			break;
 		orphan = NULL;
 	}
 
-	new = f2fs_kmem_cache_alloc(orphan_entry_slab, GFP_ATOMIC);
-	new->ino = ino;
-
 	/* add new_oentry into list which is sorted by inode number */
 	if (orphan)
 		list_add(&new->list, this->prev);
 	else
 		list_add_tail(&new->list, head);
-out:
 	mutex_unlock(&sbi->orphan_inode_mutex);
 }
 
-- 
1.7.7


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
