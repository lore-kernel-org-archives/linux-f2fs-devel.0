From: Junling Zheng <zhengjunling@huawei.com>
Subject: Re: [PATCH] fsck.f2fs: do not print content beyond
 sb->version
Date: Wed, 6 Jun 2018 22:45:32 +0800
Message-ID: <b7418e83-6391-ac1c-cace-3c117599acac@huawei.com>
References: <20180606143924.154725-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1fQZhF-0002ny-C5
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Jun 2018 14:45:57 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fQZhD-00DIit-Mc
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Jun 2018 14:45:57 +0000
In-Reply-To: <20180606143924.154725-1-zhengjunling@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Actually, I prefer to fix this bug by unifying the length of versions in
f2fs_configuration and f2fs_super_block :)

Reference: https://sourceforge.net/p/linux-f2fs/mailman/message/35398537/

Thanks

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
>  	printf("\n");
>  }
>  
> 



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
