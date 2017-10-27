From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix out-of-free problem caused by
 atomic write
Date: Fri, 27 Oct 2017 13:23:26 +0200
Message-ID: <20171027112326.GC96994@jaegeuk-macbookpro.roam.corp.google.com>
References: <1509027715-80477-1-git-send-email-yunlong.song@huawei.com>
 <20171026143019.GB67431@jaegeuk-macbookpro.roam.corp.google.com>
 <20171027063854.GA25279@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1e82jh-0006NH-1H
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Oct 2017 11:23:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e82jg-0001SN-9v
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Oct 2017 11:23:36 +0000
Content-Disposition: inline
In-Reply-To: <20171027063854.GA25279@infradead.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Christoph Hellwig <hch@infradead.org>
Cc: yunlong.song@icloud.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, miaoxie@huawei.com

On 10/26, Christoph Hellwig wrote:
> On Thu, Oct 26, 2017 at 04:30:19PM +0200, Jaegeuk Kim wrote:
> > On 10/26, Yunlong Song wrote:
> > > f2fs_balance_fs only actives once in the commit_inmem_pages, but there
> > > are more than one page to commit, so all the other pages will miss the
> > > check. This will lead to out-of-free problem when commit a very large
> > > file. To fix it, we should do f2fs_balance_fs for each inmem page.
> > 
> > NAK, this breaks atomicity.
> 
> Can someone please explain (and write down in e.g. manpages) these
> atomicy rules?

The basic idea is to provide atomicity of blocks written by write(2) given
period managed by user. For example, user can do 1) ioctl to start a period,
2) write(2) calls, 3) ioctl to commit all the blocks. Then, filesystem will
guarantee committed blocks should be recovered all or nothing after power-cut.

Scenario #1:
 - ioctl(fd, F2FS_IOC_START_ATOMIC_WRITE)
 - 0 = write(2)
 - ...
 - 0 = write(2)
 - ioctl(fd, F2FS_IOC_COMMIT_ATOMIC_WRITE)

Scenario #2:
 - ioctl(fd, F2FS_IOC_START_ATOMIC_WRITE)
 - 0 = write(2)
 - ...
 - err = write(2)
 - ioctl(fd, F2FS_IOC_ABORT_ATOMIC_WRITE)

Scenario #3:
 - ioctl(fd, F2FS_IOC_START_ATOMIC_WRITE)
 - 0 = write(2)
 - ...
 - process crashed or close(fd)

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
