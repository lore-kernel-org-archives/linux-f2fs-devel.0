From: zhengliang <zhengliang6@huawei.com>
Subject: [PATCH v3] f2fs: fix to data block override node segment
 by mistake
Date: Mon, 25 Feb 2019 19:49:37 +0800
Message-ID: <6e7453cd-683d-e596-de40-4b4a459353df@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengliang6@huawei.com>) id 1gyEm2-0005E8-5h
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Feb 2019 11:50:18 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gyElz-006Ywb-HF
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Feb 2019 11:50:18 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

v2->v3: It describe the problem scenario more accurately.

TASK A              TASK kworker                                                 TASK B                                                   TASK C

open
write
close
                    f2fs_write_data_pages
                      f2fs_write_cache_pages
                        f2fs_outplace_write_data
                          f2fs_allocate_data_block (get block in seg S,
                                                    S is full, and only
                                                    have this valid data
                                                    block)
                            allocate_segment
                            locate_dirty_segment (mark S as PRE)
                          f2fs_submit_page_write (submit but is not
                                                  written on dev)
unlink
  iput_final
    f2fs_drop_inode
      f2fs_truncate
  (not evict)
                                                                             write_checkpoint
                                                                               flush merged bio but not wait file data writeback
                                                                               set_prefree_as_free (mark S as FREE)
                                                                                                                                    update NODE/DATA
                                                                                                                                    allocate_segment (select S)
                       writeback done
