From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: add boundary check in inline_data_addr
Date: Thu, 13 Jun 2019 15:09:24 +0800
Message-ID: <e54b84ee-39a3-c518-8c9b-192fb9a92d27@huawei.com>
References: <20190612085800.11947-1-huangrandall@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hbJrj-0002MG-0b
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 07:09:43 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hbJre-00Bb8J-KE
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 07:09:40 +0000
In-Reply-To: <20190612085800.11947-1-huangrandall@google.com>
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
To: Randall Huang <huangrandall@google.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hi Randall,

On 2019/6/12 16:58, Randall Huang wrote:
> Add boundary check in case of extra_size is larger
> than sizeof array "i_addr"
> 
> Signed-off-by: Randall Huang <huangrandall@google.com>
> ---
>  fs/f2fs/f2fs.h | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 760390f380b6..17f3858a00c3 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2660,11 +2660,25 @@ static inline bool f2fs_is_drop_cache(struct inode *inode)
>  	return is_inode_flag_set(inode, FI_DROP_CACHE);
>  }
>  
> +#define F2FS_TOTAL_EXTRA_ATTR_SIZE			\
> +	(offsetof(struct f2fs_inode, i_extra_end) -	\
> +	offsetof(struct f2fs_inode, i_extra_isize))	\
> +
>  static inline void *inline_data_addr(struct inode *inode, struct page *page)
>  {
>  	struct f2fs_inode *ri = F2FS_INODE(page);
>  	int extra_size = get_extra_isize(inode);
>  
> +	if (extra_size < 0 || extra_size > F2FS_TOTAL_EXTRA_ATTR_SIZE ||
> +		extra_size % sizeof(__le32)) {
> +		f2fs_msg(F2FS_I_SB(inode)->sb, KERN_ERR,
> +			"%s: inode (ino=%lx) has corrupted i_extra_isize: %d, "
> +			"max: %zu",
> +			__func__, inode->i_ino, extra_size,
> +			F2FS_TOTAL_EXTRA_ATTR_SIZE);
> +		extra_size = 0;
> +	}

Oh, we have already did the sanity check on .i_extra_isize field in
sanity_check_inode(), why can it be changed after that? bit-transition of cache
or memory overflow?

Thanks,

> +
>  	return (void *)&(ri->i_addr[extra_size + DEF_INLINE_RESERVED_SIZE]);
>  }
>  
> @@ -2817,10 +2831,6 @@ static inline int get_inline_xattr_addrs(struct inode *inode)
>  	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
>  	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
>  
> -#define F2FS_TOTAL_EXTRA_ATTR_SIZE			\
> -	(offsetof(struct f2fs_inode, i_extra_end) -	\
> -	offsetof(struct f2fs_inode, i_extra_isize))	\
> -
>  #define F2FS_OLD_ATTRIBUTE_SIZE	(offsetof(struct f2fs_inode, i_addr))
>  #define F2FS_FITS_IN_INODE(f2fs_inode, extra_isize, field)		\
>  		((offsetof(typeof(*(f2fs_inode)), field) +	\
> 
