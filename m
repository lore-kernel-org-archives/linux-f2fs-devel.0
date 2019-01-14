From: Dave Chinner <david@fromorbit.com>
Subject: Re: Proposal: A new fs-verity interface
Date: Tue, 15 Jan 2019 10:41:01 +1100
Message-ID: <20190114234101.GQ27534@dastard>
References: <20190110051500.GA32361@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <david@fromorbit.com>) id 1gjBqy-0004Le-Bq
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 14 Jan 2019 23:41:12 +0000
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtp (Exim 4.90_1)
 id 1gjBqw-002LEr-Oo
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 14 Jan 2019 23:41:12 +0000
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
Cc: Eric Biggers <ebiggers@kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>, linux-fscrypt@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Jan 10, 2019 at 12:15:00AM -0500, Theodore Y. Ts'o wrote:
> The following approach is based in Darrick's suggestion:

I do not recall what that was, so this:

> int ioctl(fd, FS_IOC_ENABLE_VERITY, struct fsverity_arg *arg);
> 
> struct fsverity_arg {
>        int fsv_donor_fd;
>        u64 fsv_offset;
>        u64 fsv_size;
> };
> 
> fsv_offset and fsz_size must be a multiple of the file system block
> size.  If the ioctl comples successfully, as a side effect the
> donor_fd will have a hole punch operation on the specified range.  In
> other words, the equivalent of operation of fallocate(fsv_donor_fd,
> FALLOC_FL_PUNCH_HOLE, fsv_offset, fsv_size), and the file specified by
> fd will be protected using fsverity.

makes no sense to me. What's in {offset, size} and why do you need
to call this on that specific range? If it is the equivalent of a
hole punch, then why wouldn't you just use FALLOC_FL_PUNCH_HOLE?

Can you please write the man page for the interface so that the
description of what it does and how it should be used is crystal
clear and doesn't assume the reader knows "what darrick proposed"...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
