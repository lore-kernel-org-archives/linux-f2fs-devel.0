From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: don't need to update inode checksum
 for recovery
Date: Mon, 4 Sep 2017 09:26:12 +0800
Message-ID: <74132304-3604-c9b6-b618-7cc5ea7d6a49@huawei.com>
References: <20170901172511.7045-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170901172511.7045-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/9/2 1:25, Jaegeuk Kim wrote:
> This patch fixes "f2fs: support inode checksum".
> The recovered inode page will be rewritten with valid checksum.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
>  fs/f2fs/node.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 2654c9166fba..388a00262a5f 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2287,8 +2287,6 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
>  			F2FS_FITS_IN_INODE(src, le16_to_cpu(src->i_extra_isize),
>  								i_projid))
>  			dst->i_projid = src->i_projid;
> -
> -		f2fs_inode_chksum_set(sbi, ipage);
>  	}
>  
>  	new_ni = old_ni;
> 
