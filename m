From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: Proposal: A new fs-verity interface
Date: Wed, 23 Jan 2019 00:10:17 -0500
Message-ID: <20190123051017.GA8785@mit.edu>
References: <20190110051500.GA32361@mit.edu> <20190114234101.GQ27534@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1gmAoC-0002Es-AM
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 23 Jan 2019 05:10:40 +0000
Received: from mail-eopbgr760112.outbound.protection.outlook.com
 ([40.107.76.112] helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gmAo0-007OB3-Cs
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 23 Jan 2019 05:10:40 +0000
Content-Disposition: inline
In-Reply-To: <20190114234101.GQ27534@dastard>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Dave Chinner <david@fromorbit.com>
Cc: Eric Biggers <ebiggers@kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>, linux-fscrypt@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

Apologies for the delay in getting responding; I've been on vacation
last week.

On Tue, Jan 15, 2019 at 10:41:01AM +1100, Dave Chinner wrote:
> > int ioctl(fd, FS_IOC_ENABLE_VERITY, struct fsverity_arg *arg);
> > 
> > struct fsverity_arg {
> >        int fsv_donor_fd;
> >        u64 fsv_offset;
> >        u64 fsv_size;
> > };
> > 
> > fsv_offset and fsz_size must be a multiple of the file system block
> > size.  If the ioctl comples successfully, as a side effect the
> > donor_fd will have a hole punch operation on the specified range.  In
> > other words, the equivalent of operation of fallocate(fsv_donor_fd,
> > FALLOC_FL_PUNCH_HOLE, fsv_offset, fsv_size), and the file specified by
> > fd will be protected using fsverity.
> 
> makes no sense to me. What's in {offset, size} and why do you need
> to call this on that specific range? If it is the equivalent of a
> hole punch, then why wouldn't you just use FALLOC_FL_PUNCH_HOLE?

This is how we transfer the metadata (e.g., the Merkle tree plus a
header block) from userspace to the file system.  In the original
interface, the verity metadata was appended end of the data file, and
then an ioctl would transfer the metadata to the file system.  For
ext4 and f2fs, we actually store the fsverity metadata after the data
blocks and simply adjust i_size visible to userspace so the metadata
blocks are "invisible".

You objected to this interface, because it was too tightly tied to the
implementation used in ext4 and f2fs.  So what Darrick suggested is
that it could be conveyed by passing the metadata via a second file
descriptor.  The offset and size specifies where the metadata can be
fetched from the second file.

As in the original interface, the metadata blocks are "consumed" by
the ioctl, so they disappear from the second file, as if
FALLOC_FL_PUNCH_HOLE.  It's not that they are deallocated; the blocks
in question are simply getting transferred to inode which is being
protected using fs-verity.

> Can you please write the man page for the interface so that the
> description of what it does and how it should be used is crystal
> clear and doesn't assume the reader knows "what darrick proposed"...

I can do that, but I'd like to make sure we have general agreement
approach first.

Cheers,

						- Ted
