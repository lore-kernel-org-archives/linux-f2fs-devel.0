From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] f2fs: fix missing unlock(sbi->gc_mutex)
Date: Thu, 3 Jan 2019 13:54:04 +0300
Message-ID: <20190103105404.GA6197@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <dan.carpenter@oracle.com>) id 1gf0dt-0003Gm-0b
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 03 Jan 2019 10:54:25 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gf0dr-00EZ27-2H
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 03 Jan 2019 10:54:24 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

Hello Jaegeuk Kim,

The patch 8f31b4665c14: "f2fs: fix missing unlock(sbi->gc_mutex)"
from Dec 17, 2018, leads to the following static checker warning:

	fs/f2fs/super.c:1481 f2fs_disable_checkpoint()
	error: double lock 'mutex:&sbi->gc_mutex'

fs/f2fs/super.c
    1456 static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
    1457 {
    1458 	struct cp_control cpc;
    1459 	int err;
    1460 
    1461 	sbi->sb->s_flags |= SB_ACTIVE;
    1462 
    1463 	f2fs_update_time(sbi, DISABLE_TIME);
    1464 
    1465 	while (!f2fs_time_over(sbi, DISABLE_TIME)) {
    1466 		mutex_lock(&sbi->gc_mutex);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^
Lock.

    1467 		err = f2fs_gc(sbi, true, false, NULL_SEGNO);
    1468 		if (err == -ENODATA)
    1469 			break;
    1470 		if (err && err != -EAGAIN)
    1471 			return err;
    1472 	}
    1473 
    1474 	err = sync_filesystem(sbi->sb);
    1475 	if (err)
    1476 		return err;
    1477 
    1478 	if (f2fs_disable_cp_again(sbi))
    1479 		return -EAGAIN;
    1480 
--> 1481 	mutex_lock(&sbi->gc_mutex);
                            ^^^^^^^^^^^^^
Deadlock?

    1482 	cpc.reason = CP_PAUSE;
    1483 	set_sbi_flag(sbi, SBI_CP_DISABLED);
    1484 	f2fs_write_checkpoint(sbi, &cpc);
    1485 
    1486 	sbi->unusable_block_count = 0;
    1487 	mutex_unlock(&sbi->gc_mutex);
    1488 	return 0;
    1489 }

regards,
dan carpenter
