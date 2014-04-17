From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: introduce raw_nat_from_node_info() to
 simplfy codes
Date: Thu, 17 Apr 2014 10:51:05 +0800
Message-ID: <000a01cf59e8$03a910d0$0afb3270$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WacQv-00052h-Rf
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Apr 2014 02:52:13 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WacQt-0005JR-P0
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Apr 2014 02:52:13 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N4500EIQMMRA280@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Apr 2014 11:52:03 +0900 (KST)
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
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch introduce raw_nat_from_node_info() to simplfy some codes, and also
use exist function node_info_from_raw_nat() to do the same job.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/node.c |   15 +++------------
 fs/f2fs/node.h |    8 ++++++++
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f760793..84f9b7b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -179,9 +179,7 @@ retry:
 			write_unlock(&nm_i->nat_tree_lock);
 			goto retry;
 		}
-		nat_set_blkaddr(e, le32_to_cpu(ne->block_addr));
-		nat_set_ino(e, le32_to_cpu(ne->ino));
-		nat_set_version(e, ne->version);
+		node_info_from_raw_nat(&e->ni, ne);
 	}
 	write_unlock(&nm_i->nat_tree_lock);
 }
@@ -1755,9 +1753,7 @@ retry:
 			write_unlock(&nm_i->nat_tree_lock);
 			goto retry;
 		}
-		nat_set_blkaddr(ne, le32_to_cpu(raw_ne.block_addr));
-		nat_set_ino(ne, le32_to_cpu(raw_ne.ino));
-		nat_set_version(ne, raw_ne.version);
+		node_info_from_raw_nat(&ne->ni, &raw_ne);
 		__set_nat_cache_dirty(nm_i, ne);
 		write_unlock(&nm_i->nat_tree_lock);
 	}
@@ -1790,7 +1786,6 @@ void flush_nat_entries(struct f2fs_sb_info *sbi)
 		nid_t nid;
 		struct f2fs_nat_entry raw_ne;
 		int offset = -1;
-		block_t new_blkaddr;
 
 		if (nat_get_blkaddr(ne) == NEW_ADDR)
 			continue;
@@ -1826,11 +1821,7 @@ to_nat_page:
 		f2fs_bug_on(!nat_blk);
 		raw_ne = nat_blk->entries[nid - start_nid];
 flush_now:
-		new_blkaddr = nat_get_blkaddr(ne);
-
-		raw_ne.ino = cpu_to_le32(nat_get_ino(ne));
-		raw_ne.block_addr = cpu_to_le32(new_blkaddr);
-		raw_ne.version = nat_get_version(ne);
+		raw_nat_from_node_info(&raw_ne, &ne->ni);
 
 		if (offset < 0) {
 			nat_blk->entries[nid - start_nid] = raw_ne;
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 5decc1a..41bb65b 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -75,6 +75,14 @@ static inline void node_info_from_raw_nat(struct node_info *ni,
 	ni->version = raw_ne->version;
 }
 
+static inline void raw_nat_from_node_info(struct f2fs_nat_entry *raw_ne,
+						struct node_info *ni)
+{
+	raw_ne->ino = cpu_to_le32(ni->ino);
+	raw_ne->block_addr = cpu_to_le32(ni->blk_addr);
+	raw_ne->version = ni->version;
+}
+
 enum nid_type {
 	FREE_NIDS,	/* indicates the free nid list */
 	NAT_ENTRIES	/* indicates the cached nat entry */
-- 
1.7.9.5



------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
