From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: Add a segment type check in inplace
 write
Date: Wed, 28 Mar 2018 09:59:08 +0800
Message-ID: <f763e375-0838-e3e4-7db8-13a5915ebbbf@huawei.com>
References: <1522056743-7126-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f10N8-0003zL-IF
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Mar 2018 01:59:30 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f10N6-00AjSE-5X
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Mar 2018 01:59:30 +0000
In-Reply-To: <1522056743-7126-1-git-send-email-heyunlei@huawei.com>
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
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/3/26 17:32, Yunlei He wrote:
> This patch add a segment type check in IPU, in
> case of something wrong with blkadd in dnode.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/segment.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index f61c77b..c55942c 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2790,10 +2790,15 @@ void write_data_page(struct dnode_of_data *dn, struct f2fs_io_info *fio)
>  int rewrite_data_page(struct f2fs_io_info *fio)
>  {
>  	int err;
> +	struct f2fs_sb_info *sbi = fio->sbi;
>  
>  	fio->new_blkaddr = fio->old_blkaddr;
>  	/* i/o temperature is needed for passing down write hints */
>  	__get_segment_type(fio);
> +
> +	f2fs_bug_on(sbi, !IS_DATASEG(get_seg_entry(sbi,
> +			GET_SEGNO(sbi, fio->new_blkaddr))->type));
> +
>  	stat_inc_inplace_blocks(fio->sbi);
>  
>  	err = f2fs_submit_page_bio(fio);
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
