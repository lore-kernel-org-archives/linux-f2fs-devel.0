From: He YunLei <heyunlei@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: check only data or node for summary
Date: Wed, 6 Jul 2016 12:09:12 +0800
Message-ID: <577C8468.3060503@huawei.com>
References: <20160610210107.74181-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20160610210107.74181-1-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Bintian <bintian.wang@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2016/6/11 5:01, Jaegeuk Kim wrote:
> We can check data or node types only for gc, since we allocate different type of
> data/node blocks in a different logs occasionally.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/gc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index e1d274c..c2c4ac3 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -806,7 +806,8 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>   		f2fs_put_page(sum_page, 0);
>
>   		sum = page_address(sum_page);
> -		f2fs_bug_on(sbi, type != GET_SUM_TYPE((&sum->footer)));
> +		f2fs_bug_on(sbi, IS_DATASEG(type) !=
> +				IS_DATASEG(GET_SUM_TYPE((&sum->footer))));

Hi, Kim
	type has been transformed into SUM_TYPE_DATA or SUM_TYPE_NODE, so here
no need to do this.

Thanks
>
>   		/*
>   		 * this is to avoid deadlock:
>

