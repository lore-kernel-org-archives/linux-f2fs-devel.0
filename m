From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/5] f2fs: add missing f2fs_balance_fs in
	__recover_dot_dentries
Date: Thu, 24 Dec 2015 18:03:29 +0800
Message-ID: <016401d13e32$784c7aa0$68e56fe0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aC2l9-0004qU-It
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Dec 2015 10:04:35 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aC2l7-0001uD-K5
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Dec 2015 10:04:35 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZU016ZZXBEYF80@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Dec 2015 19:04:26 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

__recover_do_dentries will try to grab free space in storage, so fix to
add missing f2fs_balance_fs here.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/namei.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index e439f32..fb41c80 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -214,6 +214,8 @@ static int __recover_dot_dentries(struct inode *dir, nid_t pino)
 	struct page *page;
 	int err = 0;
 
+	f2fs_balance_fs(sbi);
+
 	f2fs_lock_op(sbi);
 
 	de = f2fs_find_entry(dir, &dot, &page);
-- 
2.6.3



------------------------------------------------------------------------------
