From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 3/3] f2fs: use lock_buffer when changing
	superblock
Date: Wed, 09 Dec 2015 14:10:03 +0800
Message-ID: <015101d13248$58a641e0$09f2c5a0$@samsung.com>
References: <1449528805-89661-1-git-send-email-jaegeuk@kernel.org>
 <1449528805-89661-3-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1449528805-89661-3-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, December 08, 2015 6:53 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 3/3] f2fs: use lock_buffer when changing superblock
> 
> When modifying sb contents, we need to use lock its buffer.

How about applying the rule to _undo_ flow after f2fs_commit_super failed?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index a018ed3..a16dfe9 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1591,7 +1591,9 @@ static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned
> long arg)
>  		return err;
> 
>  	/* update superblock with uuid */
> +	lock_buffer(sbi->raw_super_buf);
>  	generate_random_uuid(sbi->raw_super->encrypt_pw_salt);
> +	unlock_buffer(sbi->raw_super_buf);
> 
>  	err = f2fs_commit_super(sbi, false);
> 
> --
> 2.4.9 (Apple Git-60)
> 
> 
> ------------------------------------------------------------------------------
> Go from Idea to Many App Stores Faster with Intel(R) XDK
> Give your users amazing mobile app experiences with Intel(R) XDK.
> Use one codebase in this all-in-one HTML5 development environment.
> Design, debug & build mobile apps & 2D/3D high-impact games for multiple OSs.
> http://pubads.g.doubleclick.net/gampad/clk?id=254741911&iu=/4140
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
