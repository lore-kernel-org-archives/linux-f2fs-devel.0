From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/2] Ask git to ignore the generated
 sg_write_buffer executable
Date: Mon, 20 Aug 2018 15:21:09 +0800
Message-ID: <53b935aa-1c0e-1968-b966-5f16de969e90@huawei.com>
References: <20180820030407.13225-1-tytso@mit.edu>
 <20180820030407.13225-2-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1freVA-0001E8-Me
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 20 Aug 2018 07:21:24 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1freV8-005kb8-Lf
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 20 Aug 2018 07:21:24 +0000
In-Reply-To: <20180820030407.13225-2-tytso@mit.edu>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Theodore Ts'o <tytso@mit.edu>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi Ted,

That has already been fixed in f2fs-utils, you can find the path in below link. :)

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/commit/?h=dev-test&id=5180253fb40c8955e9541a3620264180cbbf280a

https://lkml.org/lkml/2018/5/30/71

Thanks,

On 2018/8/20 11:04, Theodore Ts'o wrote:
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index d5ca55d..3f04e85 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -50,6 +50,7 @@ stamp-h1
>  /tools/fibmap.f2fs
>  /tools/parse.f2fs
>  /tools/f2fscrypt
> +/tools/sg_write_buffer/sg_write_buffer
>  
>  # cscope files
>  cscope.*
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
