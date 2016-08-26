From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: fix to update node page under cp_rwsem
Date: Sat, 27 Aug 2016 00:14:32 +0800
Message-ID: <1472228072-4555-2-git-send-email-chao@kernel.org>
References: <1472228072-4555-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bdJoI-0008TS-4R
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Aug 2016 16:16:50 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bdJoH-0001sj-Fv
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Aug 2016 16:16:50 +0000
In-Reply-To: <1472228072-4555-1-git-send-email-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Update node page under cp_rwsem in order to keep data consistency
during writting checkpoint.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 9ac5efc..1057c73 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -377,8 +377,11 @@ retry:
 		goto retry;
 	}
 
-	if (err)
+	if (err) {
+		f2fs_lock_op(sbi);
 		update_inode_page(inode);
+		f2fs_unlock_op(sbi);
+	}
 	sb_end_intwrite(inode->i_sb);
 no_delete:
 	stat_dec_inline_xattr(inode);
-- 
2.7.2


------------------------------------------------------------------------------
