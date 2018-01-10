From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: handle newly created page when revoking inmem pages
Date: Wed, 10 Jan 2018 14:43:19 +0800
Message-ID: <aec4e374-a245-590e-8350-d1e1ada3b705@huawei.com>
References: <CGME20180110024336epcas2p1003559800e7f1e59a79496fc5b79cf04@epcas2p1.samsung.com>
 <1515552234-27964-1-git-send-email-daeho.jeong@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515552234-27964-1-git-send-email-daeho.jeong@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daeho Jeong <daeho.jeong@samsung.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/1/10 10:43, Daeho Jeong wrote:
> When committing inmem pages is successful, we revoke already committed
> blocks in __revoke_inmem_pages() and finally replace the committed
> ones with the old blocks using f2fs_replace_block(). However, if
> the committed block was newly created one, the address of the old
> block is NEW_ADDR and __f2fs_replace_block() cannot handle NEW_ADDR
> as new_blkaddr properly and a kernel panic occurrs.

Good catch!

> 
> Signed-off-by: Daeho Jeong <daeho.jeong@samsung.com>
> Tested-by: Shu Tan <shu.tan@samsung.com>
> ---
>  fs/f2fs/segment.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index c117e09..463f420 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -248,7 +248,11 @@ static int __revoke_inmem_pages(struct inode *inode,
>  				goto next;
>  			}
>  			get_node_info(sbi, dn.nid, &ni);
> -			f2fs_replace_block(sbi, &dn, dn.data_blkaddr,
> +			if (cur->old_addr == NEW_ADDR) {
> +				invalidate_blocks(sbi, dn.data_blkaddr);
> +				f2fs_update_data_blkaddr(&dn, NULL_ADDR);

Original intention here is to recover status to the timing before
committing atomic write. As at that timing blkaddr in dnode should be
cur->old_addr(NEW_ADDR), so we need to change to call:

f2fs_update_data_blkaddr(&dn, NEW_ADDR);

Otherwise, metadata will become inconsistent, because blkaddr value is
NULL_ADDR means that current block is not preallocated, but
total_valid_block_count has already been updated. Right?

Thanks,

> +			} else
> +				f2fs_replace_block(sbi, &dn, dn.data_blkaddr,
>  					cur->old_addr, ni.version, true, true);
>  			f2fs_put_dnode(&dn);
>  		}
> 
