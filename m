From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs-tools: fix the usage message of overprovision
 option
Date: Tue, 15 Aug 2017 20:09:52 +0800
Message-ID: <4f0395b6-82a6-e009-0332-f64b197ceb43@huawei.com>
References: <1502457915-46935-1-git-send-email-yunlong.song@huawei.com>
 <1502782917-97779-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502782917-97779-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/8/15 15:41, Yunlong Song wrote:
> The usage message shows a wrong message for ovp option, so fix it.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  mkfs/f2fs_format_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
> index a3652a9..3279829 100644
> --- a/mkfs/f2fs_format_main.c
> +++ b/mkfs/f2fs_format_main.c
> @@ -41,7 +41,7 @@ static void mkfs_usage()
>  	MSG(0, "  -f force overwrite the exist filesystem\n");
>  	MSG(0, "  -l label\n");
>  	MSG(0, "  -m support zoned block device [default:0]\n");
> -	MSG(0, "  -o overprovision ratio [default:5]\n");
> +	MSG(0, "  -o overprovision ratio [initial value 0 lets mkfs determine its best value]\n");

[mkfs decides, the value trends to maximize user visible space]  ?

Thanks,

>  	MSG(0, "  -O [feature list] e.g. \"encrypt\"\n");
>  	MSG(0, "  -q quiet mode\n");
>  	MSG(0, "  -s # of segments per section [default:1]\n");
> 
