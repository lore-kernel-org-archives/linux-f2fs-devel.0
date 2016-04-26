From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 7/7] f2fs: should check the remaining dentry bits
Date: Mon, 25 Apr 2016 17:07:00 -0700
Message-ID: <1461629220-16280-7-git-send-email-jaegeuk@kernel.org>
References: <1461629220-16280-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1auqX3-0003WE-IS
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 00:07:13 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1auqX2-00018W-Rq
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 00:07:13 +0000
In-Reply-To: <1461629220-16280-1-git-send-email-jaegeuk@kernel.org>
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

Let's consider a race condition between f2fs_add_regular_entry and
find_target_dentry.

1.
- f2fs_add_regular_entry updated len: 24 first.
       |
Bits:  0 0 0 1
Lens: 24 0 0 3 (name: foo)
       |->
- find_target_dentry checks the first bit to find "foo", then ++pointer.

2.
- f2fs_add_regular_entry updates bits.
       |>|>|
Bits:  1 1 1 1
Lens: 24 0 0 3 (name: foo)
         |
- find_target_dentry is checking second bit, but it's len is zero, which
makes the process being terminated.

In this case, user can add additional dentry named "foo" accordingly.
This patch enables to check the remaining bits.

Signed-off-by: He YunLei <heyunlei@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index e90380d..aed5e6d 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -149,9 +149,9 @@ struct f2fs_dir_entry *find_target_dentry(struct fscrypt_name *fname,
 
 		/* remain bug on condition */
 		if (unlikely(!de->name_len))
-			d->max = -1;
-
-		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
+			bit_pos++;
+		else
+			bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
 	}
 
 	de = NULL;
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
