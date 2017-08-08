From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: use IPU for cold files
Date: Tue, 8 Aug 2017 10:57:56 +0800
Message-ID: <d51293ed-a497-d6fa-4309-7ef8d6b45cd8@huawei.com>
References: <20170808014222.31097-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170808014222.31097-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/8/8 9:42, Jaegeuk Kim wrote:
> We expect cold files write data sequentially, but sometimes some of small data
> can be updated, which incurs fragmentation.
> Let's avoid that.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/segment.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 6b871b492fd5..7f700e54b77d 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -577,6 +577,10 @@ static inline bool need_inplace_update_policy(struct inode *inode,
>  	if (test_opt(sbi, LFS))
>  		return false;
>  
> +	/* if this is cold file, we should overwrite to avoid fragmentation */
> +	if (file_is_cold(inode))
> +		return true;
> +
>  	if (policy & (0x1 << F2FS_IPU_FORCE))
>  		return true;
>  	if (policy & (0x1 << F2FS_IPU_SSR) && need_SSR(sbi))
> 
