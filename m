From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] fsck: clear useless "continue" in __chk_dentries
Date: Tue, 20 Sep 2016 20:43:48 +0800
Message-ID: <1474375428-29360-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yunlong.song@huawei.com>) id 1bmKFC-0002Ig-WA
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Sep 2016 12:33:51 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bmKF8-0005ad-U6
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Sep 2016 12:33:50 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yunlong.song@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fsck/fsck.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index e2081c8..301685b 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1240,7 +1240,6 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 				name_len = le16_to_cpu(dentry[i].name_len);
 				if (name_len > 0)
 					i += (name_len + F2FS_SLOT_LEN - 1) / F2FS_SLOT_LEN - 1;
-				continue;
 			}
 		}
 	}
-- 
1.8.5.2


------------------------------------------------------------------------------
