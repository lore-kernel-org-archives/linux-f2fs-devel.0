From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/2] f2fs: fix to release inode correctly
Date: Wed, 26 Aug 2015 20:46:11 +0800
Message-ID: <002a01d0dffd$48366a30$d8a33e90$@samsung.com>
References: <001b01d0de51$0b369c70$21a3d550$@samsung.com>
 <20150824165423.GC2837@jaegeuk-mac02.mot-mobility.com>
 <20150824225105.GA8056@jaegeuk-mac02.mot.com>
 <000001d0df00$bd37d010$37a77030$@samsung.com>
 <20150825224025.GC12070@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150825224025.GC12070@jaegeuk-mac02.mot.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, August 26, 2015 6:40 AM
> To: Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: fix to release inode correctly
> 
> On Tue, Aug 25, 2015 at 02:38:00PM +0800, Chao Yu wrote:
> > Hi Jaegeuk,
> >
> > > -----Original Message-----
> > > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > > Sent: Tuesday, August 25, 2015 6:53 AM
> > > To: Chao Yu
> > > Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> > > Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: fix to release inode correctly
> > >
> > > Hi Chao,
> > >
> > > On Mon, Aug 24, 2015 at 09:54:23AM -0700, Jaegeuk Kim wrote:
> > > > On Mon, Aug 24, 2015 at 05:40:45PM +0800, Chao Yu wrote:
> > > > > In following call stack, if unfortunately we lose all chances to truncate
> > > > > inode page in remove_inode_page, eventually we will add the nid allocated
> > > > > previously into free nid cache, this nid is with NID_NEW status and with
> > > > > NEW_ADDR in its blkaddr pointer:
> > > > >
> > > > >  - f2fs_create
> > > > >   - f2fs_add_link
> > > > >    - __f2fs_add_link
> > > > >     - init_inode_metadata
> > > > >      - new_inode_page
> > > > >       - new_node_page
> > > > >        - set_node_addr(, NEW_ADDR)
> > > > >      - f2fs_init_acl   failed
> > > > >      - remove_inode_page  failed
> > > > >   - handle_failed_inode
> > > > >    - remove_inode_page  failed
> > > > >    - iput
> > > > >     - f2fs_evict_inode
> > > > >      - remove_inode_page  failed
> > > > >      - alloc_nid_failed   cache a nid with valid blkaddr: NEW_ADDR
> > >
> > > Unfortunately, this couldn't fix my bug case.
> >
> > Another thing I note is that: we do not cover free_nid_list_lock with build_lock,
> > so when we are building free nid cache, we can change the status of free nid
> > cache, so I guess it is one possible suspect who cause our nid issue.
> 
> But, when building the free nids, it doesn't add any candidate if there is
> an existing entry in the list which might be set as NID_ALLOC.
> 
> >
> > And, could you share me the information for reproducing the nid reallocation
> > issue? So I can reproduce in my environment for invistigating.
> 
> Sure. I've running ubuntu on virtualbox equipped with an 8GB virtual partition
> with 1GB main memory.
> The issue occurs during sometimes xfstests, or sometimes fsstress which fills up
> the partition to 100%.
> With my quick fix, I couldn't meet that bug for two days run.

Thank you for the hint, :) I'm trying to reproduce the issue.

Thanks,
