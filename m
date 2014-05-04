From: Zhang Zhen <zhenzhang.zhang@huawei.com>
Subject: [PATCH] f2fs: fix checkpatch warning
Date: Sun, 4 May 2014 16:37:06 +0800
Message-ID: <5365FC32.6060000@huawei.com>
References: <1399192546-3850-1-git-send-email-zhenzhang.zhang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhenzhang.zhang@huawei.com>) id 1WgrvN-0007TH-Vy
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 04 May 2014 08:37:30 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WgrvL-0000Ds-OT
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 04 May 2014 08:37:29 +0000
In-Reply-To: <1399192546-3850-1-git-send-email-zhenzhang.zhang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

fix the following checkpatch warning:
WARNING: do {} while (0) macros should not be semicolon terminated

Signed-off-by: Zhang Zhen <zhenzhang.zhang@huawei.com>
---
 fs/f2fs/node.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 5decc1a..dbd65a7e0 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -59,12 +59,12 @@ struct nat_entry {
 	do {								\
 		ne->checkpointed = false;				\
 		list_move_tail(&ne->list, &nm_i->dirty_nat_entries);	\
-	} while (0);
+	} while (0)
 #define __clear_nat_cache_dirty(nm_i, ne)				\
 	do {								\
 		ne->checkpointed = true;				\
 		list_move_tail(&ne->list, &nm_i->nat_entries);		\
-	} while (0);
+	} while (0)
 #define inc_node_version(version)	(++version)

 static inline void node_info_from_raw_nat(struct node_info *ni,
-- 
1.8.1.2


.





------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
