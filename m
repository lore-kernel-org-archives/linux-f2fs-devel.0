From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: add fault injection on f2fs_truncate
Date: Fri, 10 Mar 2017 09:16:22 +0800
Message-ID: <e8e1c2b6-90d1-9e24-0942-7887a7914a8c@huawei.com>
References: <20170309232827.9304-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170309232827.9304-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

At a glance, it needs to add one more entry in fault_name as well. :)

Thanks,

On 2017/3/10 7:28, Jaegeuk Kim wrote:
> Inject a fault during f2fs_truncate().
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 1 +
>  fs/f2fs/file.c | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 870bb4d9bc65..7edb3bea15a4 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -50,6 +50,7 @@ enum {
>  	FAULT_BLOCK,
>  	FAULT_DIR_DEPTH,
>  	FAULT_EVICT_INODE,
> +	FAULT_TRUNCATE,
>  	FAULT_IO,
>  	FAULT_CHECKPOINT,
>  	FAULT_MAX,
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 0110c263a705..4ec764ea89bd 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -620,6 +620,12 @@ int f2fs_truncate(struct inode *inode)
>  
>  	trace_f2fs_truncate(inode);
>  
> +#ifdef CONFIG_F2FS_FAULT_INJECTION
> +	if (time_to_inject(F2FS_I_SB(inode), FAULT_TRUNCATE)) {
> +		f2fs_show_injection_info(FAULT_TRUNCATE);
> +		return -EIO;
> +	}
> +#endif
>  	/* we should check inline_data size */
>  	if (!f2fs_may_inline_data(inode)) {
>  		err = f2fs_convert_inline_inode(inode);
> 
