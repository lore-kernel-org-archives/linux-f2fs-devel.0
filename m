From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: direct I/O -> buffered I/O for
 FI_NO_PREALLOC & FI_INLINE_DATA
Date: Thu, 28 Sep 2017 22:23:23 +0800
Message-ID: <8802c6e5-2e60-12a1-5792-2782d8310d77@kernel.org>
References: <20170928214729.144483-1-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1dxfHL-0003Hp-1D
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Sep 2017 20:19:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dxfHI-0005EY-Ra
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Sep 2017 20:19:26 +0000
In-Reply-To: <20170928214729.144483-1-guoweichao@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: guoweichao@huawei.com, jaegeuk@kernel.org
Cc: heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2017/9/29 5:47, guoweichao@huawei.com wrote:
> From: Weichao Guo <guoweichao@huawei.com>
> 
> In FI_NO_PREALLOC cases, direct I/O path may allocate blocks for an inode but
> keep its inline data flag. This inconsistency may trigger vfs clear_inode
> nrpages bug_on when evicting the inode. Let buffered I/O handle this case.

Good catch!

Could we just convert inline data by force in f2fs_preallocate_blocks for this
case? it can avoid write fallback from direct IO to buffered IO.

Thanks,


> 
> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
> ---
>  fs/f2fs/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 36b5352..039f6d8 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -822,7 +822,7 @@ static int __allocate_data_block(struct dnode_of_data *dn)
>  
>  static inline bool __force_buffered_io(struct inode *inode, int rw)
>  {
> -	return (f2fs_encrypted_file(inode) ||
> +	return (f2fs_encrypted_file(inode) || f2fs_has_inline_data(inode) ||
>  			(rw == WRITE && test_opt(F2FS_I_SB(inode), LFS)) ||
>  			F2FS_I_SB(inode)->s_ndevs);
>  }
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
