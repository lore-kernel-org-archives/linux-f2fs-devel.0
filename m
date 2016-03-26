From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [GIT PULL] f2fs updates for v4.6
Date: Sat, 26 Mar 2016 13:26:18 -0700
Message-ID: <20160326202618.GA42256@jaegeuk.hsd1.ca.comcast.net>
References: <20160320225859.GA5047@jaegeuk.hsd1.ca.comcast.net>
 <CA+55aFzuS39yE8_3U_UTF6i1hQorLA7upEP1zPK-31iOYwRQfQ@mail.gmail.com>
 <20160321184520.GA8199@jaegeuk.gateway>
 <20160326061007.GA24620@zzz>
 <20160326085606.GA41603@jaegeuk.hsd1.ca.comcast.net>
 <20160326134748.GA971@zzz>
 <CA+55aFwXQ+DVz-vFJf-ohYWwOHMWg4tKNS4CNdQ5pocZ1OHtVQ@mail.gmail.com>
 <20160326200027.GA42065@jaegeuk.hsd1.ca.comcast.net>
 <CA+55aFyqX90ZAa8-6X3+LGSn7h1u0G0d3OX01j5mSQTag7s6uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFyqX90ZAa8-6X3+LGSn7h1u0G0d3OX01j5mSQTag7s6uA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Biggers <ebiggers3@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Michael Halcrow <mhalcrow@google.com>, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Sat, Mar 26, 2016 at 01:04:44PM -0700, Linus Torvalds wrote:
> On Sat, Mar 26, 2016 at 1:00 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > After then, as Dave suggested, we needed to move the crypto libraries into
> > common fs/crypto, so that other filesystems can support that in common sense.
> >
> > Please check the below threads about this history.
> > http://www.spinics.net/lists/linux-fsdevel/msg93424.html
> 
> That's not the explanation we wanted.
> 
> The thing that needs explaining is the "index" change to
> "inode->i_ino", which I undid.

Oh, I made the original uplift patch a year ago and confused with the below
patch at that time.
I missed this, when writing new patches based on the old ones recently.

https://lkml.org/lkml/2015/5/11/1214

I made that patch to resolve the changed page index by fcollapse.
But, simply I noticed that encryption doesn't support fcollapse or finsert.

Thanks,

> 
> How/why did that happen?
> 
>                  Linus
