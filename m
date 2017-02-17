From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: fix the case when there is no free segment to
 allocate for CURSEG_WARM_NODE
Date: Fri, 17 Feb 2017 10:39:33 -0800
Message-ID: <20170217183933.GB2951@jaegeuk.local>
References: <1487335987-32601-1-git-send-email-yunlong.song@huawei.com>
 <1487335987-32601-3-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487335987-32601-3-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>
Cc: cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, miaoxie@huawei.com, zhouxiyu@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Yunlong,

I already started to test this since a couple of days ago. :)

http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=908b5f463c82eaf972b149a26bb310f5e25064fd

Thanks,

On 02/17, Yunlong Song wrote:
> If the free segments are used up, then new_curseg will fail for
> CURSEG_WARM_NODE, in this case, we should use change_curseg instead of
> new_curseg.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/segment.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index df2ff5c..32820cd 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1564,8 +1564,6 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
>  
>  	if (force)
>  		new_curseg(sbi, type, true);
> -	else if (type == CURSEG_WARM_NODE)
> -		new_curseg(sbi, type, false);
>  	else if (curseg->alloc_type == LFS && is_next_segment_free(sbi, type))
>  		new_curseg(sbi, type, false);
>  	else if (need_SSR(sbi) && get_ssr_segment(sbi, type))
> -- 
> 1.8.5.2
