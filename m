From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 4/5] f2fs: support data flush in ioctl
Date: Thu, 24 Dec 2015 13:06:41 -0800
Message-ID: <20151224210641.GC43846@jaegeuk.local>
References: <016701d13e33$676f0bc0$364d2340$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aCD61-0007ZD-LJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Dec 2015 21:06:49 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aCD60-00081x-Md for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Dec 2015 21:06:49 +0000
Content-Disposition: inline
In-Reply-To: <016701d13e33$676f0bc0$364d2340$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Thu, Dec 24, 2015 at 06:10:25PM +0800, Chao Yu wrote:
> Sometimes user want to sync all data belong to superblock into storage
> for persistence, 'syncfs' syscall is one option, still f2fs supports
> similar one through ioctl, difference is that sb releted kworker is
> online for writebacking concurrently.

There is compatibility issue, since you're trying to change pre-defined
ioctl; it needs to change F2FS_IOC_WRITE_CHECKPOINT too, right?
I'm in doubt that we really need to expose this too.

Thanks,

> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/file.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index a60d088..91997a5 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1621,6 +1621,7 @@ static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct cp_control cpc;
>  	int err;
> +	int flush_data;
>  
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
> @@ -1628,6 +1629,15 @@ static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
>  	if (f2fs_readonly(sbi->sb))
>  		return -EROFS;
>  
> +	if (get_user(flush_data, (__u32 __user *)arg))
> +		return -EFAULT;
> +
> +	if (flush_data) {
> +		err = sync_dirty_inodes(sbi, FILE_INODE);
> +		if (err)
> +			return err;
> +	}
> +
>  	cpc.reason = __get_cp_reason(sbi);
>  
>  	mutex_lock(&sbi->gc_mutex);
> -- 
> 2.6.3
> 

------------------------------------------------------------------------------
