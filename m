From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: check block reserve strictly a little
 bit
Date: Fri, 10 Nov 2017 11:55:34 -0800
Message-ID: <20171110195534.GA92643@jaegeuk-macbookpro.roam.corp.google.com>
References: <1510048610-17771-1-git-send-email-heyunlei@huawei.com>
 <20171109175527.GB55844@jaegeuk-macbookpro.roam.corp.google.com>
 <42B685BFA705F94C860C6DD0752F0565482C09BB@DGGEMA503-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eDFOx-0000Cz-PU
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Nov 2017 19:55:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eDFOw-0000BQ-Nt
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Nov 2017 19:55:43 +0000
Content-Disposition: inline
In-Reply-To: <42B685BFA705F94C860C6DD0752F0565482C09BB@DGGEMA503-MBX.china.huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: heyunlei <heyunlei@huawei.com>
Cc: "Jianing (Euler)" <ning.jia@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

On 11/10, heyunlei wrote:
> 
> 
> >-----Original Message-----
> >From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> >Sent: Friday, November 10, 2017 1:55 AM
> >To: heyunlei
> >Cc: Yuchao (T); linux-f2fs-devel@lists.sourceforge.net; Wangbintian; Jianing (Euler)
> >Subject: Re: [f2fs-dev][PATCH] f2fs: check block reserve strictly a little bit
> >
> >On 11/07, Yunlei He wrote:
> >> This patch check new block reserve strictly, in case of
> >> garbage data of node page.
> >>
> >> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> >> ---
> >>  fs/f2fs/data.c    |  9 +++++++--
> >>  fs/f2fs/file.c    | 13 +++++--------
> >>  fs/f2fs/segment.c |  1 +
> >>  3 files changed, 13 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >> index b0781ed..3017a87 100644
> >> --- a/fs/f2fs/data.c
> >> +++ b/fs/f2fs/data.c
> >> @@ -558,13 +558,18 @@ int reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count)
> >>
> >>  	f2fs_wait_on_page_writeback(dn->node_page, NODE, true);
> >>
> >> -	for (; count > 0; dn->ofs_in_node++) {
> >> +	for (; count > 0; dn->ofs_in_node++, count--) {
> >>  		block_t blkaddr = datablock_addr(dn->inode,
> >>  					dn->node_page, dn->ofs_in_node);
> >>  		if (blkaddr == NULL_ADDR) {
> >>  			dn->data_blkaddr = NEW_ADDR;
> >>  			__set_data_blkaddr(dn);
> >> -			count--;
> >> +		} else {
> >> +			f2fs_msg(sbi->sb, KERN_ERR, "reserve non NULL block, "
> >> +				"blkaddr:%u, ino:%lu, nid:%u, ofs_in_node:%u",
> >> +				blkaddr, dn->inode->i_ino, dn->nid,
> >> +				dn->ofs_in_node);
> >> +			f2fs_bug_on(sbi, 1);
> >
> >What if there is a hole?
> 
> Hole can hold a non NULL block index? 
> NEW_ADDR may be possible, for the case date block is reserved but without wb
> after new cp.
> How about this?
> 	} else if (blkaddr != NEW_ADDR ){
> 		 	f2fs_msg();
> 	}

No, it is allowed to allocate new blocks in holes. We can give the # of
allocated blocks to caller which can check its intention.

> Thanks. 
> >
> >>  		}
> >>  	}
> >>
> >> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >> index cee0f36..dfc23c2 100644
> >> --- a/fs/f2fs/file.c
> >> +++ b/fs/f2fs/file.c
> >> @@ -1218,19 +1218,16 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
> >>  	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
> >>  	pgoff_t index = start;
> >>  	unsigned int ofs_in_node = dn->ofs_in_node;
> >> -	blkcnt_t count = 0;
> >> -	int ret;
> >> +	int ret = 0;
> >>
> >>  	for (; index < end; index++, dn->ofs_in_node++) {
> >>  		if (datablock_addr(dn->inode, dn->node_page,
> >>  					dn->ofs_in_node) == NULL_ADDR)
> >> -			count++;
> >> -	}
> >> +			ret = reserve_new_blocks(dn, 1);
> >>
> >> -	dn->ofs_in_node = ofs_in_node;
> >> -	ret = reserve_new_blocks(dn, count);
> >> -	if (ret)
> >> -		return ret;
> >> +		if (ret)
> >> +			return ret;
> >> +	}
> >>
> >>  	dn->ofs_in_node = ofs_in_node;
> >>  	for (index = start; index < end; index++, dn->ofs_in_node++) {
> >> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >> index 20722b2..e670967 100644
> >> --- a/fs/f2fs/segment.c
> >> +++ b/fs/f2fs/segment.c
> >> @@ -1815,6 +1815,7 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
> >>  	bool mir_exist;
> >>  #endif
> >>
> >> +	verify_block_addr(sbi, blkaddr);
> >>  	segno = GET_SEGNO(sbi, blkaddr);
> >>
> >>  	se = get_seg_entry(sbi, segno);
> >> --
> >> 1.9.1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
