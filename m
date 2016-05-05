From: Hou Pengyang <houpengyang@huawei.com>
Subject: Re: [PATCH 11/11] f2fs: retry to truncate blocks in
 -ENOMEM case
Date: Thu, 5 May 2016 10:00:15 +0800
Message-ID: <572AA92F.8090802@huawei.com>
References: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
	<1462299708-67906-11-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1ay8aq-0001M8-8h
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 May 2016 02:00:44 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ay8ak-0004d3-Ru
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 May 2016 02:00:44 +0000
In-Reply-To: <1462299708-67906-11-git-send-email-jaegeuk@kernel.org>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2016/5/4 2:21, Jaegeuk Kim wrote:
> This patch modifies to retry truncating node blocks in -ENOMEM case.
>
Hi, Kim. in this patch, I think there is NO chance to retry for -ENOMEM.

This is because if exist_written_data returns false, we can confirm that
this inode has been released from orphan radix-tree:
f2fs_evict_inode
  ---> remove_inode_page
     ---> truncate_node
         ---> remove_orphan_inode
On this condition, err is 0, So it won't enter:
if (err && err != -ENOENT)
{
     ...
}
sequentially, there is no chance to truncate node blocks again.
I miss something else?

How about this patch?

--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -345,6 +345,7 @@ void f2fs_evict_inode(struct inode *inode)
         set_inode_flag(fi, FI_NO_ALLOC);
         i_size_write(inode, 0);

+retry:
         if (F2FS_HAS_BLOCKS(inode))
                 err = f2fs_truncate(inode, true);

@@ -354,6 +355,11 @@ void f2fs_evict_inode(struct inode *inode)
                 f2fs_unlock_op(sbi);
         }

+       if (err == -ENOMEM) {
+               err = 0;
+               goto retry;
+       }
+
         sb_end_intwrite(inode->i_sb);
  no_delete:
         stat_dec_inline_xattr(inode);
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/inode.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index f4ac851..5cccd7a 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -344,7 +344,7 @@ void f2fs_evict_inode(struct inode *inode)
>   	sb_start_intwrite(inode->i_sb);
>   	set_inode_flag(fi, FI_NO_ALLOC);
>   	i_size_write(inode, 0);
> -
> +retry:
>   	if (F2FS_HAS_BLOCKS(inode))
>   		err = f2fs_truncate(inode, true);
>
> @@ -374,6 +374,11 @@ no_delete:
>
>   	if (err && err != -ENOENT) {
>   		if (!exist_written_data(sbi, inode->i_ino, ORPHAN_INO)) {
> +			/* give more chances, if ENOMEM case */
> +			if (err == -ENOMEM) {
> +				err = 0;
> +				goto retry;
> +			}
>   			/*
>   			 * get here because we failed to release resource
>   			 * of inode previously, reminder our user to run fsck
>



------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
