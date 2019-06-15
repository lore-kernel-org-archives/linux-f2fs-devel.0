From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v4 14/16] ext4: add basic fs-verity support
Date: Sat, 15 Jun 2019 11:31:12 -0400
Message-ID: <20190615153112.GO6142@mit.edu>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-15-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1hcAeP-0000of-2g
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 15 Jun 2019 15:31:29 +0000
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hcAeM-00FA6Z-Jb
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 15 Jun 2019 15:31:28 +0000
Content-Disposition: inline
In-Reply-To: <20190606155205.2872-15-ebiggers@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eric Biggers <ebiggers@kernel.org>
Cc: "Darrick J . Wong" <darrick.wong@oracle.com>, linux-api@vger.kernel.org, Dave Chinner <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-integrity@vger.kernel.org, linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Victor Hsieh <victorhsieh@google.com>

On Thu, Jun 06, 2019 at 08:52:03AM -0700, Eric Biggers wrote:
> +/*
> + * Format of ext4 verity xattr.  This points to the location of the verity
> + * descriptor within the file data rather than containing it directly because
> + * the verity descriptor *must* be encrypted when ext4 encryption is used.  But,
> + * ext4 encryption does not encrypt xattrs.
> + */
> +struct fsverity_descriptor_location {
> +	__le32 version;
> +	__le32 size;
> +	__le64 pos;
> +};

What's the benefit of storing the location in an xattr as opposed to
just keying it off the end of i_size, rounded up to next page size (or
64k) as I had suggested earlier?

Using an xattr burns xattr space, which is a limited resource, and it
adds some additional code complexity.  Does the benefits outweigh the
added complexity?

						- Ted
