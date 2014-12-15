From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/7] f2fs: fix wrong condition check to trigger
	f2fs_sync_fs
Date: Sun, 14 Dec 2014 23:27:33 -0800
Message-ID: <1418628458-82740-2-git-send-email-jaegeuk@kernel.org>
References: <1418628458-82740-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Y0Q4J-0005we-Hg
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 Dec 2014 07:27:47 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y0Q4I-0000Xq-IQ for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 Dec 2014 07:27:47 +0000
In-Reply-To: <1418628458-82740-1-git-send-email-jaegeuk@kernel.org>
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

If there is not enough available memory, we need to trigger f2fs_sync_fs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 42607a6..11e4b5c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -290,7 +290,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 	/* check the # of cached NAT entries and prefree segments */
 	if (try_to_free_nats(sbi, NAT_ENTRY_PER_BLOCK) ||
 			excess_prefree_segs(sbi) ||
-			available_free_memory(sbi, INO_ENTRIES))
+			!available_free_memory(sbi, INO_ENTRIES))
 		f2fs_sync_fs(sbi->sb, true);
 }
 
-- 
2.1.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
