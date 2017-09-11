From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs-tools: add cscope files to .gitignore
Date: Mon, 11 Sep 2017 18:32:36 +0800
Message-ID: <6cdb53fb-6139-4a5c-d422-6620e4db56bc@huawei.com>
References: <1504789755-145944-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1504789755-145944-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/9/7 21:09, Yunlong Song wrote:
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
>  .gitignore | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/.gitignore b/.gitignore
> index abe1336..d5ca55d 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -50,3 +50,7 @@ stamp-h1
>  /tools/fibmap.f2fs
>  /tools/parse.f2fs
>  /tools/f2fscrypt
> +
> +# cscope files
> +cscope.*
> +ncscope.*
> 
