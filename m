From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: add a new mount option "errors_mode"
Date: Wed, 25 Jul 2018 23:16:31 +0800
Message-ID: <f6a0b1c3-4057-8b64-a419-4b2914d48394@kernel.org>
References: <1532418696-9379-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fiLX0-0002ch-9o
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Jul 2018 15:16:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fiLWy-0016zN-8T
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Jul 2018 15:16:50 +0000
In-Reply-To: <1532418696-9379-1-git-send-email-heyunlei@huawei.com>
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
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: zhangdianfang@huawei.com

On 2018/7/24 15:51, Yunlei He wrote:
> This patch add a new mount option "errors_mode" to adjust
> fs disposing cp error policy. Now supports "panic",
> "remount-ro", and "continue".
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  Documentation/filesystems/f2fs.txt |  2 ++
>  fs/f2fs/checkpoint.c               | 11 +++++++++++
>  fs/f2fs/f2fs.h                     |  7 +++++++
>  fs/f2fs/super.c                    | 32 ++++++++++++++++++++++++++++++++
>  4 files changed, 52 insertions(+)
> 
> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
> index 69f8de9..4a3493e 100644
> --- a/Documentation/filesystems/f2fs.txt
> +++ b/Documentation/filesystems/f2fs.txt
> @@ -191,6 +191,8 @@ fsync_mode=%s          Control the policy of fsync. Currently supports "posix",
>                         pass, but the performance will regress. "nobarrier" is
>                         based on "posix", but doesn't issue flush command for
>                         non-atomic files likewise "nobarrier" mount option.
> +errors_mode=%s         Adjust fs disposing cp error policy. Now supports "panic",
> +                       "remount-ro", and "continue".

Could you add more details about these three modes like ext4?

It looks other filesystems allow to set three mode together, how about just
following the rule and option naming?

Thanks,

>  test_dummy_encryption  Enable dummy encryption, which provides a fake fscrypt
>                         context. The fake fscrypt context is used by xfstests.
>  
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 9c29526..36f6146 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -28,8 +28,19 @@
>  
>  void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
>  {
> +	int errors_mode = F2FS_OPTION(sbi).errors_mode;
> +
>  	f2fs_build_fault_attr(sbi, 0);
>  	set_ckpt_flags(sbi, CP_ERROR_FLAG);
> +	if (errors_mode == ERRORS_MODE_PANIC) {
> +		panic("F2FS-fs (device %s): panic forced after error\n",
> +			sbi->sb->s_id);
> +	} else if (errors_mode == ERRORS_MODE_REMOUNT_RO) {
> +		f2fs_msg(sbi->sb, KERN_CRIT,
> +			"Remounting filesystem read-only");
> +		sbi->sb->s_flags |= SB_RDONLY;
> +	}
> +
>  	if (!end_io)
>  		f2fs_flush_merged_writes(sbi);
>  }
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 57a8851..1858cfb 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -133,6 +133,7 @@ struct f2fs_mount_info {
>  	int whint_mode;
>  	int alloc_mode;			/* segment allocation policy */
>  	int fsync_mode;			/* fsync policy */
> +	int errors_mode;		/* fs errors policy */
>  	bool test_dummy_encryption;	/* test dummy encryption */
>  };
>  
> @@ -1104,6 +1105,12 @@ enum fsync_mode {
>  	FSYNC_MODE_NOBARRIER,	/* fsync behaves nobarrier based on posix */
>  };
>  
> +enum errors_mode {
> +	ERRORS_MODE_PANIC,		/* panic if cp error */
> +	ERRORS_MODE_REMOUNT_RO,		/* remount-ro if cp error */
> +	ERRORS_MODE_CONTINUE,		/* continue to run */
> +};
> +
>  #ifdef CONFIG_F2FS_FS_ENCRYPTION
>  #define DUMMY_ENCRYPTION_ENABLED(sbi) \
>  			(unlikely(F2FS_OPTION(sbi).test_dummy_encryption))
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 7187885..feb43d7 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -131,6 +131,7 @@ enum {
>  	Opt_whint,
>  	Opt_alloc,
>  	Opt_fsync,
> +	Opt_errors,
>  	Opt_test_dummy_encryption,
>  	Opt_err,
>  };
> @@ -188,6 +189,7 @@ enum {
>  	{Opt_whint, "whint_mode=%s"},
>  	{Opt_alloc, "alloc_mode=%s"},
>  	{Opt_fsync, "fsync_mode=%s"},
> +	{Opt_errors, "errors_mode=%s"},
>  	{Opt_test_dummy_encryption, "test_dummy_encryption"},
>  	{Opt_err, NULL},
>  };
> @@ -749,6 +751,28 @@ static int parse_options(struct super_block *sb, char *options)
>  			}
>  			kfree(name);
>  			break;
> +		case Opt_errors:
> +			name = match_strdup(&args[0]);
> +			if (!name)
> +				return -ENOMEM;
> +			if (strlen(name) == 5 &&
> +					!strncmp(name, "panic", 5)) {
> +				F2FS_OPTION(sbi).errors_mode =
> +						ERRORS_MODE_PANIC;
> +			} else if (strlen(name) == 10 &&
> +					!strncmp(name, "remount-ro", 10)) {
> +				F2FS_OPTION(sbi).errors_mode =
> +						ERRORS_MODE_REMOUNT_RO;
> +			} else if (strlen(name) == 8 &&
> +					!strncmp(name, "continue", 8)) {
> +				F2FS_OPTION(sbi).errors_mode =
> +						ERRORS_MODE_CONTINUE;
> +			} else {
> +				kfree(name);
> +				return -EINVAL;
> +			}
> +			kfree(name);
> +			break;
>  		case Opt_test_dummy_encryption:
>  #ifdef CONFIG_F2FS_FS_ENCRYPTION
>  			if (!f2fs_sb_has_encrypt(sb)) {
> @@ -1344,6 +1368,13 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  		seq_printf(seq, ",fsync_mode=%s", "strict");
>  	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_NOBARRIER)
>  		seq_printf(seq, ",fsync_mode=%s", "nobarrier");
> +
> +	if (F2FS_OPTION(sbi).errors_mode == ERRORS_MODE_PANIC)
> +		seq_printf(seq, ",errors_mode=%s", "panic");
> +	else if (F2FS_OPTION(sbi).errors_mode == ERRORS_MODE_REMOUNT_RO)
> +		seq_printf(seq, ",errors_mode=%s", "remount-ro");
> +	else if (F2FS_OPTION(sbi).errors_mode == ERRORS_MODE_CONTINUE)
> +		seq_printf(seq, ",errors_mode=%s", "continue");
>  	return 0;
>  }
>  
> @@ -1355,6 +1386,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>  	F2FS_OPTION(sbi).whint_mode = WHINT_MODE_OFF;
>  	F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_DEFAULT;
>  	F2FS_OPTION(sbi).fsync_mode = FSYNC_MODE_POSIX;
> +	F2FS_OPTION(sbi).errors_mode = ERRORS_MODE_CONTINUE;
>  	F2FS_OPTION(sbi).test_dummy_encryption = false;
>  	F2FS_OPTION(sbi).s_resuid = make_kuid(&init_user_ns, F2FS_DEF_RESUID);
>  	F2FS_OPTION(sbi).s_resgid = make_kgid(&init_user_ns, F2FS_DEF_RESGID);
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
