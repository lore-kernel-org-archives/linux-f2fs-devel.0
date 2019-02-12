From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: Proposal: Yet another possible fs-verity interface
Date: Tue, 12 Feb 2019 00:12:37 -0500
Message-ID: <20190212051237.GQ23000@mit.edu>
References: <20190207031101.GA7387@mit.edu>
 <CAHk-=wh2j+Yy28H_QxEdsP=k9xcHxjCG1PqKAF2Uv=ckK8oPug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1gtRpU-0001jU-V8
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Feb 2019 06:46:04 +0000
Received: from mail-eopbgr790120.outbound.protection.outlook.com
 ([40.107.79.120] helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gtRpQ-009fqr-Fw
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Feb 2019 06:46:04 +0000
Content-Disposition: inline
In-Reply-To: <CAHk-=wh2j+Yy28H_QxEdsP=k9xcHxjCG1PqKAF2Uv=ckK8oPug@mail.gmail.com>
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

On Sat, Feb 09, 2019 at 12:38:05PM -0800, Linus Torvalds wrote:
> 
> In particular, may I suggest that  the interface be made idempotent,
> so that you can do the merkle tree operation several times with the
> same offset/length arguments, and if the merkle tree has already been
> calculated, you just return the resulting root hash directly.

Sure, I was already thinking that rerunning the ioctl should allow us
recover from an interrupted Merkle tree generation.  So I agree about
it being idempotent.

> Why? That allows you to "validate" images on filesystems that don't
> actually have any long-term storage model for the merkle tree. IOW,
> you could do the merkle tree calculation (and verification) every time
> at bootup, and on a filesystem that supports the long-term storage of
> said merkle data, it's a very cheap operation, but on a filesystem
> that doesn't, it would still be *possible* to just calculate the hash
> and mark it "finalized" for that boot (or that mount). IOW, it would
> work for something like ramfs (but you could also make it work for any
> random on-disk filesystem that doesn't support long-term storage).

Well, we *could* do that, but at that point we've just transformed the
Merkle tree to be a very inefficient crypto checksum.  The whole point
of the Merkle tree is that you *don't* have to scan the entire data
file before you open the file (or at boot-time).  Instead, the root
hash of the Merkle tree is digitally signed, and you verify the file
as you use it, block-by-block.  If there are large portions of the
file which are never used (for example, because they contain the
Russian language files, and the phone is being used by a French
speaker), then we don't have to read that portion of the file to
checksum it.

If the file system doesn't have a way to store the Merkle tree, and we
have to recalculate the "Merkle tree has" as a way of validating the
file, it will be *much* faster simply to calculate the SHA-256 of the
file, and then verify that against a digital signature of the expected
crypto checksum.  For a file system that doesn't support the Merkle tree, 

> At that point, the merkle tree thing ends up fairly equivalent to the
> IMA "measurement" thing, with the exception that the filesystem *may*
> optimize it to be long-term. Hmm?

Well, except that it's just a less efficient way of doing IMA
"measurement" (if the file system doesn't support Merkle tree
storage).

So adding that complexity is, in my view, not really worth it, since I
very much doubt anyone would use a slower scheme.  I think the much
better model is that fsverity is for file system where you can store
the Merkle tree (and it's really not that hard for most file systems
to store it); and if you are using a file system which doesn't, use
IMA in good health.

I've talked to Mimi about how we can hook fsverity into the IMA
machinery, so that if you have fsverity protected files, that can be
used for the audit log (for example).  This basically means treating
the Merkle tree hash (which is stored in the fsverity "superblock", so
it can be fetched without pulling the entire file into the page cache)
as a IMA "checksum".

This will have to be a policy matter, since there are security folks
who like the idea that the entire 100 megabyte file must be paged in
to be checksummed *first*, before it is used.  That way, you know that
file is 100% valid before you allow userspace to start using it.  In
the fsverity model, if some portion of the file is corrupted, possibly
maliciously by an adversary, the program might abort in the middle of
being run when the corrupted portion of the file is finally used.
This is a tradeoff; and for people who really care about "how many
seconds before the user touches the facebook app ico, and pixels start
being painted on the screen on a low-end mobile device", they'll take
the fsverity approach and avoid the IMA approach.

So yes --- we can tie into the IMA framework so that if policy allows,
it can be used instead of the IMA measurement.  But I don't think it
makes sense to try to use fsverity without the Merkle tree being
stored in the file system.

Cheers,

					- Ted
