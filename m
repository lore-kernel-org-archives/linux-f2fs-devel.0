From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 1/2] f2fs: reorganize __f2fs_add_link
Date: Tue, 28 Jul 2015 18:26:25 +0800
Message-ID: <00e401d0c91f$f301b950$d9052bf0$@samsung.com>
References: <00f201d0c468$550aabf0$ff2003d0$@samsung.com>
	<20150723181522.GB23629@jaegeuk-mac02.mot.com>
	<006501d0c5fb$f6e12dc0$e4a38940$@samsung.com>
	<20150724155200.GA30823@jaegeuk-mac02.hsd1.ca.comcast.net>
	<20150724161117.GA31061@jaegeuk-mac02.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZK26b-00077F-Ue
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Jul 2015 10:27:29 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZK26a-0007YH-8j
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Jul 2015 10:27:29 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NS701L1V10LNV30@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Jul 2015 19:26:59 +0900 (KST)
In-reply-to: <20150724161117.GA31061@jaegeuk-mac02.hsd1.ca.comcast.net>
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
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Saturday, July 25, 2015 12:11 AM
> To: Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/2] f2fs: reorganize __f2fs_add_link
> 
> Hi Chao,
> 
> BTW, isn't there any problem on update_inode/mark_inode_dirty stuffs?

Any problem here?

> And, is there a hole to write uncompleted node pages unnecessarily?
> 

Yes, the hole can be filled.

> > Let me think about this for a while.
> > I think two patches are clean-ups with a little bit big changes.
> > Currently, we've touched many parts including extent_cache, so I need to focus
> > on stabilizing them first.
> > After then, I'd like to dig two clean-up patches. Ok?

It's OK. :)

Thanks,


------------------------------------------------------------------------------
