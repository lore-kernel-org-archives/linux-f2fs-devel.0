From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: Proposal: A new fs-verity interface
Date: Thu, 10 Jan 2019 10:18:36 -0800
Message-ID: <20190110181836.GA20467@magnolia>
References: <20190110051500.GA32361@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <darrick.wong@oracle.com>) id 1ghev0-00058D-D3
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Jan 2019 18:19:02 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gheuy-00BPP2-OF
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Jan 2019 18:19:02 +0000
Content-Disposition: inline
In-Reply-To: <20190110051500.GA32361@mit.edu>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Eric Biggers <ebiggers@kernel.org>, Dave Chinner <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>, linux-fscrypt@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Jan 10, 2019 at 12:15:00AM -0500, Theodore Y. Ts'o wrote:
> The following approach is based in Darrick's suggestion:
> 
> int ioctl(fd, FS_IOC_ENABLE_VERITY, struct fsverity_arg *arg);
> 
> struct fsverity_arg {
>        int fsv_donor_fd;

Explicitly sized fields and padding here, please.  ISTR there are a few
arches that don't have alignment requirements which will make this
messy.

>        u64 fsv_offset;
>        u64 fsv_size;

You might want to allocate some reserved space for flags in case you
ever decide you need it, but otherwise it seems fine to me...

--D

> };
> 
> fsv_offset and fsz_size must be a multiple of the file system block
> size.  If the ioctl comples successfully, as a side effect the
> donor_fd will have a hole punch operation on the specified range.  In
> other words, the equivalent of operation of fallocate(fsv_donor_fd,
> FALLOC_FL_PUNCH_HOLE, fsv_offset, fsv_size), and the file specified by
> fd will be protected using fsverity.
> 
> It will be legal for fsv_donor_fd == fd, so this interface is a
> superset of the original FS_IOC_ENABLE_VERITY ioctl.
> 
> This will hopefully make Christoph and Dave happy because the
> interface does not presuppose how ext4 and f2fs will implement
> fsverity behind the scenes.  However, it does not forbid it, and the
> net cost is that ext4 and f2fs will have to implement code which
> transplants the blocks from the donor_fd to fd in the case where
> donor_fd != fd --- and in the case where blocks are encrypted using
> fscrypt, we will have to decrypt the blocks from donor_fd and possibly
> re-encrypt then in fd's per-file key, which means we'll have to add
> extra complexity to implement the decrypt and re-encrypt passing
> through the page cache.
> 
> But if this helps resolve Christoph and Dave's objections, it
> shouldn't be _too_ much extra complexity.  Before we go ahead an
> implement it, though, I'd appreciate a confirmation that this will
> indeed actually resolve their complaints.
> 
> Thanks,
> 
> 					- Ted
