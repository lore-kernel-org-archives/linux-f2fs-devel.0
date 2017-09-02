From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: avoid needless inode updates
Date: Fri, 1 Sep 2017 18:05:24 -0700
Message-ID: <20170902010524.GA23704@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170902000516.21080-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1dnwsO-0000z6-Lt
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 02 Sep 2017 01:05:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dnwsM-0006DY-Ne
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 02 Sep 2017 01:05:32 +0000
Content-Disposition: inline
In-Reply-To: <20170902000516.21080-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Please ignore this patch.

Thanks,

On 09/01, Jaegeuk Kim wrote:
> If i_size wan't change at all, we don't need to write inode during fsync.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4b993961d81d..0d76b572484a 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2267,11 +2267,11 @@ static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
>  		spin_unlock(&sbi->inode_lock[DIRTY_META]);
>  		return ret;
>  	}
> -	if (!is_inode_flag_set(inode, FI_AUTO_RECOVER) ||
> -			file_keep_isize(inode) ||
> -			i_size_read(inode) & PAGE_MASK)
> -		return false;
> -	return F2FS_I(inode)->last_disk_size == i_size_read(inode);
> +	if (F2FS_I(inode)->last_disk_size == i_size_read(inode))
> +		return true;
> +
> +	return is_inode_flag_set(inode, FI_AUTO_RECOVER) &&
> +		!file_keep_isize(inode) && !(i_size_read(inode) & PAGE_MASK);
>  }
>  
>  static inline int f2fs_readonly(struct super_block *sb)
> -- 
> 2.14.0.rc1.383.gd1ce394fe2-goog

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
