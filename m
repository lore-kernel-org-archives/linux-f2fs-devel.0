From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: retry to revoke atomic commit in -ENOMEM case
Date: Fri, 11 Aug 2017 09:12:02 +0800
Message-ID: <cbab44fc-e3bb-5579-d15d-07fa8af2bad8@huawei.com>
References: <20170808110908.108562-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170808110908.108562-1-yuchao0@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Ping,

On 2017/8/8 19:09, Chao Yu wrote:
> During atomic committing, if we encounter -ENOMEM in revoke path, it's
> better to give a chance to retry revoking.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/segment.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 45fb53411032..682ae68b9ef7 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -213,9 +213,15 @@ static int __revoke_inmem_pages(struct inode *inode,
>  			struct node_info ni;
>  
>  			trace_f2fs_commit_inmem_page(page, INMEM_REVOKE);
> -
> +retry:
>  			set_new_dnode(&dn, inode, NULL, NULL, 0);
> -			if (get_dnode_of_data(&dn, page->index, LOOKUP_NODE)) {
> +			err = get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
> +			if (err) {
> +				if (err == -ENOMEM) {
> +					congestion_wait(BLK_RW_ASYNC, HZ/50);
> +					cond_resched();
> +					goto retry;
> +				}
>  				err = -EAGAIN;
>  				goto next;
>  			}
> 
