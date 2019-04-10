From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fscrypt: cache decrypted symlink target in
 ->i_link
Date: Wed, 10 Apr 2019 05:31:35 +0100
Message-ID: <20190410043135.GX2217@ZenIV.linux.org.uk>
References: <20190409233544.156665-1-ebiggers@kernel.org>
 <20190410003346.GT2217@ZenIV.linux.org.uk>
 <20190410004553.GA2454@sol.localdomain>
 <20190410010425.GU2217@ZenIV.linux.org.uk>
 <20190410012247.GB2454@sol.localdomain>
 <20190410013934.GV2217@ZenIV.linux.org.uk>
 <20190410025808.GA7140@sol.localdomain>
 <20190410034414.GW2217@ZenIV.linux.org.uk>
 <20190410040413.GC7140@sol.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <viro@ftp.linux.org.uk>) id 1hE4tl-0001r1-Jn
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Apr 2019 04:31:45 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hE4tk-00B0zy-5Y
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Apr 2019 04:31:45 +0000
Content-Disposition: inline
In-Reply-To: <20190410040413.GC7140@sol.localdomain>
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
Cc: linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Tue, Apr 09, 2019 at 09:04:15PM -0700, Eric Biggers wrote:

> > What's to stop you from doing just that right now?  You'd need to take
> > care with barriers, but you'd need that anyway... As soon as ->i_link is set
> > you'll get no more ->get_link() on that sucker, using the cached value
> > from that point on.  IDGI...
> 
> 1.) The VFS won't know to drop of RCU-walk mode, so waiting an RCU grace period
>     before freeing the symlink target becomes mandatory.  (Which I'd like to do
>     for fscrypt anyway, but doing it sanely appears to require implementing
>     .destroy_inode() for ext4, f2fs, and ubifs.  I hoped I could do non-RCU mode
>     as a simpler first step.)

You might want to check those filesystems.  All three you've mentioned *have*
->destroy_inode() already.
 
> 2.) The VFS won't know to use a read memory barrier when loading i_link.
>     The VFS could issue one unconditionally, but it would be unnecessary for
>     regular fast symlinks.

Not really.  All we need on the read side is READ_ONCE(); it will supply
smp_read_barrier_depends() (which is a no-op except for alpha).  On the
write side we need smp_store_release() to set ->i_link (in addition to
whatever serialization we want for actual calculation of the value to
be cached, of course).
