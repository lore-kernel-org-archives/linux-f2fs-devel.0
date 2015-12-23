From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 4/4] f2fs: call f2fs_balance_fs only when
	node	was changed
Date: Wed, 23 Dec 2015 17:46:59 +0800
Message-ID: <010b01d13d66$f85f2ac0$e91d8040$@samsung.com>
References: <1450832388-29118-1-git-send-email-jaegeuk@kernel.org>
	<1450832388-29118-4-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aBg1Q-0005a7-0o
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Dec 2015 09:47:52 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aBg1O-0001kR-FP
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Dec 2015 09:47:51 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZT01UN21VIXO30@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Dec 2015 18:47:42 +0900 (KST)
In-reply-to: <1450832388-29118-4-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, December 23, 2015 9:00 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 4/4] f2fs: call f2fs_balance_fs only when node was changed
> 
> If user tries to update or read data, we don't need to call f2fs_balance_fs
> which triggers f2fs_gc, which increases unnecessary long latency.

One missing case is get_data_block_dio, how about also covering it based on
following patch?


>From 7175efac7473e7a04285055c69edfb7432f8ca4e Mon Sep 17 00:00:00 2001
From: Chao Yu <chao2.yu@samsung.com>
Date: Wed, 23 Dec 2015 17:11:43 +0800
Subject: [PATCH] f2fs: reduce covered region of sbi->cp_rwsem in
 f2fs_map_blocks

Only cover sbi->cp_rwsem on one dnode page's allocation and modification
instead of multiple's in f2fs_map_blocks, it can reduce the covered region
of cp_rwsem, then we can avoid potential long time delay for concurrent
checkpointer.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8f8f8b0..3c83b16 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -594,7 +594,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	}
 
 	if (create)
-		f2fs_lock_op(F2FS_I_SB(inode));
+		f2fs_lock_op(sbi);
 
 	/* When reading holes, we need its node page */
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
@@ -651,6 +651,11 @@ get_next:
 		allocated = false;
 		f2fs_put_dnode(&dn);
 
+		if (create) {
+			f2fs_unlock_op(sbi);
+			f2fs_lock_op(sbi);
+		}
+
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		err = get_dnode_of_data(&dn, pgofs, mode);
 		if (err) {
@@ -706,7 +711,7 @@ put_out:
 	f2fs_put_dnode(&dn);
 unlock_out:
 	if (create)
-		f2fs_unlock_op(F2FS_I_SB(inode));
+		f2fs_unlock_op(sbi);
 out:
 	trace_f2fs_map_blocks(inode, map, err);
 	return err;
-- 
2.6.3



------------------------------------------------------------------------------
