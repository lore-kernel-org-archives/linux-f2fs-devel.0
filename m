From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v4 13/16] fs-verity: support builtin file
 signatures
Date: Sat, 15 Jun 2019 11:21:43 -0400
Message-ID: <20190615152143.GN6142@mit.edu>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-14-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1hcAVD-0006z5-LW
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 15 Jun 2019 15:21:59 +0000
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hcAVA-009NHD-LQ
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 15 Jun 2019 15:21:58 +0000
Content-Disposition: inline
In-Reply-To: <20190606155205.2872-14-ebiggers@kernel.org>
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

On Thu, Jun 06, 2019 at 08:52:02AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> To meet some users' needs, add optional support for having fs-verity
> handle a portion of the authentication policy in the kernel.  An
> ".fs-verity" keyring is created to which X.509 certificates can be
> added; then a sysctl 'fs.verity.require_signatures' can be set to cause
> the kernel to enforce that all fs-verity files contain a signature of
> their file measurement by a key in this keyring.

I think it might be a good idea to allow the require_signatures
setting to be set on a per-file system basis, via a mount option?  We
could plumb it in via a flag in fsverity_info, set by the file system.

Other than this feature request, looks good; you can add:

Reviewed-off-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
