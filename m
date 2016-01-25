From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6/6] f2fs: avoid needless sync_inode_page when
	reading inline_data
Date: Mon, 25 Jan 2016 14:05:31 -0800
Message-ID: <1453759531-16076-6-git-send-email-jaegeuk@kernel.org>
References: <1453759531-16076-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aNpGi-0004QA-Nz
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 Jan 2016 22:05:52 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aNpGi-000341-4L for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 Jan 2016 22:05:52 +0000
In-Reply-To: <1453759531-16076-1-git-send-email-jaegeuk@kernel.org>
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

In write_begin, if there is an inline_data, f2fs loads it into 0'th data page.
Since it's the read path, we don't need to sync its inode page.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a6a6f08..4e992bf 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1464,7 +1464,6 @@ restart:
 			read_inline_data(page, ipage);
 			set_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
 			set_inline_node(ipage);
-			sync_inode_page(&dn);
 		} else {
 			err = f2fs_convert_inline_page(&dn, page);
 			if (err)
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
