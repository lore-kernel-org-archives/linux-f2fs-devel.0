From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH V2 7/7] fsverity: Remove filesystem specific
 build config option
Date: Tue, 4 Dec 2018 16:08:32 -0800
Message-ID: <20181205000831.GI70682@gmail.com>
References: <20181204095650.12562-1-chandan@linux.vnet.ibm.com>
 <20181204095650.12562-8-chandan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1gUKk5-0001cn-E1
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Dec 2018 00:08:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gUKk3-004rzG-R4
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Dec 2018 00:08:41 +0000
Content-Disposition: inline
In-Reply-To: <20181204095650.12562-8-chandan@linux.vnet.ibm.com>
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
Cc: linux-mips@linux-mips.org, linux-doc@vger.kernel.org, jhogan@kernel.org, heiko.carstens@de.ibm.com, linux-mtd@lists.infradead.org, deanbo422@gmail.com, linux-s390@vger.kernel.org, corbet@lwn.net, richard@nod.at, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, green.hu@gmail.com, jaegeuk@kernel.org, tytso@mit.edu, dedekind1@gmail.com, adrian.hunter@intel.com, ralf@linux-mips.org, linux-f2fs-devel@lists.sourceforge.net, paul.burton@mips.com, schwidefsky@de.ibm.com, adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk

Hi Chandan,

On Tue, Dec 04, 2018 at 03:26:50PM +0530, Chandan Rajendra wrote:
> In order to have a common code base for fsverity "post read" processing
> for all filesystems which support fsverity, this commit removes
> filesystem specific build config option (e.g. CONFIG_EXT4_FS_VERITY)
> and replaces it with a build option (i.e. CONFIG_FS_VERITY) whose
> value affects all the filesystems making use of fsverity.
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> ---
>  Documentation/filesystems/fsverity.rst |  4 ++--
>  fs/ext4/Kconfig                        | 20 --------------------
>  fs/ext4/ext4.h                         |  2 --
>  fs/ext4/readpage.c                     |  4 ++--
>  fs/ext4/super.c                        |  6 +++---
>  fs/ext4/sysfs.c                        |  4 ++--
>  fs/f2fs/Kconfig                        | 20 --------------------
>  fs/f2fs/data.c                         |  2 +-
>  fs/f2fs/f2fs.h                         |  2 --
>  fs/f2fs/super.c                        |  6 +++---
>  fs/f2fs/sysfs.c                        |  4 ++--
>  fs/verity/Kconfig                      |  3 ++-
>  include/linux/fs.h                     |  4 ++--
>  include/linux/fsverity.h               |  3 +--
>  14 files changed, 20 insertions(+), 64 deletions(-)
> 
[...]
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index c30c4f6ed411..f37132c640ee 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -19,8 +19,7 @@ struct fsverity_operations {
>  	int (*get_metadata_end)(struct inode *inode, loff_t *metadata_end_ret);
>  };
>  
> -#if __FS_HAS_VERITY
> -
> +#ifdef CONFIG_FS_VERITY
>  /* ioctl.c */
>  extern int fsverity_ioctl_enable(struct file *filp, const void __user *arg);
>  extern int fsverity_ioctl_measure(struct file *filp, void __user *arg);
> -- 
> 2.19.1
> 

Can you grep for __FS_HAS_VERITY?  It's still mentioned twice in comments for
this #ifdef (these should be changed to CONFIG_FS_VERITY), and it's still
defined in fs/verity/fsverity_private.h (that one should be removed).

Thanks,

- Eric
