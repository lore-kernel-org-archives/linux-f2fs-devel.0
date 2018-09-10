From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: submit bio after shutdown
Date: Mon, 10 Sep 2018 22:15:46 +0800
Message-ID: <42844d87-587c-1fd6-e2f7-ade84007882e@kernel.org>
References: <20180907212804.91462-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180907212804.91462-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/9/8 5:28, Jaegeuk Kim wrote:
> Sometimes, some merged IOs could get a chance to be submitted, resulting in
> system hang in shutdown test. This issues IOs all the time after shutdown.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/data.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 8c204f896c22..26f38b224bb2 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -533,6 +533,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>  	if (fio->in_list)
>  		goto next;
>  out:
> +	if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN))
> +		__submit_merged_bio(io);
>  	up_write(&io->io_rwsem);
>  }
>  
> 
