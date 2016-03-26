From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] f2fs updates for v4.6
Date: Sat, 26 Mar 2016 10:53:52 -0700
Message-ID: <CA+55aFwXQ+DVz-vFJf-ohYWwOHMWg4tKNS4CNdQ5pocZ1OHtVQ@mail.gmail.com>
References: <20160320225859.GA5047@jaegeuk.hsd1.ca.comcast.net>
	<CA+55aFzuS39yE8_3U_UTF6i1hQorLA7upEP1zPK-31iOYwRQfQ@mail.gmail.com>
	<20160321184520.GA8199@jaegeuk.gateway>
	<20160326061007.GA24620@zzz>
	<20160326085606.GA41603@jaegeuk.hsd1.ca.comcast.net>
	<20160326134748.GA971@zzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20160326134748.GA971@zzz>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Michael Halcrow <mhalcrow@google.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Good catch, Eric.

While waiting for explanations, I've committed the change to move back
to just the page index.

On Sat, Mar 26, 2016 at 6:47 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
>
> Another question about the choice of IV.  If the page index in CPU order is
> (supposed to be) used as the IV, doesn't make the on-disk format of the
> filesystem endianness-dependent?  I thought that's a big no-no.

It is indeed a bad design choice, but at the same time I think it's
time to just admit that big-endian is largely dead, and people don't
necessarily need to worry about it too much. It makes it impossible to
move a disk image from x86 and ARM to Sparc or BE powerpc, but it's
not like anybody is actually going to do that. And PowerPC is moving
towards LE particularly in environments that have any kind of sharing
going on.

The code itself seems largely identical between ext4 and f2fs (which I
assume is the reason for trying to move it to a shared subdirectory),
and is fairly new. It was merged in both back in April of last year,
so I can't tell if one or the other is supposedly the "official" one,
or how much actual use the crypto extensions actually have yet. Adding
Michael Halcrow to the Cc for comments.

I do wonder if it would make sense to just _force_ the use of the
little-endian format, and make that memcpy be a

     *(__le64 *)xts_tweak = cpu_to_le64(pgoff);

instead. That would break any existing BE uses, but considering that
this code is fairly new, those may simply not exist.

I also wonder if the xts_tweak should perhaps have both the page
offset _and_ the inode number in it. Both ext4 and f2fs specify that
xts tweak size to be 16 bytes, and right now fill the last 8 bytes
with zero. Would it make sense to just put the inode number in there?
I didn't look at the actual key stuff - maybe the key is already
per-inode and it doesn't make any sense to add the inode info _again_,
but if the key is fs-wide, maybe it would be a good idea? With a mount
option so that you can keep any legacy filesystem images..

                   Linus
