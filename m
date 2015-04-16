From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 1/3] f2fs: flush symlink path to avoid broken
	symlink after POR
Date: Thu, 16 Apr 2015 18:33:29 +0800
Message-ID: <000001d07830$e0787b60$a1697220$@samsung.com>
References: <1429169445-18306-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1429169445-18306-1-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Thursday, April 16, 2015 3:31 PM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 1/3] f2fs: flush symlink path to avoid broken symlink after POR
> 
> This patch tries to avoid broken symlink case after POR in best effort.
> This results in performance regression.
> But, if f2fs has inline_data and the target path is under 3KB-sized long,
> the page would be stored in its inode_block, so that there would be no
> performance regression.
> 
> Note that, if user wants to keep this file atomically, it needs to trigger
> dir->fsync.
> And, there is still a hole to produce broken symlink.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/namei.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 8055e30..5d990d8 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -324,6 +324,17 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
>  	d_instantiate(dentry, inode);
>  	unlock_new_inode(inode);
> 
> +	/*
> +	 * Let's flush symlink data in order to avoid broken symlink as much as
> +	 * possible. Nevertheless, fsyncing is the best way, but there is no
> +	 * way to get a file descriptor in order to flush that.
> +	 *
> +	 * Note that, it needs to do dir->fsync to make this recoverable.
> +	 * If the symlink path is stored into inline_data, there is no
> +	 * performance regression.
> +	 */
> +	filemap_write_and_wait_range(inode->i_mapping, 0, symlen);

One minor thing.

filemap_write_and_wait_range(inode->i_mapping, 0, symlen - 1);

Because we don't need to write out data exceed isize here.

Thanks,

> +
>  	if (IS_DIRSYNC(dir))
>  		f2fs_sync_fs(sbi->sb, 1);
>  	return err;
> --
> 2.1.1
> 
> 
> ------------------------------------------------------------------------------
> BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
> Develop your own process in accordance with the BPMN 2 standard
> Learn Process modeling best practices with Bonita BPM through live exercises
> http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
> source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

