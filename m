From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [GIT PULL] f2fs updates for v4.6
Date: Sat, 26 Mar 2016 16:41:25 -0400
Message-ID: <20160326204125.GD4539@thunk.org>
References: <20160320225859.GA5047@jaegeuk.hsd1.ca.comcast.net>
 <CA+55aFzuS39yE8_3U_UTF6i1hQorLA7upEP1zPK-31iOYwRQfQ@mail.gmail.com>
 <20160321184520.GA8199@jaegeuk.gateway>
 <20160326061007.GA24620@zzz>
 <20160326085606.GA41603@jaegeuk.hsd1.ca.comcast.net>
 <20160326134748.GA971@zzz>
 <CA+55aFwXQ+DVz-vFJf-ohYWwOHMWg4tKNS4CNdQ5pocZ1OHtVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFwXQ+DVz-vFJf-ohYWwOHMWg4tKNS4CNdQ5pocZ1OHtVQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Biggers <ebiggers3@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Michael Halcrow <mhalcrow@google.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Sat, Mar 26, 2016 at 10:53:52AM -0700, Linus Torvalds wrote:
> On Sat, Mar 26, 2016 at 6:47 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
> > Another question about the choice of IV.  If the page index in CPU order is
> > (supposed to be) used as the IV, doesn't make the on-disk format of the
> > filesystem endianness-dependent?  I thought that's a big no-no.
> 
> It is indeed a bad design choice, but at the same time I think it's
> time to just admit that big-endian is largely dead, and people don't
> necessarily need to worry about it too much.

Yes, this is a bug.  We should have used a CPU endianness-independent
IV.  Mea culpa for not noticing this.

> I do wonder if it would make sense to just _force_ the use of the
> little-endian format, and make that memcpy be a
> 
>      *(__le64 *)xts_tweak = cpu_to_le64(pgoff);
> 
> instead. That would break any existing BE uses, but considering that
> this code is fairly new, those may simply not exist.

Yes, that's probably the best way to go.

> The code itself seems largely identical between ext4 and f2fs (which I
> assume is the reason for trying to move it to a shared subdirectory),
> and is fairly new. It was merged in both back in April of last year,
> so I can't tell if one or the other is supposedly the "official" one,
> or how much actual use the crypto extensions actually have yet. Adding
> Michael Halcrow to the Cc for comments.

The ext4 code came first, but we've been working closely with the f2fs
folks to make sure they could reuse userspace and to eventually merge
everything into a shared subdirectory.  The main reason why we didn't
was because we were in a rush to try to beat the Android 'M'
deadlines.  Unfortunately, an ARM-specific bug caused us to have to
pull the feature from the Android Marshmellow release at the last
minute (xfstests hadn't been ported to the Android environment yet,
and so I could only do my testing on x86 and hope that translated to
ARM).  That being said, the AOSP release for M has working userspace
support for the file system crypto feature, and you can make it work
with either ext4 or f2fs encryption.

The pre-release e2fsprogs 1.43 has support for the encryption feature,
and the e4crypt binary should work for f2fs as well --- but that only
got released in Debian unstable last week.  (Single signon support via
integration for PAM is not yet done; there's enough in e4crypt for
testing purposes, but we've been more focused on userspace integration
for Android than for the generic Linux desktop.)

So while it's possible that there might be some super-aggressive early
adopters using Cyanogen or Debian unstable, it wouldn't be very many,
and it's almost certainly on little-endian and not on bigendian
architectures.  So preserving compatibility for LE platforms is the
right way to go.

> I also wonder if the xts_tweak should perhaps have both the page
> offset _and_ the inode number in it. Both ext4 and f2fs specify that
> xts tweak size to be 16 bytes, and right now fill the last 8 bytes
> with zero. Would it make sense to just put the inode number in there?
> I didn't look at the actual key stuff - maybe the key is already
> per-inode and it doesn't make any sense to add the inode info _again_,

Yes, the key is per-file.  The user's key is mixed with a per-inode
nonce to create a per-inode key.

BTW, as far as switching ext4 to use the shared code in fs/crypto ---
I'm hoping to get that done for the next merge window.  There are a 2
or 3 patches to fix some recently discovered bugs that I'll need to
push into the fs/crypto code, but I'll take care of that for the next
development cycle.

						- Ted
