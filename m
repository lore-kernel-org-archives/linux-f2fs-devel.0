From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/3] f2fs: guarantee node/meta inode number won't be
 reused
Date: Sun, 8 Mar 2015 20:52:42 -0700
Message-ID: <20150309035242.GB4472@jaegeuk-mac02>
References: <1425870055-27694-1-git-send-email-wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425870055-27694-1-git-send-email-wanpeng.li@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wanpeng Li <wanpeng.li@linux.intel.com>
Cc: Changman Lee <cm224.lee@samsung.com>, Chao Yu <chao2.yu@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Wanpeng,

On Mon, Mar 09, 2015 at 11:00:53AM +0800, Wanpeng Li wrote:
> Node/Meta inode numbers are also should not be reused, this patch
> guarantee it.

We don't need to do this, since the mkfs.f2fs assigns block addresses as 1
for node and meta nids in their nat entries.
So, this should not happen.
Otherwise, we should fix any bugs in nat operations.

Thanks,

> 
> Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
> ---
>  fs/f2fs/node.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 4687eae..1a7e925 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1421,7 +1421,7 @@ static int add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
>  		return -1;
>  
>  	/* 0 nid should not be used */
> -	if (unlikely(nid == 0))
> +	if (unlikely(nid == 0 || nid == 1 || nid == 2))
>  		return 0;
>  
>  	if (build) {
> -- 
> 1.9.1
