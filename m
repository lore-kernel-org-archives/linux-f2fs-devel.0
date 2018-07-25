From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix 32-bit format string warning
Date: Wed, 25 Jul 2018 23:21:02 +0800
Message-ID: <08f5d7dd-a271-4cef-4cf3-950c4c251c91@kernel.org>
References: <20180724093509.1637386-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724093509.1637386-1-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/7/24 17:34, Arnd Bergmann wrote:
> On 32-bit targets, size_t is often 'unsigned int', so printing it as %lu
> causes a warning:
> 
> fs/f2fs/inode.c: In function 'sanity_check_inode':
> fs/f2fs/inode.c:247:4: error: format '%lu' expects argument of type 'long unsigned int', but argument 7 has type 'unsigned int' [-Werror=format=]
> 
> The correct format string is %zu.
> 
> Fixes: ba3a252d3367 ("f2fs: fix to do sanity check with i_extra_isize")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I noticed the issue, thank you for fixing it, but original buggy patch has not
been upstreamed yet, how about merging this fix into origial patch, if you don't
mind?

Thanks,

> ---
>  fs/f2fs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 3fe63b0c7325..4fd339fd3ff2 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -245,7 +245,7 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>  		set_sbi_flag(sbi, SBI_NEED_FSCK);
>  		f2fs_msg(sbi->sb, KERN_WARNING,
>  			"%s: inode (ino=%lx) has corrupted i_extra_isize: %d, "
> -			"max: %lu",
> +			"max: %zu",
>  			__func__, inode->i_ino, fi->i_extra_isize,
>  			F2FS_TOTAL_EXTRA_ATTR_SIZE);
>  		return false;
> 
