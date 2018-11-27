From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 4/7] Add S_VERITY and IS_VERITY()
Date: Mon, 26 Nov 2018 16:08:38 -0800
Message-ID: <20181127000836.GA11663@gmail.com>
References: <20181119052324.31456-1-chandan@linux.vnet.ibm.com>
 <20181119052324.31456-5-chandan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1gRQvm-0003wW-Ov
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Nov 2018 00:08:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gRQvl-00GWQI-DO
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Nov 2018 00:08:46 +0000
Content-Disposition: inline
In-Reply-To: <20181119052324.31456-5-chandan@linux.vnet.ibm.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc: linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net

Hi Chandan,

On Mon, Nov 19, 2018 at 10:53:21AM +0530, Chandan Rajendra wrote:
> Similar to S_ENCRYPTED/IS_ENCRYPTED(), this commit adds
> S_VERITY/IS_VERITY() to be able to check if a VFS inode has verity
> information associated with it.
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> ---
>  include/linux/fs.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index bcfc40062757..8129617c9718 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1938,6 +1938,7 @@ struct super_operations {
>  #define S_DAX		0	/* Make all the DAX code disappear */
>  #endif
>  #define S_ENCRYPTED	16384	/* Encrypted file (using fs/crypto/) */
> +#define S_VERITY	32768	/* File with fsverity info (using fs/verity) */
>  

The comment for S_VERITY is misleading because IS_VERITY() is used to check
whether the verity bit is set *before* the fsverity_info is created.

Can you change it to just mirror the fscrypt comment?

#define S_VERITY	32768	/* Verity file (using fs/verity/) */

>  /*
>   * Note that nosuid etc flags are inode-specific: setting some file-system
> @@ -1978,6 +1979,7 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
>  #define IS_NOSEC(inode)		((inode)->i_flags & S_NOSEC)
>  #define IS_DAX(inode)		((inode)->i_flags & S_DAX)
>  #define IS_ENCRYPTED(inode)	((inode)->i_flags & S_ENCRYPTED)
> +#define IS_VERITY(inode)	((inode)->i_flags & S_VERITY)
>  
>  #define IS_WHITEOUT(inode)	(S_ISCHR(inode->i_mode) && \
>  				 (inode)->i_rdev == WHITEOUT_DEV)
> -- 
> 2.19.1
> 

Thanks,

- Eric
