From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Proposal: Yet another possible fs-verity interface
Date: Sat, 9 Feb 2019 12:38:05 -0800
Message-ID: <CAHk-=wh2j+Yy28H_QxEdsP=k9xcHxjCG1PqKAF2Uv=ckK8oPug@mail.gmail.com>
References: <20190207031101.GA7387@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <torvalds@linuxfoundation.org>) id 1gsZOS-0006na-Rr
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 09 Feb 2019 20:38:32 +0000
Received: from mail-lj1-f193.google.com ([209.85.208.193])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gsZOQ-00Eu7K-At
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 09 Feb 2019 20:38:32 +0000
Received: by mail-lj1-f193.google.com with SMTP id q2-v6so5758786lji.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 09 Feb 2019 12:38:29 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com.
 [209.85.208.173])
 by smtp.gmail.com with ESMTPSA id y14-v6sm1215243ljj.55.2019.02.09.12.38.21
 for <linux-f2fs-devel@lists.sourceforge.net>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 09 Feb 2019 12:38:21 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id g11-v6so5822110ljk.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 09 Feb 2019 12:38:21 -0800 (PST)
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
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Eric Biggers <ebiggers@kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, Dave Chinner <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>, linux-fscrypt@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-ext4@vger.kernel.org

On Thu, Feb 7, 2019 at 8:10 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> After doing a lot of thinking and conferring with the other fs-verity
> developers, our current thinking is to simply move the Merkle tree
> creation into the kernel.  The upside of doing this is it completely
> bypasses all of the complaints about how to transfer the Merkle tree
> from userspace to the kernel.

This sounds very sane to me.

In particular, may I suggest that  the interface be made idempotent,
so that you can do the merkle tree operation several times with the
same offset/length arguments, and if the merkle tree has already been
calculated, you just return the resulting root hash directly.

Why? That allows you to "validate" images on filesystems that don't
actually have any long-term storage model for the merkle tree. IOW,
you could do the merkle tree calculation (and verification) every time
at bootup, and on a filesystem that supports the long-term storage of
said merkle data, it's a very cheap operation, but on a filesystem
that doesn't, it would still be *possible* to just calculate the hash
and mark it "finalized" for that boot (or that mount). IOW, it would
work for something like ramfs (but you could also make it work for any
random on-disk filesystem that doesn't support long-term storage).

At that point, the merkle tree thing ends up fairly equivalent to the
IMA "measurement" thing, with the exception that the filesystem *may*
optimize it to be long-term. Hmm?

Now, since I assume that only the merkle tree root hash would be
returned by the "enable merkle tree" operation (so that the code
enabling it can verify that the hash matches the expected value), you
do have to worry about the preimage attack, and make sure that you
can't fool the hashing by making the (bad) file contents themselves be
just the hashes of the (good) blocks. So each level of the merkle tree
needs to have a hash seeding thing or whatever.

              Linus
