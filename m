From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fscrypt: cache decrypted symlink target in
 ->i_link
Date: Wed, 10 Apr 2019 02:04:25 +0100
Message-ID: <20190410010425.GU2217@ZenIV.linux.org.uk>
References: <20190409233544.156665-1-ebiggers@kernel.org>
 <20190410003346.GT2217@ZenIV.linux.org.uk>
 <20190410004553.GA2454@sol.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <viro@ftp.linux.org.uk>) id 1hE1fI-0003XN-Bw
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Apr 2019 01:04:36 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hE1fG-00Agki-Bt
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Apr 2019 01:04:36 +0000
Content-Disposition: inline
In-Reply-To: <20190410004553.GA2454@sol.localdomain>
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

On Tue, Apr 09, 2019 at 05:45:54PM -0700, Eric Biggers wrote:
> On Wed, Apr 10, 2019 at 01:33:46AM +0100, Al Viro wrote:
> > On Tue, Apr 09, 2019 at 04:35:44PM -0700, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > Path lookups that traverse encrypted symlink(s) are very slow because
> > > each encrypted symlink needs to be decrypted each time it's followed.
> > > 
> > > Make encrypted symlinks faster by caching the decrypted symlink target
> > > in ->i_link.  The first call to ->get_link() sets it; later calls simply
> > > return it.  ->symlink() also sets it when the symlink is created.
> > > 
> > > When the inode's ->i_crypt_info is freed, ->i_link is freed too.
> > > 
> > > Note: RCU-delayed freeing of ->i_link is not yet implemented.
> > > Therefore, for now even when ->i_link is set, path lookups must continue
> > > to drop out of RCU-walk mode when following an encrypted symlink.
> > 
> > And how the devil would they continue to do that, if I might ask?
> > ->get_link() is *NOT* called if ->i_link is non-NULL, period.
> 
> You're right, I didn't notice that ->get_link() isn't called when
> ->i_link is non-NULL.
> 
> But that being the case, what's the point of simple_get_link()?

Non-NULL ->get_link() => DCACHE_SYMLINK_TYPE in ->d_flags =>
d_is_symlink() true => step_into() progresses to pick_link().

IOW, non-NULL ->get_link() is what tells you that we have
a symlink there.
