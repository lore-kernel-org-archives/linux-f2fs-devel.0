From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 01/11] f2fs: add nobarrier mount option
Date: Tue, 29 Jul 2014 19:28:16 +0800
Message-ID: <007d01cfab20$4d5cbc20$e8163460$@samsung.com>
References: <1406328445-63707-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XC5ap-0005Uv-9Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Jul 2014 11:29:19 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XC5an-0008F1-1J
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Jul 2014 11:29:19 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N9H005TS18K2340@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Jul 2014 20:29:09 +0900 (KST)
In-reply-to: <1406328445-63707-1-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Saturday, July 26, 2014 6:47 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 01/11] f2fs: add nobarrier mount option
> 
> This patch adds a mount option, nobarrier, in f2fs.
> The assumption in here is that file system keeps the IO ordering, but
> doesn't care about cache flushes inside the storages.

Looks good to me.
But it's better to add some description in f2fs document.

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

> ---
>  fs/f2fs/data.c    | 5 ++++-
>  fs/f2fs/f2fs.h    | 1 +
>  fs/f2fs/segment.c | 3 +++
>  fs/f2fs/super.c   | 7 +++++++
>  4 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index c77c667..482313d 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -139,7 +139,10 @@ void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
>  	/* change META to META_FLUSH in the checkpoint procedure */
>  	if (type >= META_FLUSH) {
>  		io->fio.type = META_FLUSH;
> -		io->fio.rw = WRITE_FLUSH_FUA | REQ_META | REQ_PRIO;
> +		if (test_opt(sbi, NOBARRIER))
> +			io->fio.rw = WRITE_FLUSH | REQ_META | REQ_PRIO;
> +		else
> +			io->fio.rw = WRITE_FLUSH_FUA | REQ_META | REQ_PRIO;
>  	}
>  	__submit_merged_bio(io);
>  	up_write(&io->io_rwsem);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 8f507d4..e999eec 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -41,6 +41,7 @@
>  #define F2FS_MOUNT_INLINE_XATTR		0x00000080
>  #define F2FS_MOUNT_INLINE_DATA		0x00000100
>  #define F2FS_MOUNT_FLUSH_MERGE		0x00000200
> +#define F2FS_MOUNT_NOBARRIER		0x00000400
> 
>  #define clear_opt(sbi, option)	(sbi->mount_opt.opt &= ~F2FS_MOUNT_##option)
>  #define set_opt(sbi, option)	(sbi->mount_opt.opt |= F2FS_MOUNT_##option)
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 8a6e57d..9fce0f47 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -239,6 +239,9 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
>  	struct flush_cmd_control *fcc = SM_I(sbi)->cmd_control_info;
>  	struct flush_cmd cmd;
> 
> +	if (test_opt(sbi, NOBARRIER))
> +		return 0;
> +
>  	if (!test_opt(sbi, FLUSH_MERGE))
>  		return blkdev_issue_flush(sbi->sb->s_bdev, GFP_KERNEL, NULL);
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 34649aa..eec89a2 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -52,6 +52,7 @@ enum {
>  	Opt_inline_xattr,
>  	Opt_inline_data,
>  	Opt_flush_merge,
> +	Opt_nobarrier,
>  	Opt_err,
>  };
> 
> @@ -69,6 +70,7 @@ static match_table_t f2fs_tokens = {
>  	{Opt_inline_xattr, "inline_xattr"},
>  	{Opt_inline_data, "inline_data"},
>  	{Opt_flush_merge, "flush_merge"},
> +	{Opt_nobarrier, "nobarrier"},
>  	{Opt_err, NULL},
>  };
> 
> @@ -339,6 +341,9 @@ static int parse_options(struct super_block *sb, char *options)
>  		case Opt_flush_merge:
>  			set_opt(sbi, FLUSH_MERGE);
>  			break;
> +		case Opt_nobarrier:
> +			set_opt(sbi, NOBARRIER);
> +			break;
>  		default:
>  			f2fs_msg(sb, KERN_ERR,
>  				"Unrecognized mount option \"%s\" or missing value",
> @@ -544,6 +549,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  		seq_puts(seq, ",inline_data");
>  	if (!f2fs_readonly(sbi->sb) && test_opt(sbi, FLUSH_MERGE))
>  		seq_puts(seq, ",flush_merge");
> +	if (!f2fs_readonly(sbi->sb) && test_opt(sbi, NOBARRIER))
> +		seq_puts(seq, ",nobarrier");
>  	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
> 
>  	return 0;
> --
> 1.8.5.2 (Apple Git-48)
> 
> 
> ------------------------------------------------------------------------------
> Want fast and easy access to all the code in your enterprise? Index and
> search up to 200,000 lines of code with a free copy of Black Duck
> Code Sight - the same software that powers the world's largest code
> search on Ohloh, the Black Duck Open Hub! Try it now.
> http://p.sf.net/sfu/bds
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
