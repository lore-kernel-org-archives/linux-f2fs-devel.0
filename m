From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [GIT PULL] f2fs updates for v4.6
Date: Sat, 26 Mar 2016 01:56:06 -0700
Message-ID: <20160326085606.GA41603@jaegeuk.hsd1.ca.comcast.net>
References: <20160320225859.GA5047@jaegeuk.hsd1.ca.comcast.net>
 <CA+55aFzuS39yE8_3U_UTF6i1hQorLA7upEP1zPK-31iOYwRQfQ@mail.gmail.com>
 <20160321184520.GA8199@jaegeuk.gateway>
 <20160326061007.GA24620@zzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160326061007.GA24620@zzz>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Sat, Mar 26, 2016 at 01:10:07AM -0500, Eric Biggers wrote:
> Why was the XTS tweak initialization changed in commit 0b81d0779072 ("fs crypto:
> move per-file encryption from f2fs tree to fs/crypto")?
> 
> Old code:
> 
>        memcpy(xts_tweak, &index, sizeof(index));
>        memset(&xts_tweak[sizeof(index)], 0,
>                        F2FS_XTS_TWEAK_SIZE - sizeof(index));
> 
> New code:
>        memcpy(xts_tweak, &inode->i_ino, sizeof(index));
>        memset(&xts_tweak[sizeof(index)], 0,
>                        FS_XTS_TWEAK_SIZE - sizeof(index));
> 
> Now the XTS tweak is the same for all pages of each inode.

Thank you for catching this.
I've checked several times, but turns out I missed something tho. :(
Let me write a patch to fix this.

Thanks,


