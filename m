From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/3 v2] f2fs: use lock_buffer when changing
 superblock
Date: Wed, 9 Dec 2015 09:54:40 -0800
Message-ID: <20151209175440.GA975@jaegeuk.local>
References: <1449528805-89661-1-git-send-email-jaegeuk@kernel.org>
	<1449528805-89661-3-git-send-email-jaegeuk@kernel.org>
	<015101d13248$58a641e0$09f2c5a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a6ix2-0004cn-N1
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Dec 2015 17:54:52 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a6iwx-0003Qs-Fp for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Dec 2015 17:54:52 +0000
Content-Disposition: inline
In-Reply-To: <015101d13248$58a641e0$09f2c5a0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Agreed.

Change log from v1:
 o apply for _undo_ flow as well

>From ea212a4a7a432e0ecd0f0f53971b70172b3e7f96 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 7 Dec 2015 10:18:54 -0800
Subject: [PATCH] f2fs: use lock_buffer when changing superblock

When modifying sb contents, we need to use lock its buffer.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a018ed3..294e715 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1591,14 +1591,18 @@ static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
 		return err;
 
 	/* update superblock with uuid */
+	lock_buffer(sbi->raw_super_buf);
 	generate_random_uuid(sbi->raw_super->encrypt_pw_salt);
+	unlock_buffer(sbi->raw_super_buf);
 
 	err = f2fs_commit_super(sbi, false);
 
 	mnt_drop_write_file(filp);
 	if (err) {
 		/* undo new data */
+		lock_buffer(sbi->raw_super_buf);
 		memset(sbi->raw_super->encrypt_pw_salt, 0, 16);
+		unlock_buffer(sbi->raw_super_buf);
 		return err;
 	}
 got_it:
-- 
2.4.9 (Apple Git-60)


------------------------------------------------------------------------------
