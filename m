From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2 7/7] f2fs: should check the remaining dentry bits
Date: Mon, 25 Apr 2016 19:53:06 -0700
Message-ID: <20160426025306.GA18242@jaegeuk.gateway>
References: <1461629220-16280-1-git-send-email-jaegeuk@kernel.org>
 <1461629220-16280-7-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461629220-16280-7-git-send-email-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: He YunLei <heyunlei@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Change log from v1:
 o remove wron f2fs_bug_on()

>From 545c0c9055b0d8dc5d134d9340b3cd80eeecdafa Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 25 Apr 2016 14:24:44 -0700
Subject: [PATCH] f2fs: should check the remaining dentry bits

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
 fs/f2fs/dir.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index e90380d..0ad7b9a 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -100,12 +100,6 @@ static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
 		*res_page = dentry_page;
 	else
 		kunmap(dentry_page);
-
-	/*
-	 * For the most part, it should be a bug when name_len is zero.
-	 * We stop here for figuring out where the bugs has occurred.
-	 */
-	f2fs_bug_on(F2FS_P_SB(dentry_page), d.max < 0);
 	return de;
 }
 
@@ -149,9 +143,9 @@ struct f2fs_dir_entry *find_target_dentry(struct fscrypt_name *fname,
 
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

