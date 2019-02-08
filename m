From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: Proposal: Yet another possible fs-verity interface
Date: Fri, 08 Feb 2019 14:10:08 -0500
Message-ID: <1549653008.3647.8.camel@HansenPartnership.com>
References: <20190207031101.GA7387@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <James.Bottomley@HansenPartnership.com>)
 id 1gsBXZ-0006kr-JB
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Feb 2019 19:10:21 +0000
Received: from bedivere.hansenpartnership.com ([66.63.167.143])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gsBXV-001vs2-DX
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Feb 2019 19:10:20 +0000
In-Reply-To: <20190207031101.GA7387@mit.edu>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Biggers <ebiggers@kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, Dave Chinner <david@fromorbit.com>, Mimi Zohar <zohar@linux.ibm.com>, linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>, linux-fscrypt@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-ext4@vger.kernel.org

On Wed, 2019-02-06 at 22:11 -0500, Theodore Y. Ts'o wrote:
> After doing a lot of thinking and conferring with the other fs-verity
> developers, our current thinking is to simply move the Merkle tree
> creation into the kernel.  The upside of doing this is it completely
> bypasses all of the complaints about how to transfer the Merkle tree
> from userspace to the kernel.  It avoids the complexities of
> redesigning the xattr interface, or creating a magic fd which could
> be lseek'ed, mmap'ed, read, written, etc. to transfer the Merkle
> tree, etc.  Calculating the Merkle tree from a code complexity is
> going to be simpler.

I'm happy with this but, as I asked before when something like this was
proposed: can this now become part of IMA?  We simply write an IMA hash
or signature which is a possibly signed top of merkle tree hash (we'll
need a new IMA hash format for this).  The act of writing the xattr
triggers the merkle tree build, how (or indeed whether) the kernel
caches the tree is a fs dependent detail and if the fs can't cache it,
the tree would be reconstructed on first use after a reboot.

> The downside of this approach is that it can take a lot of CPU time
> in the kernel (it would have to do be done in a kernel thread).  An
> extra bit of complication is worrying about how to handle the
> situationwhere if the kernel crashes.

I think this would be up to the fs, but the semantic expectation could
be that the whole thing gets erased and we retry on next use, or the fs
uses a fs dependent mechanism to cache the partially constructed tree
and completes the construction on next use.

>   The current thinking is that the ioctl which enable fs-verity
> protection on the file will make sure that the file descriptor is not
> otherwise opened for writing, and then set the immutable bit. 

If you simply use standard IMA xattrs, you don't need an ioctl ... you
actually now don't need the file to be immutable (although you could
additionally make it so if you wanted): IMA signed files are
effectively immutable because you must update both the contents and the
signature for the file to verify.

James

> Once the Merkle tree is written and finalized,
> the fs-verity flag would be set and the immutable bit would be
> cleared. The exact mechanisms of crash recovery would be file-system
> dependent, and TBD, but would probably rely on the journalling
> mechanisms available (e.g., ext4 might rely on the orphan list; f2fs
> might use copy-on-write semantics; etc.)

I think all that is per-fs semantics that don't need to be specified
for the generic implementation.  I'd be happy with a write to the file
causing a halt to the construction and a reconstruction not starting
until the xattr is updated.

> This effectively moves the complexity from the interface (which is
> where we seem to be getting hung up) to the implementation, but as
> stated above, the actual code to create a Merkle tree is fairly
> simple.
> 
> Hopefully this will cut through the current complaints of the
> fs-verity API.
