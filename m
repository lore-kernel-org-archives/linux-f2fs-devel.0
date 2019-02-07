From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Proposal: Yet another possible fs-verity interface
Date: Wed, 6 Feb 2019 22:11:01 -0500
Message-ID: <20190207031101.GA7387@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1grodY-00071u-Q9
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 Feb 2019 18:43:00 +0000
Received: from mail-eopbgr760110.outbound.protection.outlook.com
 ([40.107.76.110] helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.90_1)
 id 1grodV-00APqz-Fm
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 Feb 2019 18:43:00 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Biggers <ebiggers@kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, Dave Chinner <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>, linux-fscrypt@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-ext4@vger.kernel.org

After doing a lot of thinking and conferring with the other fs-verity
developers, our current thinking is to simply move the Merkle tree
creation into the kernel.  The upside of doing this is it completely
bypasses all of the complaints about how to transfer the Merkle tree
from userspace to the kernel.  It avoids the complexities of
redesigning the xattr interface, or creating a magic fd which could be
lseek'ed, mmap'ed, read, written, etc. to transfer the Merkle tree,
etc.  Calculating the Merkle tree from a code complexity is going to
be simpler.

The downside of this approach is that it can take a lot of CPU time in
the kernel (it would have to do be done in a kernel thread).  An extra
bit of complication is worrying about how to handle the situation
where if the kernel crashes.  The current thinking is that the ioctl
which enable fs-verity protection on the file will make sure that the
file descriptor is not otherwise opened for writing, and then set the
immutable bit.  Once the Merkle tree is written and finalized, the
fs-verity flag would be set and the immutable bit would be cleared.
The exact mechanisms of crash recovery would be file-system dependent,
and TBD, but would probably rely on the journalling mechanisms
available (e.g., ext4 might rely on the orphan list; f2fs might use
copy-on-write semantics; etc.)

This effectively moves the complexity from the interface (which is
where we seem to be getting hung up) to the implementation, but as
stated above, the actual code to create a Merkle tree is fairly simple.

Hopefully this will cut through the current complaints of the
fs-verity API.

Cheers,

					- Ted
