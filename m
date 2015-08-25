From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 2/2] f2fs: fix to release inode correctly
Date: Tue, 25 Aug 2015 14:38:00 +0800
Message-ID: <000001d0df00$bd37d010$37a77030$@samsung.com>
References: <001b01d0de51$0b369c70$21a3d550$@samsung.com>
	<20150824165423.GC2837@jaegeuk-mac02.mot-mobility.com>
	<20150824225105.GA8056@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZU7tJ-0002Os-1l
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Aug 2015 06:39:29 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZU7tG-0004SX-R5
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Aug 2015 06:39:29 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NTM00D9IL504F90@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Aug 2015 15:39:06 +0900 (KST)
In-reply-to: <20150824225105.GA8056@jaegeuk-mac02.mot.com>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, August 25, 2015 6:53 AM
> To: Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: fix to release inode correctly
> 
> Hi Chao,
> 
> On Mon, Aug 24, 2015 at 09:54:23AM -0700, Jaegeuk Kim wrote:
> > On Mon, Aug 24, 2015 at 05:40:45PM +0800, Chao Yu wrote:
> > > In following call stack, if unfortunately we lose all chances to truncate
> > > inode page in remove_inode_page, eventually we will add the nid allocated
> > > previously into free nid cache, this nid is with NID_NEW status and with
> > > NEW_ADDR in its blkaddr pointer:
> > >
> > >  - f2fs_create
> > >   - f2fs_add_link
> > >    - __f2fs_add_link
> > >     - init_inode_metadata
> > >      - new_inode_page
> > >       - new_node_page
> > >        - set_node_addr(, NEW_ADDR)
> > >      - f2fs_init_acl   failed
> > >      - remove_inode_page  failed
> > >   - handle_failed_inode
> > >    - remove_inode_page  failed
> > >    - iput
> > >     - f2fs_evict_inode
> > >      - remove_inode_page  failed
> > >      - alloc_nid_failed   cache a nid with valid blkaddr: NEW_ADDR
> 
> Unfortunately, this couldn't fix my bug case.

Another thing I note is that: we do not cover free_nid_list_lock with build_lock,
so when we are building free nid cache, we can change the status of free nid
cache, so I guess it is one possible suspect who cause our nid issue.

And, could you share me the information for reproducing the nid reallocation
issue? So I can reproduce in my environment for invistigating.

> I'm still struggling to find out something tho.
> Meanwhile, let's stay with both of the patches.

OK.

Thanks,


------------------------------------------------------------------------------
