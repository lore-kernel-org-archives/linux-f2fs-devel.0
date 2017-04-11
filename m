From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 4/4] f2fs: avoid frequent checkpoint during f2fs_gc
Date: Tue, 11 Apr 2017 09:42:15 +0800
Message-ID: <af677bdd-bf75-a928-1c4c-541642199b4b@huawei.com>
References: <20170411001308.12881-1-jaegeuk@kernel.org>
 <20170411001308.12881-4-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170411001308.12881-4-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/4/11 8:13, Jaegeuk Kim wrote:
> Now we're doing SSR aggressively more than ever before, so once we reach to
> the reserved_segment, f2fs_balance_fs will call f2fs_gc, which triggers
> checkpoint everytime. We actually must avoid that.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/gc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index e2f9b2b12b74..4a720f3394d9 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -966,7 +966,11 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background)
>  		 * threshold, we can make them free by checkpoint. Then, we
>  		 * secure free segments which doesn't need fggc any more.
>  		 */
> -		ret = write_checkpoint(sbi, &cpc);
> +		if (prefree_segments(sbi)) {
> +			ret = write_checkpoint(sbi, &cpc);
> +			if (ret)
> +				goto stop;
> +		}
>  		if (ret)
>  			goto stop;

We don't need redundant check here?

Otherwise, this patchset looks good to me, anyway please add:

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>  		if (has_not_enough_free_secs(sbi, 0, 0))
> 
