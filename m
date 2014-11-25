From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] fsck.f2fs: no need to fix SIT type for COLD_DATA
Date: Mon, 24 Nov 2014 17:48:10 -0800
Message-ID: <1416880090-32756-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Xt5Es-0003NE-MJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Nov 2014 01:48:22 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xt5Er-0005lR-Mf for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Nov 2014 01:48:22 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

If hot or warm data blocks were moved to the cold log, we should remain them
in the cold log.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index f7309d6..09bb26f 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1007,9 +1007,13 @@ int check_sit_types(struct f2fs_sb_info *sbi)
 
 		se = get_seg_entry(sbi, i);
 		if (se->orig_type != se->type) {
-			FIX_MSG("Wrong segment type [0x%x] %x -> %x",
-					i, se->orig_type, se->type);
-			err = -EINVAL;
+			if (se->orig_type == CURSEG_COLD_DATA) {
+				se->type = se->orig_type;
+			} else {
+				FIX_MSG("Wrong segment type [0x%x] %x -> %x",
+						i, se->orig_type, se->type);
+				err = -EINVAL;
+			}
 		}
 	}
 	return err;
-- 
2.1.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
