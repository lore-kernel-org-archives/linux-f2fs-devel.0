From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: Fix a return value in case of error in
 'f2fs_fill_super'
Date: Mon, 12 Jun 2017 19:03:17 +0800
Message-ID: <da6d6381-42e4-a99d-89e4-3cba1d628091@huawei.com>
References: <20170611072111.2293-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170611072111.2293-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/6/11 15:21, Christophe JAILLET wrote:
> err must be set to -ENOMEM, otherwise we return 0.
> 
> Fixes: a912b54d3aaa0 ("f2fs: split bio cache")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/super.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 5be27eacea99..38f1624ac5dc 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1976,8 +1976,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  
>  		sbi->write_io[i] = kmalloc(n * sizeof(struct f2fs_bio_info),
>  								GFP_KERNEL);
> -		if (!sbi->write_io[i])
> +		if (!sbi->write_io[i]) {
> +			err = -ENOMEM;
>  			goto free_options;
> +		}
>  
>  		for (j = HOT; j < n; j++) {
>  			init_rwsem(&sbi->write_io[i][j].io_rwsem);
> 
