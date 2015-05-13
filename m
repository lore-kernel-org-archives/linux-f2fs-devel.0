From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs crypto: use inode number for xts_tweak
Date: Tue, 12 May 2015 17:20:42 -0700
Message-ID: <20150513002042.GA46048@jaegeuk-mac02.mot.com>
References: <1431402663-24809-1-git-send-email-jaegeuk@kernel.org>
 <20150512233557.GA2969@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150512233557.GA2969@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, mhalcrow@google.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, May 12, 2015 at 07:35:57PM -0400, Theodore Ts'o wrote:
> On Mon, May 11, 2015 at 08:51:03PM -0700, Jaegeuk Kim wrote:
> > Previoulsy when making xts_tweak, page->index was used.
> > But, when it supports fcollapse, the block address was moved, so that we can
> > lose the original page->index, which causes decrytion failure.
> > 
> > In order to avoid that, let's use the inode->i_ino for xfs_tweak hint.
> 
> I'm afraid that's a really bad idea.  We need to have a different xts
> tweak for each block, and if we use the inode number, then every
> single block will have the same XTS tweak, which is a cryptographic
> disaster.

Thank you for the kind explanation.

I just thought that inode number was enough for encryption, since user
can easily retrieve any inode number and its block offsets/addresses as well.

> 
> Basically, we currently can't support either collapse range or insert
> range for encrypted files.  In ext4 we explicitly return EOPNOTSUPP if
> there is an attempt to call collapse range on an encrypted file.
> Personally, I don't think this is a major restriction, so I haven't
> lost any sleep over this.

Ok, I see. It should not be a major concern.
I'll deactivate collapse/insert in f2fs instead.

> 
> Eventually, Michael and I hope to add support for Galois Counter Mode,
> but that requires the file system to be able to store per-block
> cryptrographic information, which can be used for the GCM
> authentication tag as well as a per-block IV.  The per-block IV being
> stored in a separate data structure would also allow insert
> range/collapse range to work, at the cost of needing to do a lookup to
> fetch the per-block cryptographic information.  (And to set the
> per-block cryptographic information when writing the information, in a
> way where we can atomically write the data block as well as the
> per-block authenticaiton tag, which gets a bit tricky....)
> 
> In any case, I believe support for data integrity is a far more
> compelling reason for adding pre-block crypto information, and
> supporting collapse/insert range is at best a fortunate side effect.

Got it, thanks, :)

> 
> Cheers,
> 
> 						- Ted
