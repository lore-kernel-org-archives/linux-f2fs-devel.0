From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] f2fs: fix fdatasync
Date: Wed, 16 Nov 2016 04:15:38 -0800
Message-ID: <20161116121538.GA22373@infradead.org>
References: <20161116121211.11790-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from
	<BATV+acab11531514b6d0482e+4833+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1c6z7z-0005xa-T0 for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Nov 2016 12:15:47 +0000
Received: from bombadil.infradead.org ([198.137.202.9])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1c6z7z-0001mT-0e
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Nov 2016 12:15:47 +0000
Content-Disposition: inline
In-Reply-To: <20161116121211.11790-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Wed, Nov 16, 2016 at 08:12:11PM +0800, Chao Yu wrote:
> For below two cases, we can't guarantee data consistence:
> 
> a)
> 1. xfs_io "pwrite 0 4195328" "fsync"
> 2. xfs_io "pwrite 4195328 1024" "fdatasync"
> 3. godown
> 4. umount & mount
> --> isize we updated before fdatasync won't be recovered
> 
> b)
> 1. xfs_io "pwrite -S 0xcc 0 4202496" "fsync"
> 2. xfs_io "fpunch 4194304 4096" "fdatasync"
> 3. godown
> 4. umount & mount
> --> dnode we punched before fdatasync won't be recovered

Can you please add testcases for these to xfstests?

------------------------------------------------------------------------------
