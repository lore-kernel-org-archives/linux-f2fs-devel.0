From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: enable inline data by default
Date: Fri, 20 Mar 2015 13:41:19 -0700
Message-ID: <20150320204119.GB19413@jaegeuk-mac02.mot.com>
References: <1426741895-7647-1-git-send-email-wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YZ3jW-0000J1-3E
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 20 Mar 2015 20:41:30 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YZ3jU-0007yx-QX for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 20 Mar 2015 20:41:30 +0000
Content-Disposition: inline
In-Reply-To: <1426741895-7647-1-git-send-email-wanpeng.li@linux.intel.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Wanpeng Li <wanpeng.li@linux.intel.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Wanpeng,

Indeed.
Please don't do this for backward compatibility.

Thanks,

On Thu, Mar 19, 2015 at 01:11:35PM +0800, Wanpeng Li wrote:
> Enable inline_data feature by default since it brings us better 
> performance and space utilization and now has already stable.
> 
> Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
> ---
>  Documentation/filesystems/f2fs.txt |  2 --
>  fs/f2fs/f2fs.h                     | 11 +++++------
>  fs/f2fs/inline.c                   |  3 ---
>  fs/f2fs/super.c                    |  7 -------
>  4 files changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
> index 48e2123..6c9c947 100644
> --- a/Documentation/filesystems/f2fs.txt
> +++ b/Documentation/filesystems/f2fs.txt
> @@ -122,8 +122,6 @@ active_logs=%u         Support configuring the number of active logs. In the
>  disable_ext_identify   Disable the extension list configured by mkfs, so f2fs
>                         does not aware of cold files such as media files.
>  inline_xattr           Enable the inline xattrs feature.
> -inline_data            Enable the inline data feature: New created small(<~3.4k)
> -                       files can be written into inode block.
>  inline_dentry          Enable the inline dir feature: data in new created
>                         directory entries can be written into inode block. The
>                         space of inode block which is used to store inline
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f2909c6..5849520 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -45,12 +45,11 @@
>  #define F2FS_MOUNT_POSIX_ACL		0x00000020
>  #define F2FS_MOUNT_DISABLE_EXT_IDENTIFY	0x00000040
>  #define F2FS_MOUNT_INLINE_XATTR		0x00000080
> -#define F2FS_MOUNT_INLINE_DATA		0x00000100
> -#define F2FS_MOUNT_INLINE_DENTRY	0x00000200
> -#define F2FS_MOUNT_FLUSH_MERGE		0x00000400
> -#define F2FS_MOUNT_NOBARRIER		0x00000800
> -#define F2FS_MOUNT_FASTBOOT		0x00001000
> -#define F2FS_MOUNT_EXTENT_CACHE		0x00002000
> +#define F2FS_MOUNT_INLINE_DENTRY	0x00000100
> +#define F2FS_MOUNT_FLUSH_MERGE		0x00000200
> +#define F2FS_MOUNT_NOBARRIER		0x00000400
> +#define F2FS_MOUNT_FASTBOOT		0x00000800
> +#define F2FS_MOUNT_EXTENT_CACHE		0x00001000
>  
>  #define clear_opt(sbi, option)	(sbi->mount_opt.opt &= ~F2FS_MOUNT_##option)
>  #define set_opt(sbi, option)	(sbi->mount_opt.opt |= F2FS_MOUNT_##option)
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index d3e0599..d67bc0d 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -15,9 +15,6 @@
>  
>  bool f2fs_may_inline(struct inode *inode)
>  {
> -	if (!test_opt(F2FS_I_SB(inode), INLINE_DATA))
> -		return false;
> -
>  	if (f2fs_is_atomic_file(inode))
>  		return false;
>  
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index fc6857f..f008222 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -52,7 +52,6 @@ enum {
>  	Opt_active_logs,
>  	Opt_disable_ext_identify,
>  	Opt_inline_xattr,
> -	Opt_inline_data,
>  	Opt_inline_dentry,
>  	Opt_flush_merge,
>  	Opt_nobarrier,
> @@ -74,7 +73,6 @@ static match_table_t f2fs_tokens = {
>  	{Opt_active_logs, "active_logs=%u"},
>  	{Opt_disable_ext_identify, "disable_ext_identify"},
>  	{Opt_inline_xattr, "inline_xattr"},
> -	{Opt_inline_data, "inline_data"},
>  	{Opt_inline_dentry, "inline_dentry"},
>  	{Opt_flush_merge, "flush_merge"},
>  	{Opt_nobarrier, "nobarrier"},
> @@ -354,9 +352,6 @@ static int parse_options(struct super_block *sb, char *options)
>  		case Opt_disable_ext_identify:
>  			set_opt(sbi, DISABLE_EXT_IDENTIFY);
>  			break;
> -		case Opt_inline_data:
> -			set_opt(sbi, INLINE_DATA);
> -			break;
>  		case Opt_inline_dentry:
>  			set_opt(sbi, INLINE_DENTRY);
>  			break;
> @@ -594,8 +589,6 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  #endif
>  	if (test_opt(sbi, DISABLE_EXT_IDENTIFY))
>  		seq_puts(seq, ",disable_ext_identify");
> -	if (test_opt(sbi, INLINE_DATA))
> -		seq_puts(seq, ",inline_data");
>  	if (test_opt(sbi, INLINE_DENTRY))
>  		seq_puts(seq, ",inline_dentry");
>  	if (!f2fs_readonly(sbi->sb) && test_opt(sbi, FLUSH_MERGE))
> -- 
> 2.1.0

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
