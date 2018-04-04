From: Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v10 00/62] Convert page cache to XArray
Date: Wed, 4 Apr 2018 09:35:46 -0700
Message-ID: <ff6a317f-920b-62c7-9a7a-9bf235371d41@oracle.com>
References: <20180330034245.10462-1-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <mike.kravetz@oracle.com>) id 1f3lOg-0008N8-TF
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Apr 2018 16:36:30 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f3lOf-00BvNb-3P
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Apr 2018 16:36:30 +0000
In-Reply-To: <20180330034245.10462-1-willy@infradead.org>
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
To: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc: linux-nilfs@vger.kernel.org, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>, Matthew Wilcox <mawilcox@microsoft.com>, James Simmons <jsimmons@infradead.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Andreas Dilger <andreas.dilger@intel.com>, Nicholas Piggin <npiggin@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, Oleg Drokin <oleg.drokin@intel.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Lukas Czerner <lczerner@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Christoph Hellwig <hch@lst.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>

On 03/29/2018 08:41 PM, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> I'd like to thank Andrew for taking the first eight XArray patches
> into -next.  He's understandably nervous about taking the rest of the
> patches into -next given how few of the remaining patches have review
> tags on them.  So ... if you're on the cc, I'd really appreciate a review
> on something that you feel somewhat responsible for, eg the particular
> filesystem (nilfs, f2fs, lustre) that I've touched, or something in the
> mm/ or fs/ directories that you've worked on recently.
> 
> This is against next-20180329.
> 

I applied this series to next-20180329 and booted in a debug environment.
My root fs is ext4, and next-20180329 had the first (bad) fix in bug
https://bugzilla.kernel.org/show_bug.cgi?id=199185
so, I had to apply the revised fix.

Running with this XArray series on top of next-20180329 consistently 'hangs'
on shutdown looping (?forever?) in tag_pages_for_writeback/xas_for_each_tag.
All I have to do is make sure there is some activity on the ext4 fs before
shutdown.  Not sure if this is a 'next-20180329' issue or XArray issue.
But the fact that we are looping in xas_for_each_tag looks suspicious.

#0  xas_find_chunk (tag=<optimized out>, advance=<optimized out>, 
    xas=<optimized out>) at ./include/linux/xarray.h:886
#1  xas_next_tag (tag=<optimized out>, max=<optimized out>, 
    xas=<optimized out>) at ./include/linux/xarray.h:915
#2  tag_pages_for_writeback (mapping=<optimized out>, start=<optimized out>, 
    end=2251799813685247) at mm/page-writeback.c:2109
#3  0xffffffff812eccf0 in ext4_writepages (mapping=0xffff88012bf9b918, 
    wbc=<optimized out>) at fs/ext4/inode.c:2793
#4  0xffffffff811bbe4b in do_writepages (mapping=0xffffc90001727a28, 
    wbc=0xffffffffffffffff) at mm/page-writeback.c:2332
#5  0xffffffff812743bd in __writeback_single_inode (inode=0xffffc90001727a28, 
    wbc=0xffffc90001727cc0) at fs/fs-writeback.c:1315
#6  0xffffffff81274aaf in writeback_sb_inodes (sb=0xffff88012e2e2e98, 
    wb=0xffff88012c02e000, work=0xffff88012c4aae18) at fs/fs-writeback.c:1579
#7  0xffffffff81274ff7 in wb_writeback (wb=0xffff88012c02e000, 
    work=0xffff88012c4aae18) at fs/fs-writeback.c:1755
#8  0xffffffff812757df in wb_do_writeback (wb=<optimized out>)
    at fs/fs-writeback.c:1900
#9  wb_workfn (work=0xffffc90001727a28) at fs/fs-writeback.c:1941
#10 0xffffffff810b7415 in process_one_work (worker=0xffff88012eff6d68, 
    work=0xffff88012c02e190) at kernel/workqueue.c:2145
#11 0xffffffff810b762e in worker_thread (__worker=0xffff88012eff6d68)
    at kernel/workqueue.c:2279
#12 0xffffffff810bd7c3 in kthread (_create=0xffff88012e88fc28)
    at kernel/kthread.c:238
#13 0xffffffff81a00205 in ret_from_fork () at arch/x86/entry/entry_64.S:411
#14 0x0000000000000000 in ?? ()

-- 
Mike Kravetz

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
