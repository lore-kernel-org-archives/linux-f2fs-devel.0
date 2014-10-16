From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] fsck.f2fs: fix superblock offset
Date: Wed, 15 Oct 2014 20:59:09 -0700
Message-ID: <1413431951-27137-2-git-send-email-jaegeuk@kernel.org>
References: <1413431951-27137-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XecDi-0003Ww-Uf
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Oct 2014 03:59:22 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XecDi-0007mf-7f for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Oct 2014 03:59:22 +0000
In-Reply-To: <1413431951-27137-1-git-send-email-jaegeuk@kernel.org>
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

The second offset should be F2FS_BLKSIZE + F2FS_SUPER_OFFSET.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 415f977..8b39d37 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -223,9 +223,14 @@ int sanity_check_raw_super(struct f2fs_super_block *raw_super)
 
 int validate_super_block(struct f2fs_sb_info *sbi, int block)
 {
-	u64 offset = (block + 1) * F2FS_SUPER_OFFSET;
+	u64 offset;
 	sbi->raw_super = malloc(sizeof(struct f2fs_super_block));
 
+	if (block == 0)
+		offset = F2FS_SUPER_OFFSET;
+	else
+		offset = F2FS_BLKSIZE + F2FS_SUPER_OFFSET;
+
 	if (dev_read(sbi->raw_super, offset, sizeof(struct f2fs_super_block)))
 		return -1;
 
-- 
2.1.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
