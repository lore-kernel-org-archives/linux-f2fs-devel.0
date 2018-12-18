From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix missing unlock(sbi->gc_mutex)
Date: Tue, 18 Dec 2018 18:33:36 +0800
Message-ID: <8a552929-17cc-eb0b-f4e6-5a94a1735d83@huawei.com>
References: <20181218021530.78323-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181218021530.78323-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/12/18 10:15, Jaegeuk Kim wrote:
> This fixes missing unlock call.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/super.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index b79677639108..2689a2cb56cc 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1462,6 +1462,9 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>  
>  	while (!f2fs_time_over(sbi, DISABLE_TIME)) {
>  		err = f2fs_gc(sbi, true, false, NULL_SEGNO);
> +
> +		/* f2fs_gc guarantees unlock gc_mutex */

How about:

	while () {
		mutex_lock(&sbi->gc_mutex);
		err = f2fs_gc();
		if (err) {
			handle error cases..
		}
	}

Thanks,

> +		mutex_lock(&sbi->gc_mutex);
>  		if (err == -ENODATA)
>  			break;
>  		if (err && err != -EAGAIN) {
> 
