From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 08/09] f2fs: avoid build warning
Date: Sun, 19 Oct 2014 22:18:31 -0700
Message-ID: <1413782312-11631-8-git-send-email-jaegeuk@kernel.org>
References: <1413782312-11631-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Xg5Mo-0008Pa-4h
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 05:18:50 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xg5Mn-0000qz-4r for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 05:18:50 +0000
In-Reply-To: <1413782312-11631-1-git-send-email-jaegeuk@kernel.org>
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

This patch removes build warning.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 902c4c3..2c1e608 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1715,7 +1715,7 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 * #2, flush sit entries to sit page.
 	 */
 	list_for_each_entry_safe(ses, tmp, head, set_list) {
-		struct page *page;
+		struct page *page = NULL;
 		struct f2fs_sit_block *raw_sit = NULL;
 		unsigned int start_segno = ses->start_segno;
 		unsigned int end = min(start_segno + SIT_ENTRY_PER_BLOCK,
-- 
2.1.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
