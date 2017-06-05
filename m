From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/4] f2fs: use bio_set_op_attrs
Date: Mon, 5 Jun 2017 03:39:47 -0700
Message-ID: <20170605103947.GA21376@infradead.org>
References: <20170605102909.57625-1-yuchao0@huawei.com>
 <20170605102909.57625-4-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170605102909.57625-4-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Mon, Jun 05, 2017 at 06:29:09PM +0800, Chao Yu wrote:
> Init bio->bi_opf with bio_set_op_attrs instead of opened code.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 2ed90f5db832..204150cf6561 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1962,7 +1962,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
>  			err = PTR_ERR(bio);
>  			goto fail;
>  		}
> -		bio->bi_opf = REQ_OP_READ;
> +		bio_set_op_attrs(bio, REQ_OP_READ, 0);

NAK.  Please read the comment next to bio_set_op_attrs.
