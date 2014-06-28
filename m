From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: check bdi->dirty_exceeded when trying to
	skip data writes
Date: Sat, 28 Jun 2014 20:58:38 +0900
Message-ID: <1403956718-17575-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1X0rHS-0007No-Py
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 Jun 2014 11:58:54 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X0rHR-0008RY-2X for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 Jun 2014 11:58:54 +0000
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

If we don't check the current backing device status, balance_dirty_pages can
fall into infinite pausing routine.

This can be occurred when a lot of directories make a small number of dirty
dentry pages including files.

Reported-by: Brian Chadwick <brianchad@westnet.com.au>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 56907c6..a90f51d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -43,6 +43,8 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
 		mem_size = (nm_i->nat_cnt * sizeof(struct nat_entry)) >> 12;
 		res = mem_size < ((val.totalram * nm_i->ram_thresh / 100) >> 2);
 	} else if (type == DIRTY_DENTS) {
+		if (sbi->sb->s_bdi->dirty_exceeded)
+			return false;
 		mem_size = get_pages(sbi, F2FS_DIRTY_DENTS);
 		res = mem_size < ((val.totalram * nm_i->ram_thresh / 100) >> 1);
 	}
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
