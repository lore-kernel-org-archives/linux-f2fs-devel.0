From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/5] f2fs: do not skip any writes under memory
	pressure
Date: Sat,  8 Nov 2014 23:36:09 -0800
Message-ID: <1415518569-20626-5-git-send-email-jaegeuk@kernel.org>
References: <1415518569-20626-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XnN2u-0004PW-1N
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 09 Nov 2014 07:36:24 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XnN2t-00053X-BB for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 09 Nov 2014 07:36:24 +0000
In-Reply-To: <1415518569-20626-1-git-send-email-jaegeuk@kernel.org>
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

Under memory pressure, let's avoid skipping data writes.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 6723ccc..7f327c0 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -711,6 +711,9 @@ static inline unsigned int max_hw_blocks(struct f2fs_sb_info *sbi)
  */
 static inline int nr_pages_to_skip(struct f2fs_sb_info *sbi, int type)
 {
+	if (sbi->sb->s_bdi->dirty_exceeded)
+		return 0;
+
 	if (type == DATA)
 		return sbi->blocks_per_seg;
 	else if (type == NODE)
-- 
2.1.1


------------------------------------------------------------------------------
