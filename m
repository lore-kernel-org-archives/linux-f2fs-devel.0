From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 1/2] vfs: use READ_ONCE() to access
 ->i_link
Date: Wed, 10 Apr 2019 22:06:57 +0100
Message-ID: <20190410210657.GA2217@ZenIV.linux.org.uk>
References: <20190410202115.64501-1-ebiggers@kernel.org>
 <20190410202115.64501-2-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <viro@ftp.linux.org.uk>) id 1hEKR2-0008Is-H0
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Apr 2019 21:07:08 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hEKR0-00ErKm-Ca
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Apr 2019 21:07:08 +0000
Content-Disposition: inline
In-Reply-To: <20190410202115.64501-2-ebiggers@kernel.org>
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
Cc: linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org, linux-mtd@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net

On Wed, Apr 10, 2019 at 01:21:14PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Use 'READ_ONCE(inode->i_link)' to explicitly support filesystems caching
> the symlink target in ->i_link later if it was unavailable at iget()
> time, or wasn't easily available.  I'll be doing this in fscrypt, to
> improve the performance of encrypted symlinks on ext4, f2fs, and ubifs.
> 
> ->i_link will start NULL and may later be set to a non-NULL value by a
> smp_store_release() or cmpxchg_release().  READ_ONCE() is needed on the
> read side.  smp_load_acquire() is unnecessary because only a data
> dependency barrier is required.  (Thanks to Al for pointing this out.)

You've missed vfs_readlink()...
