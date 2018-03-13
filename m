From: Sahitya Tummala <stummala@codeaurora.org>
Subject: Re: [PATCH v4] f2fs: support in-memory inode checksum
 when checking consistency
Date: Tue, 13 Mar 2018 15:59:22 +0530
Message-ID: <20180313102922.GB27687@codeaurora.org>
References: <20180307211040.219117-1-guoweichao@huawei.com>
 <20180313084900.GA27687@codeaurora.org>
 <3a0789e6-1499-0538-0e08-b978f77a22f0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <stummala@codeaurora.org>) id 1evhBX-0004pO-Hj
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 13 Mar 2018 10:29:35 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=smtp.codeaurora.org)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1evhBW-009Vec-4R
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 13 Mar 2018 10:29:35 +0000
Content-Disposition: inline
In-Reply-To: <3a0789e6-1499-0538-0e08-b978f77a22f0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: guoweichao <guoweichao@huawei.com>
Cc: jaegeuk@kernel.org, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On Tue, Mar 13, 2018 at 05:19:51PM +0800, guoweichao wrote:
> 
> 
> On 2018/3/13 16:49, Sahitya Tummala wrote:
> > On Thu, Mar 08, 2018 at 05:10:40AM +0800, Weichao Guo wrote:
> >> @@ -159,8 +162,12 @@ bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page)
> >>  	struct f2fs_inode *ri;
> >>  	__u32 provided, calculated;
> >>  
> >> +#ifdef CONFIG_F2FS_CHECK_FS
> >> +	if (!f2fs_enable_inode_chksum(sbi, page))
> >> +#else
> >>  	if (!f2fs_enable_inode_chksum(sbi, page) ||
> >>  			PageDirty(page) || PageWriteback(page))
> > 
> > I see that f2fs_inode_chksum_set() is set only if CONFIG_F2FS_CHECK_FS is
> f2fs_inode_chksum_set is also called in allocate_data_block when fs write back inode to disk.

yes, I got it now. Thanks for providing the clarification.

> > enabled. So in this #else case, if sb has inode checksum enabled but
> > PageDirty() or PageWriteback() is not set, then we may proceed below and do
> So when the inode is read from disk, e.g. PageDirty / PageWriteback is not set,
> the checksum verify process should be ok.
> > the comparison between provided and calculated check sum and it may fail
> > resulting into checksum invalid error?
> > 

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
