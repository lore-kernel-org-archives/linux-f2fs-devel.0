From: Matthew Wilcox <willy@infradead.org>
Subject: Re: Proposal: A new fs-verity interface
Date: Thu, 24 Jan 2019 16:32:17 -0800
Message-ID: <20190125003217.GB18522@bombadil.infradead.org>
References: <20190110051500.GA32361@mit.edu> <20190114234101.GQ27534@dastard>
 <20190123051017.GA8785@mit.edu> <20190124212544.GS6173@dastard>
 <CAHk-=wh7jq6U3+ou_FDujB-ipg9JcJAGSjEQ_niCwLG313x6UA@mail.gmail.com>
 <20190124232237.GH8785@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1gmpQ9-0000T2-Jp
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Jan 2019 00:32:33 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gmpQ6-00GW6N-A4
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Jan 2019 00:32:33 +0000
Content-Disposition: inline
In-Reply-To: <20190124232237.GH8785@mit.edu>
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
Cc: Eric Biggers <ebiggers@kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, Dave Chinner <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>, linux-fscrypt@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Jan 24, 2019 at 06:22:37PM -0500, Theodore Y. Ts'o wrote:
> The main issue is that for a 129 MB file, the Merkle data is going to
> be a Megabyte.

127MB ... I pointed out this error the last time the documentation
was posted.

> We could store the metadata somewhere else --- for example, we could
> store it in another inode.  But inodes have overhead, and that would
> mean using two inodes for every fs-verity protected files --- and we
> don't need all of the other metadata (mtime, ctime, etc.) for the
> Merkle tree.  So that's how we got to where we were.  I think the
> approach of storing it using the same extent tree where we map logical
> block numbers to physical block numbers make a lot of sense for ext4
> and f2fs.
> 
> It seems that some file system (which may never even implement
> fs-verity) their developers hate that particular approach.  So that's
> where the suggestion of using a separate file descriptor to convey the
> Merkle tree data to the file system came from.  It wasn't my first
> choice.

I'll reiterate an API I suggested on December 21st:

: verity_fd = ioctl(fd, FS_IOC_VERITY_FD);
: write(verity_fd, &merkle_tree);
: close(verity_fd);
: 
: At final close of that verity_fd, the filesystem behaves in the same way
: that it does on receipt of this FS_IOC_ENABLE_VERITY ioctl today.
