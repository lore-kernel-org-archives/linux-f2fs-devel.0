From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH 05/15] f2fs: remove unnecessary por_doing check
Date: Mon, 20 May 2013 12:32:19 +0900
Message-ID: <1369020743-18520-5-git-send-email-jaegeuk.kim@samsung.com>
References: <1369020743-18520-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UeGrL-00061I-IJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 May 2013 03:34:03 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UeGr5-000513-IK for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 May 2013 03:34:03 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MN2000TKV7K42I0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 May 2013 12:33:34 +0900 (KST)
In-reply-to: <1369020743-18520-1-git-send-email-jaegeuk.kim@samsung.com>
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

This por_doing check is totally not related to the recovery process.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/namei.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 47abc97..729b285 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -149,8 +149,7 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 
 	alloc_nid_done(sbi, ino);
 
-	if (!sbi->por_doing)
-		d_instantiate(dentry, inode);
+	d_instantiate(dentry, inode);
 	unlock_new_inode(inode);
 	return 0;
 out:
-- 
1.8.1.3.566.gaa39828


------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
