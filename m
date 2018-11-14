From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: avoid GC causing encrypted file
 corrupted
Date: Wed, 14 Nov 2018 13:54:39 -0800
Message-ID: <20181114215439.GA45824@jaegeuk-macbookpro.roam.corp.google.com>
References: <1537274393-78441-1-git-send-email-yunlong.song@huawei.com>
 <19e63fa7-1a48-c1de-eef5-cde242e8300d@kernel.org>
 <5c3d6053-e03a-8c61-0a07-07d0090ba349@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gN37a-0002VR-Sb
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 14 Nov 2018 21:54:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gN37Z-003V4m-9w
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 14 Nov 2018 21:54:50 +0000
Content-Disposition: inline
In-Reply-To: <5c3d6053-e03a-8c61-0a07-07d0090ba349@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: yunlong.song@icloud.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, miaoxie@huawei.com

On 11/13, Chao Yu wrote:
> Jaegeuk,
> 
> On 2018/9/18 21:21, Chao Yu wrote:
> > On 2018/9/18 20:39, Yunlong Song wrote:
> >> The encrypted file may be corrupted by GC in following case:
> >>
> >> Time 1: | segment 1 blkaddr = A |  GC -> | segment 2 blkaddr = B |
> >> Encrypted block 1 is moved from blkaddr A of segment 1 to blkaddr B of
> >> segment 2,
> >>
> >> Time 2: | segment 1 blkaddr = B |  GC -> | segment 3 blkaddr = C |
> >>
> >> Before page 1 is written back and if segment 2 become a victim, then
> >> page 1 is moved from blkaddr B of segment 2 to blkaddr Cof segment 3,
> >> during the GC process of Time 2, f2fs should wait for page 1 written back
> >> before reading it, or move_data_block will read a garbage block from
> >> blkaddr B since page is not written back to blkaddr B yet.
> >>
> >> Commit 6aa58d8a ("f2fs: readahead encrypted block during GC") introduce
> >> ra_data_block to read encrypted block, but it forgets to add
> >> f2fs_wait_on_page_writeback to avoid racing between GC and flush.
> >>
> >> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> > 
> > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> I've reviewed this patch, could you add missing tag in the patch located in
> dev-test branch?

Sorry, done.

> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> > .
> > 
