From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: no need lock_op in
 f2fs_write_inline_data
Date: Sat, 25 Feb 2017 08:59:34 +0800
Message-ID: <ffdfdb1c-4a33-2d81-7776-2fd001cc85ec@huawei.com>
References: <20170223123120.18842-1-heyunlei@huawei.com>
	<20170223194529.GE2026@jaegeuk.local>
	<0e037d54-9f45-d38b-da91-b5765fa83a62@huawei.com>
	<20170224195837.GE39009@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1chQiJ-0005rZ-Ek
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 00:59:55 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1chQiI-0001xc-7v
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 00:59:55 +0000
In-Reply-To: <20170224195837.GE39009@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, heyunlei <heyunlei@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/2/25 3:58, Jaegeuk Kim wrote:
> On 02/24, heyunlei wrote:
>> Hi Jaegeuk,
>>
>> 	Can you explain more about this? Besides, how about inplace update?
> 
> Oh, sorry. I confused it was the inline_data conversion. ;)
> Yup, we can avoid entire f2fs_lock_op like this. And we can avoid IPU as well,
> but it's quite difficult to detect that.

Seems when there is a large number of dirty inline data in page cache, then
trigger intensively writeback and CP can run out of free space?

Thanks,

> 
>>From 146e4c1ca458b1e33bf7f658f8796a8763e67a4e Mon Sep 17 00:00:00 2001
> From: Yunlei He <heyunlei@huawei.com>
> Date: Thu, 23 Feb 2017 20:31:20 +0800
> Subject: [PATCH] f2fs: no need lock_op in f2fs_write_inline_data
> 
> Similar as f2fs_write_inode, f2fs_write_inline_data just
> mark inode page dirty, so it's no need to write inline data
> under read lock of cp_rwsem.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 80f9863dc4b0..9e51c5e40ce1 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1414,9 +1414,12 @@ static int __write_data_page(struct page *page, bool *submitted,
>  		goto redirty_out;
>  
>  	err = -EAGAIN;
> -	f2fs_lock_op(sbi);
> -	if (f2fs_has_inline_data(inode))
> +	if (f2fs_has_inline_data(inode)) {
>  		err = f2fs_write_inline_data(inode, page);
> +		if (!err)
> +			goto out;
> +	}
> +	f2fs_lock_op(sbi);
>  	if (err == -EAGAIN)
>  		err = do_write_data_page(&fio);
>  	if (F2FS_I(inode)->last_disk_size < psize)
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
