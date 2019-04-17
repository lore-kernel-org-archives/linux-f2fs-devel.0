From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2 1/2] vfs: use READ_ONCE() to access
 ->i_link
Date: Wed, 17 Apr 2019 12:41:37 -0400
Message-ID: <20190417164137.GH4686@mit.edu>
References: <20190410202115.64501-1-ebiggers@kernel.org>
 <20190410202115.64501-2-ebiggers@kernel.org>
 <20190410210657.GA2217@ZenIV.linux.org.uk>
 <20190410231547.GC120258@gmail.com>
 <20190411022514.GC2217@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1hGnd9-00035n-P5
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 16:41:51 +0000
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hGnd8-00BiCH-3X
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 16:41:51 +0000
Content-Disposition: inline
In-Reply-To: <20190411022514.GC2217@ZenIV.linux.org.uk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org, linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org

On Thu, Apr 11, 2019 at 03:25:15AM +0100, Al Viro wrote:
> On Wed, Apr 10, 2019 at 04:15:48PM -0700, Eric Biggers wrote:
> > On Wed, Apr 10, 2019 at 10:06:57PM +0100, Al Viro wrote:
> > > On Wed, Apr 10, 2019 at 01:21:14PM -0700, Eric Biggers wrote:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > Use 'READ_ONCE(inode->i_link)' to explicitly support filesystems caching
> > > > the symlink target in ->i_link later if it was unavailable at iget()
> > > > time, or wasn't easily available.  I'll be doing this in fscrypt, to
> > > > improve the performance of encrypted symlinks on ext4, f2fs, and ubifs.
> > > > 
> > > > ->i_link will start NULL and may later be set to a non-NULL value by a
> > > > smp_store_release() or cmpxchg_release().  READ_ONCE() is needed on the
> > > > read side.  smp_load_acquire() is unnecessary because only a data
> > > > dependency barrier is required.  (Thanks to Al for pointing this out.)
> > > 
> > > You've missed vfs_readlink()...
> > 
> > How so?  The patch already updates vfs_readlink().
> 
> Huh?  Right you are - fsck knows how have I managed to misread that...
> Anyway, I can pick that READ_ONCE() patch through vfs.git if you wish,
> or it can go through your tree with my Acked-by - up to you...

Al, I'll take it through the fscrypt tree with your Acked-by, if you
don't mind.

					- Ted
