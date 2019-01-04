From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [bug report] f2fs: fix missing unlock(sbi->gc_mutex)
Date: Fri, 4 Jan 2019 10:30:15 +0800
Message-ID: <b9eed372-db49-bee1-e43d-b7d62bece0db@huawei.com>
References: <20190103105404.GA6197@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gfFFi-0007cm-Sc
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Jan 2019 02:30:26 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gfFFg-00EEKK-Ed
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Jan 2019 02:30:26 +0000
In-Reply-To: <20190103105404.GA6197@kadam>
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
To: Dan Carpenter <dan.carpenter@oracle.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Dan,

Thanks for the report.

The code logic here is okay, since unlock will be called inside f2fs_gc()
anyway. :)

FYI, the same report in below link from Julia, I've replied once. :)

https://lists.01.org/pipermail/kbuild-all/2018-December/056436.html

Thanks,

On 2019/1/3 18:54, Dan Carpenter wrote:
> Hello Jaegeuk Kim,
> 
> The patch 8f31b4665c14: "f2fs: fix missing unlock(sbi->gc_mutex)"
> from Dec 17, 2018, leads to the following static checker warning:
> 
> 	fs/f2fs/super.c:1481 f2fs_disable_checkpoint()
> 	error: double lock 'mutex:&sbi->gc_mutex'
> 
> fs/f2fs/super.c
>     1456 static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>     1457 {
>     1458 	struct cp_control cpc;
>     1459 	int err;
>     1460 
>     1461 	sbi->sb->s_flags |= SB_ACTIVE;
>     1462 
>     1463 	f2fs_update_time(sbi, DISABLE_TIME);
>     1464 
>     1465 	while (!f2fs_time_over(sbi, DISABLE_TIME)) {
>     1466 		mutex_lock(&sbi->gc_mutex);
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^
> Lock.
> 
>     1467 		err = f2fs_gc(sbi, true, false, NULL_SEGNO);
>     1468 		if (err == -ENODATA)
>     1469 			break;
>     1470 		if (err && err != -EAGAIN)
>     1471 			return err;
>     1472 	}
>     1473 
>     1474 	err = sync_filesystem(sbi->sb);
>     1475 	if (err)
>     1476 		return err;
>     1477 
>     1478 	if (f2fs_disable_cp_again(sbi))
>     1479 		return -EAGAIN;
>     1480 
> --> 1481 	mutex_lock(&sbi->gc_mutex);
>                             ^^^^^^^^^^^^^
> Deadlock?
> 
>     1482 	cpc.reason = CP_PAUSE;
>     1483 	set_sbi_flag(sbi, SBI_CP_DISABLED);
>     1484 	f2fs_write_checkpoint(sbi, &cpc);
>     1485 
>     1486 	sbi->unusable_block_count = 0;
>     1487 	mutex_unlock(&sbi->gc_mutex);
>     1488 	return 0;
>     1489 }
> 
> regards,
> dan carpenter
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
