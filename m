From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs-tools: the overprovision should be 0 as default
Date: Mon, 14 Aug 2017 20:24:25 -0700
Message-ID: <20170815032425.GB91145@jaegeuk-macbookpro.roam.corp.google.com>
References: <1502457915-46935-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502457915-46935-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>
Cc: chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 08/11, Yunlong Song wrote:
> The usage message gives a wrong number, so fix it.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  mkfs/f2fs_format_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
> index a3652a9..6712b5c 100644
> --- a/mkfs/f2fs_format_main.c
> +++ b/mkfs/f2fs_format_main.c
> @@ -41,7 +41,7 @@ static void mkfs_usage()
>  	MSG(0, "  -f force overwrite the exist filesystem\n");
>  	MSG(0, "  -l label\n");
>  	MSG(0, "  -m support zoned block device [default:0]\n");
> -	MSG(0, "  -o overprovision ratio [default:5]\n");
> +	MSG(0, "  -o overprovision ratio [default:0]\n");

We need to remove [default:xx], since the default is not fixed?

>  	MSG(0, "  -O [feature list] e.g. \"encrypt\"\n");
>  	MSG(0, "  -q quiet mode\n");
>  	MSG(0, "  -s # of segments per section [default:1]\n");
> -- 
> 1.8.5.2
