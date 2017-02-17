From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: trace victim's cost selectecd by f2fs_gc
Date: Fri, 17 Feb 2017 10:30:32 -0800
Message-ID: <20170217183032.3059-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cenIn-00071l-7K
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Feb 2017 18:30:41 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cenIm-00046X-EQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Feb 2017 18:30:41 +0000
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

This patch adds min_cost of each victims.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/trace/events/f2fs.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 153572e256d6..ff31ccfb8111 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -565,6 +565,7 @@ TRACE_EVENT(f2fs_get_victim,
 		__field(int,	alloc_mode)
 		__field(int,	gc_mode)
 		__field(unsigned int,	victim)
+		__field(unsigned int,	cost)
 		__field(unsigned int,	ofs_unit)
 		__field(unsigned int,	pre_victim)
 		__field(unsigned int,	prefree)
@@ -578,20 +579,23 @@ TRACE_EVENT(f2fs_get_victim,
 		__entry->alloc_mode	= p->alloc_mode;
 		__entry->gc_mode	= p->gc_mode;
 		__entry->victim		= p->min_segno;
+		__entry->cost		= p->min_cost;
 		__entry->ofs_unit	= p->ofs_unit;
 		__entry->pre_victim	= pre_victim;
 		__entry->prefree	= prefree;
 		__entry->free		= free;
 	),
 
-	TP_printk("dev = (%d,%d), type = %s, policy = (%s, %s, %s), victim = %u "
-		"ofs_unit = %u, pre_victim_secno = %d, prefree = %u, free = %u",
+	TP_printk("dev = (%d,%d), type = %s, policy = (%s, %s, %s), "
+		"victim = %u, cost = %u, ofs_unit = %u, "
+		"pre_victim_secno = %d, prefree = %u, free = %u",
 		show_dev(__entry->dev),
 		show_data_type(__entry->type),
 		show_gc_type(__entry->gc_type),
 		show_alloc_mode(__entry->alloc_mode),
 		show_victim_policy(__entry->gc_mode),
 		__entry->victim,
+		__entry->cost,
 		__entry->ofs_unit,
 		(int)__entry->pre_victim,
 		__entry->prefree,
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
