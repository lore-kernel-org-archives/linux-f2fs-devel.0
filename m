From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] fsck.f2fs: do not print content beyond
 sb->version
Date: Thu, 7 Jun 2018 18:53:48 +0800
Message-ID: <70bd1c39-6f90-8afd-84a9-28bfa167e787@huawei.com>
References: <20180606143924.154725-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fQsYa-0006YS-C9
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 Jun 2018 10:54:16 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fQsYY-00HSHn-9e
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 Jun 2018 10:54:16 +0000
In-Reply-To: <20180606143924.154725-1-zhengjunling@huawei.com>
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
To: Junling Zheng <zhengjunling@huawei.com>, jaegeuk@kernel.org
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/6/6 22:39, Junling Zheng wrote:
> Currently, versions in f2fs_configuration have one more byte than
> those in sb, so versions in sb may not end with '\0', and then
> print_raw_sb_info() will print something beyond sb->version.
> 
> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
> ---
>  fsck/mount.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 0a30adb..9def919 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -341,7 +341,10 @@ void print_raw_sb_info(struct f2fs_super_block *sb)
>  	DISP_u32(sb, node_ino);
>  	DISP_u32(sb, meta_ino);
>  	DISP_u32(sb, cp_payload);
> -	DISP("%s", sb, version);
> +	if (sb->version[255] != '\0')
> +		DISP("%-.256s", sb, version);
> +	else
> +		DISP("%s", sb, version);

IMO, DISP("%-.256s", sb, version) is enough.

Thanks,

>  	printf("\n");
>  }
>  
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
