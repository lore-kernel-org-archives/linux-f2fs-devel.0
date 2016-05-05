From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 11/11] f2fs: retry to truncate blocks in
 -ENOMEM case
Date: Wed, 4 May 2016 19:59:15 -0700
Message-ID: <20160505025915.GA72618@jaegeuk.gateway>
References: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
 <1462299708-67906-11-git-send-email-jaegeuk@kernel.org>
 <572AA92F.8090802@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <572AA92F.8090802@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Hou Pengyang <houpengyang@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, wangbintian 00221568 <bintian.wang@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

On Thu, May 05, 2016 at 10:00:15AM +0800, Hou Pengyang wrote:
> On 2016/5/4 2:21, Jaegeuk Kim wrote:
> >This patch modifies to retry truncating node blocks in -ENOMEM case.
> >
> Hi, Kim. in this patch, I think there is NO chance to retry for -ENOMEM.
> 
> This is because if exist_written_data returns false, we can confirm that
> this inode has been released from orphan radix-tree:
> f2fs_evict_inode
>  ---> remove_inode_page
>     ---> truncate_node
>         ---> remove_orphan_inode
> On this condition, err is 0, So it won't enter:
> if (err && err != -ENOENT)
> {
>     ...
> }
> sequentially, there is no chance to truncate node blocks again.
> I miss something else?

When I initially tested fault injection, I could hit that before.
But, now I can't hit this again. :(
It seems it was gone while I updated the error flow before.
Agreed with you, and let me take your change.

BTW, I even suspect whether this leaking condition happens or not.
If f2fs_evict_inode deals with inode deletion, that inode should be an orphan
one. So, we don't need to consider that condition actually.

So, I wrote this patch as well.
I started stress tests again. :)

Thanks,

>From 8c1e4e5ca23410b8f55bbc75d64f75416d486739 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Wed, 4 May 2016 19:48:53 -0700
Subject: [PATCH] f2fs: don't worry about inode leak in evict_inode

Even if an inode failed to release its blocks, it should be kept in an orphan
inode list, so it will be released later.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index baf3a2a..689d691 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -377,20 +377,8 @@ no_delete:
 		alloc_nid_failed(sbi, inode->i_ino);
 		clear_inode_flag(fi, FI_FREE_NID);
 	}
-
-	if (err && err != -ENOENT) {
-		if (!exist_written_data(sbi, inode->i_ino, ORPHAN_INO)) {
-			/*
-			 * get here because we failed to release resource
-			 * of inode previously, reminder our user to run fsck
-			 * for fixing.
-			 */
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
-			f2fs_msg(sbi->sb, KERN_WARNING,
-				"inode (ino:%lu) resource leak, run fsck "
-				"to fix this issue!", inode->i_ino);
-		}
-	}
+	f2fs_bug_on(sbi, err &&
+		!exist_written_data(sbi, inode->i_ino, ORPHAN_INO));
 out_clear:
 	fscrypt_put_encryption_info(inode, NULL);
 	clear_inode(inode);
-- 
2.6.3

> 
> How about this patch?
> 
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -345,6 +345,7 @@ void f2fs_evict_inode(struct inode *inode)
>         set_inode_flag(fi, FI_NO_ALLOC);
>         i_size_write(inode, 0);
> 
> +retry:
>         if (F2FS_HAS_BLOCKS(inode))
>                 err = f2fs_truncate(inode, true);
> 
> @@ -354,6 +355,11 @@ void f2fs_evict_inode(struct inode *inode)
>                 f2fs_unlock_op(sbi);
>         }
> 
> +       if (err == -ENOMEM) {
> +               err = 0;
> +               goto retry;
> +       }
> +
>         sb_end_intwrite(inode->i_sb);
>  no_delete:
>         stat_dec_inline_xattr(inode);
> >Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >---
> >  fs/f2fs/inode.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> >diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> >index f4ac851..5cccd7a 100644
> >--- a/fs/f2fs/inode.c
> >+++ b/fs/f2fs/inode.c
> >@@ -344,7 +344,7 @@ void f2fs_evict_inode(struct inode *inode)
> >  	sb_start_intwrite(inode->i_sb);
> >  	set_inode_flag(fi, FI_NO_ALLOC);
> >  	i_size_write(inode, 0);
> >-
> >+retry:
> >  	if (F2FS_HAS_BLOCKS(inode))
> >  		err = f2fs_truncate(inode, true);
> >
> >@@ -374,6 +374,11 @@ no_delete:
> >
> >  	if (err && err != -ENOENT) {
> >  		if (!exist_written_data(sbi, inode->i_ino, ORPHAN_INO)) {
> >+			/* give more chances, if ENOMEM case */
> >+			if (err == -ENOMEM) {
> >+				err = 0;
> >+				goto retry;
> >+			}
> >  			/*
> >  			 * get here because we failed to release resource
> >  			 * of inode previously, reminder our user to run fsck
> >
> 
