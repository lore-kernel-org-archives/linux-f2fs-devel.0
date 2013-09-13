From: Jin Xu <jinuxstyle@gmail.com>
Subject: [PATCH] f2fs: optimize the victim searching loop slightly
Date: Fri, 13 Sep 2013 08:38:54 +0800
Message-ID: <1379032734-7677-1-git-send-email-jinuxstyle@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jinuxstyle@gmail.com>) id 1VKHPi-0006sk-49
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Sep 2013 00:39:10 +0000
Received: from mail-pa0-f43.google.com ([209.85.220.43])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VKHPe-0007mP-Tf
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Sep 2013 00:39:10 +0000
Received: by mail-pa0-f43.google.com with SMTP id hz10so1815275pad.30
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 12 Sep 2013 17:39:00 -0700 (PDT)
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
Cc: linux-fsdevel@vger.kernel.org, jinuxstyle@gmail.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Since the MAX_VICTIM_SEARCH has been enlarged from 20 to 4096,
the victim searching overhead will be increased much than before,
especially for SSR that searches victim for use quiet often.
This patch intends to reduce the overhead a little bit by:
- make the get_gc_cost a inline routine to reduce function call
  overhead
- reduce multiplication and division operations
- reduce unnecessary comparison operation

Signed-off-by: Jin Xu <jinuxstyle@gmail.com>
---
 fs/f2fs/gc.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a78b8e3..14187bf 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -221,8 +221,8 @@ static unsigned int get_cb_cost(struct f2fs_sb_info *sbi, unsigned int segno)
 	return UINT_MAX - ((100 * (100 - u) * age) / (100 + u));
 }
 
-static unsigned int get_gc_cost(struct f2fs_sb_info *sbi, unsigned int segno,
-					struct victim_sel_policy *p)
+static inline unsigned int get_gc_cost(struct f2fs_sb_info *sbi,
+			unsigned int segno, struct victim_sel_policy *p)
 {
 	if (p->alloc_mode == SSR)
 		return get_seg_entry(sbi, segno)->ckpt_valid_blocks;
@@ -278,7 +278,11 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 			}
 			break;
 		}
-		p.offset = ((segno / p.ofs_unit) * p.ofs_unit) + p.ofs_unit;
+
+		p.offset = segno + p.ofs_unit;
+		if (p.ofs_unit > 1)
+			p.offset -= segno % p.ofs_unit;
+
 		secno = GET_SECNO(sbi, segno);
 
 		if (sec_usage_check(sbi, secno))
@@ -291,10 +295,9 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 		if (p.min_cost > cost) {
 			p.min_segno = segno;
 			p.min_cost = cost;
-		}
-
-		if (cost == max_cost)
+		} else if (unlikely(cost == max_cost)) {
 			continue;
+		}
 
 		if (nsearched++ >= p.max_search) {
 			sbi->last_victim[p.gc_mode] = segno;
-- 
1.7.9.5


------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. Consolidate legacy IT systems to a single system of record for IT
2. Standardize and globalize service processes across IT
3. Implement zero-touch automation to replace manual, redundant tasks
http://pubads.g.doubleclick.net/gampad/clk?id=51271111&iu=/4140/ostg.clktrk
