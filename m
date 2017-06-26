From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: report # of free inodes more
 precisely
Date: Mon, 26 Jun 2017 18:52:39 +0800
Message-ID: <2d091ab2-cf3a-5185-99d1-59c606c9b9dc@huawei.com>
References: <20170624162522.48931-1-jaegeuk@kernel.org>
 <20170624162522.48931-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20170624162522.48931-2-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2017/6/25 0:25, Jaegeuk Kim wrote:
> If the partition is small, we don't need to report total # of inodes including
> hidden free nodes.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/super.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 8e39b850bfc0..3da6fb276f8b 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -680,6 +680,7 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>  	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
>  	block_t total_count, user_block_count, start_count, ovp_count;
> +	u64 avail_node_count;
>  
>  	total_count = le64_to_cpu(sbi->raw_super->block_count);
>  	user_block_count = sbi->user_block_count;
> @@ -692,9 +693,16 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
>  	buf->f_bavail = user_block_count - valid_user_blocks(sbi);
>  
> -	buf->f_files = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
> -	buf->f_ffree = min(buf->f_files - valid_node_count(sbi),
> -							buf->f_bavail);
> +	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
> +
> +	if (avail_node_count > user_block_count) {
> +		buf->f_files = user_block_count;
> +		buf->f_ffree = buf->f_bavail;

f_ffree is limited both by remained free nid count and free block count, so it
needs to change like this?

if (avail_node_count > user_block_count)
	avail_node_count = user_block_count;

buf->f_files = avail_node_count;
buf->f_ffree = min(avail_node_count - valid_node_count(sbi),
					buf->f_bavail);

Thanks,

> +	} else {
> +		buf->f_files = avail_node_count;
> +		buf->f_ffree = min(avail_node_count - valid_node_count(sbi),
> +					buf->f_bavail);
> +	}
>  
>  	buf->f_namelen = F2FS_NAME_LEN;
>  	buf->f_fsid.val[0] = (u32)id;
> 
