From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [RFC] f2fs: fix a race condition between evict & gc
Date: Mon, 16 May 2016 23:10:13 +0800
Message-ID: <7ab55f84-5ad7-8986-12a3-0e9c8c96e54e@kernel.org>
References: <1463395221-109622-1-git-send-email-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463395221-109622-1-git-send-email-houpengyang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hou Pengyang <houpengyang@huawei.com>, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Pengyang,

On 2016/5/16 18:40, Hou Pengyang wrote:
> When collecting data segment(gc_data_segment), there is a race condition
> between evict and phases of gc:
> 0) ra_node_page(dnode)
> 1) ra_node_page(inode)
> 		<--- evict the inode
> 2) f2fs_iget get the inode and add it to gc_list 
> 3) move_data_page
> 
> In step 2), f2fs_iget does NOT find the inode and allocs a new inode as result,

If inode was unlinked and then be evicted, f2fs_iget should fail when reading
inode's page as blkaddr of this node is null.
If inode still have non-zero nlink value and then be evicted, we should allow gc
thread to reference this inode for moving its data pages.

Thanks,

> which is not resonable.
> 
> This patch changes f2fs_iget to ilookup. when no inode is found, no new inode is
> created.
> 
> Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
> ---
>  fs/f2fs/gc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 38d56f6..6e73193 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -717,8 +717,8 @@ next_step:
>  		ofs_in_node = le16_to_cpu(entry->ofs_in_node);
>  
>  		if (phase == 2) {
> -			inode = f2fs_iget(sb, dni.ino);
> -			if (IS_ERR(inode) || is_bad_inode(inode))
> +			inode = ilookup(sb, dni.ino);
> +			if (!inode || IS_ERR(inode) || is_bad_inode(inode))
>  				continue;
>  
>  			/* if encrypted inode, let's go phase 3 */
> 
