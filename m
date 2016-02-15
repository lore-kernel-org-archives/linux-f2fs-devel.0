From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 5/7] f2fs crypto: set up encryption info for new
 inodes in f2fs_inherit_context()
Date: Mon, 15 Feb 2016 17:03:51 +0800
Message-ID: <013601d167cf$e3e37180$abaa5480$@samsung.com>
References: <00fe01d16716$5ec0a540$1c41efc0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <00fe01d16716$5ec0a540$1c41efc0$@samsung.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

Please ignore this patch because it incurs deadlock as below:

 bit_wait_io+0x1f/0x60
 __wait_on_bit_lock+0x5c/0xb0
 __lock_page+0xba/0xd0
 pagecache_get_page+0x187/0x230
 __get_node_page+0x7d/0x200 [f2fs]
 get_node_page+0x12/0x20 [f2fs]
 read_all_xattrs+0x213/0x330 [f2fs]
 f2fs_getxattr+0x86/0x140 [f2fs]
 _f2fs_get_encryption_info+0xb4/0x4d0 [f2fs]
 f2fs_inherit_context+0xf8/0x100 [f2fs]
 init_inode_metadata+0xb3/0x410 [f2fs]
 __f2fs_add_link+0x2e1/0x650 [f2fs]
 f2fs_mkdir+0xdb/0x180 [f2fs]
 vfs_mkdir+0xe5/0x160
 SyS_mkdirat+0xb8/0xf0
 SyS_mkdir+0x19/0x20
 entry_SYSCALL_64_fastpath+0x12/0x6f

Thanks,

> -----Original Message-----
> From: Chao Yu [mailto:chao2.yu@samsung.com]
> Sent: Sunday, February 14, 2016 6:56 PM
> To: Jaegeuk Kim
> Cc: tytso@mit.edu; linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH 5/7] f2fs crypto: set up encryption info for new inodes in
> f2fs_inherit_context()
> 
> This patch syncs f2fs with commit 555570295532 ("ext4 crypto: set up
> encryption info for new inodes in ext4_inherit_context()") from ext4.
> 
> Set up the encryption information for newly created inodes immediately
> after they inherit their encryption context from their parent
> directories.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/crypto_policy.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/crypto_policy.c b/fs/f2fs/crypto_policy.c
> index d4a96af..0fb08b0 100644
> --- a/fs/f2fs/crypto_policy.c
> +++ b/fs/f2fs/crypto_policy.c
> @@ -203,7 +203,10 @@ int f2fs_inherit_context(struct inode *parent, struct inode *child,
>  			F2FS_KEY_DESCRIPTOR_SIZE);
> 
>  	get_random_bytes(ctx.nonce, F2FS_KEY_DERIVATION_NONCE_SIZE);
> -	return f2fs_setxattr(child, F2FS_XATTR_INDEX_ENCRYPTION,
> +	res = f2fs_setxattr(child, F2FS_XATTR_INDEX_ENCRYPTION,
>  				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT, &ctx,
>  				sizeof(ctx), ipage, XATTR_CREATE);
> +	if (!res)
> +		res = f2fs_get_encryption_info(child);
> +	return res;
>  }
> --
> 2.7.0.2.g1b0b6dd
> 
> 
> 
> ------------------------------------------------------------------------------
> Site24x7 APM Insight: Get Deep Visibility into Application Performance
> APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
> Monitor end-to-end web transactions and take corrective actions now
> Troubleshoot faster and improve end-user experience. Signup Now!
> http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
