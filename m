From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: declare static function for
	__build_free_nids
Date: Tue, 18 Oct 2016 11:49:07 -0700
Message-ID: <20161018184907.12961-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bwZRs-0007ad-KN
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Oct 2016 18:49:16 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bwZRr-0003Rv-VU
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Oct 2016 18:49:16 +0000
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

This patch avoids build warning.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index fc8f274..69c42e2 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1808,7 +1808,7 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
 	}
 }
 
-void __build_free_nids(struct f2fs_sb_info *sbi, bool sync)
+static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
-- 
2.8.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
