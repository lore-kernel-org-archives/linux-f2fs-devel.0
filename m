From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] fsck.f2fs: drop extent_info to avoid
	potential wrong access
Date: Mon,  6 Jul 2015 15:55:31 -0700
Message-ID: <1436223331-29064-2-git-send-email-jaegeuk@kernel.org>
References: <1436223331-29064-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZCFIe-0001x3-35
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Jul 2015 22:55:44 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZCFId-0000Rz-BP for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Jul 2015 22:55:44 +0000
In-Reply-To: <1436223331-29064-1-git-send-email-jaegeuk@kernel.org>
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

This patch avoids wrong extent information modified by fixing block addresses.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index bbd4cab..70efce6 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -722,6 +722,8 @@ skip_blkcnt_fix:
 		}
 	}
 	if (need_fix) {
+		/* drop extent information to avoid potential wrong access */
+		node_blk->i.i_ext.len = 0;
 		ret = dev_write_block(node_blk, ni->blk_addr);
 		ASSERT(ret >= 0);
 	}
-- 
2.1.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
