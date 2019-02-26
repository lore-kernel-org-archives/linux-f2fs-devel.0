From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v3] f2fs: fix to data block override node
 segment by mistake
Date: Tue, 26 Feb 2019 09:48:22 -0800
Message-ID: <20190226174822.GA59048@jaegeuk-macbookpro.roam.corp.google.com>
References: <6e7453cd-683d-e596-de40-4b4a459353df@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gygqt-00026Z-04
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 Feb 2019 17:49:17 +0000
Received: from [198.145.29.99] (helo=mail.kernel.org)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gygqC-009jqm-Uo
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 Feb 2019 17:49:10 +0000
Content-Disposition: inline
In-Reply-To: <6e7453cd-683d-e596-de40-4b4a459353df@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: zhengliang <zhengliang6@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 02/25, zhengliang wrote:
> v2->v3: It describe the problem scenario more accurately.
> 
> TASK A              TASK kworker                                                 TASK B                                                   TASK C
> 
> open
> write
> close
>                     f2fs_write_data_pages
>                       f2fs_write_cache_pages
>                         f2fs_outplace_write_data
>                           f2fs_allocate_data_block (get block in seg S,
>                                                     S is full, and only
>                                                     have this valid data
>                                                     block)
>                             allocate_segment
>                             locate_dirty_segment (mark S as PRE)
>                           f2fs_submit_page_write (submit but is not
>                                                   written on dev)
> unlink
>   iput_final
>     f2fs_drop_inode
>       f2fs_truncate
>   (not evict)
>                                                                              write_checkpoint
>                                                                                flush merged bio but not wait file data writeback
>                                                                                set_prefree_as_free (mark S as FREE)
>                                                                                                                                     update NODE/DATA
>                                                                                                                                     allocate_segment (select S)
>                        writeback done

Patch was broken?
