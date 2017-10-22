From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid using timespec
Date: Sun, 22 Oct 2017 22:55:35 +0800
Message-ID: <05cd8aef-c68d-c47e-3dc5-5a13f515347a@kernel.org>
References: <20171019095252.688181-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171019095252.688181-1-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: Eric Biggers <ebiggers@google.com>, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Deepa Dinamani <deepa.kernel@gmail.com>, linux-fsdevel@vger.kernel.org, DongOh Shin <doscode.kr@gmail.com>, Tomohiro Kusumi <tkusumi@tuxera.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/10/19 17:52, Arnd Bergmann wrote:
> All uses of timespec are deprecated, and this one is not particularly
> useful, as the documented method for converting seconds to jiffies
> is to multiply by 'HZ'.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/f2fs.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4b4a72f392be..b9a4a5db426c 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1178,8 +1178,7 @@ static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
>  
>  static inline bool f2fs_time_over(struct f2fs_sb_info *sbi, int type)
>  {
> -	struct timespec ts = {sbi->interval_time[type], 0};
> -	unsigned long interval = timespec_to_jiffies(&ts);
> +	unsigned long interval = sbi->interval_time[type] * HZ;
>  
>  	return time_after(jiffies, sbi->last_time[type] + interval);
>  }
> 
