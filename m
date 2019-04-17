From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2 2/2] fscrypt: cache decrypted symlink
 target in ->i_link
Date: Wed, 17 Apr 2019 12:55:56 -0400
Message-ID: <20190417165556.GI4686@mit.edu>
References: <20190410202115.64501-1-ebiggers@kernel.org>
 <20190410202115.64501-3-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1hGnrJ-0006Mk-2x
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 16:56:29 +0000
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hGnrG-00CRXc-Sq
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 16:56:29 +0000
Content-Disposition: inline
In-Reply-To: <20190410202115.64501-3-ebiggers@kernel.org>
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
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, linux-mtd@lists.infradead.org, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org

On Wed, Apr 10, 2019 at 01:21:15PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Path lookups that traverse encrypted symlink(s) are very slow because
> each encrypted symlink needs to be decrypted each time it's followed.
> This also involves dropping out of rcu-walk mode.
> 
> Make encrypted symlinks faster by caching the decrypted symlink target
> in ->i_link.  The first call to fscrypt_get_symlink() sets it.  Then,
> the existing VFS path lookup code uses the non-NULL ->i_link to take the
> fast path where ->get_link() isn't called, and lookups in rcu-walk mode
> remain in rcu-walk mode.
> 
> Also set ->i_link immediately when a new encrypted symlink is created.
> 
> To safely free the symlink target after an RCU grace period has elapsed,
> introduce a new function fscrypt_free_inode(), and make the relevant
> filesystems call it just before actually freeing the inode.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good, applied.

					- Ted
