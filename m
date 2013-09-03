From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/2] f2fs: avoid an overflow during utilization
	calculation
Date: Tue, 03 Sep 2013 15:27:53 +0900
Message-ID: <1378189673-32656-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1378189673-32656-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VGk60-0001Hy-La
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 Sep 2013 06:28:12 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VGk5z-000169-M1 for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 Sep 2013 06:28:12 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MSJ00FMBDYQWN10@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 Sep 2013 15:28:02 +0900 (KST)
In-reply-to: <1378189673-32656-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

The current f2fs uses all the block counts with 32 bit numbers, which is able to
cover about 15TB volume.

But in calculation of utilization, f2fs multiplies the count by 100 which can
induce overflow.
This patch fixes this.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/segment.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index cd9bd93..e0d6d3a 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -471,7 +471,7 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi, int freed)
 
 static inline int utilization(struct f2fs_sb_info *sbi)
 {
-	return div_u64(valid_user_blocks(sbi) * 100, sbi->user_block_count);
+	return div_u64((u64)valid_user_blocks(sbi) * 100, sbi->user_block_count);
 }
 
 /*
-- 
1.8.3.1.437.g0dbd812


------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
