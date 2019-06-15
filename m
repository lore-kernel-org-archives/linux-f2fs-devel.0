From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v4 04/16] fs: uapi: define verity bit for
 FS_IOC_GETFLAGS
Date: Sat, 15 Jun 2019 08:40:48 -0400
Message-ID: <20190615124048.GE6142@mit.edu>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-5-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1hc7zU-0007vv-Ll
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 15 Jun 2019 12:41:04 +0000
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hc7zS-00FJcD-22
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 15 Jun 2019 12:41:03 +0000
Content-Disposition: inline
In-Reply-To: <20190606155205.2872-5-ebiggers@kernel.org>
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

On Thu, Jun 06, 2019 at 08:51:53AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add FS_VERITY_FL to the flags for FS_IOC_GETFLAGS, so that applications
> can easily determine whether a file is a verity file at the same time as
> they're checking other file flags.  This flag will be gettable only;
> FS_IOC_SETFLAGS won't allow setting it, since an ioctl must be used
> instead to provide more parameters.
> 
> This flag matches the on-disk bit that was already allocated for ext4.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good; you can add:

Reviewed-off-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
