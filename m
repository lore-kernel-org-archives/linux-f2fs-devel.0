From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] f2fs updates for v4.6
Date: Sat, 26 Mar 2016 13:48:23 -0700
Message-ID: <CA+55aFyh6Kjnb+=M5b-V7zY9nakzGfNyNwJf4VZHeQ5cOQRmKw@mail.gmail.com>
References: <20160320225859.GA5047@jaegeuk.hsd1.ca.comcast.net>
	<CA+55aFzuS39yE8_3U_UTF6i1hQorLA7upEP1zPK-31iOYwRQfQ@mail.gmail.com>
	<20160321184520.GA8199@jaegeuk.gateway>
	<20160326061007.GA24620@zzz>
	<20160326085606.GA41603@jaegeuk.hsd1.ca.comcast.net>
	<20160326134748.GA971@zzz>
	<CA+55aFwXQ+DVz-vFJf-ohYWwOHMWg4tKNS4CNdQ5pocZ1OHtVQ@mail.gmail.com>
	<20160326204125.GD4539@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linus971@gmail.com>) id 1ajv8H-00074N-Nn
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Mar 2016 20:48:29 +0000
Received: from mail-io0-f175.google.com ([209.85.223.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ajv8H-0004br-1j
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Mar 2016 20:48:29 +0000
Received: by mail-io0-f175.google.com with SMTP id e3so29244682ioa.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 26 Mar 2016 13:48:29 -0700 (PDT)
In-Reply-To: <20160326204125.GD4539@thunk.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Theodore Ts'o <tytso@mit.edu>, Linus Torvalds <torvalds@linux-foundation.org>, Eric Biggers <ebiggers3@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Michael Halcrow <mhalcrow@google.com>

On Sat, Mar 26, 2016 at 1:41 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>
>> I also wonder if the xts_tweak should perhaps have both the page
>> offset _and_ the inode number in it. Both ext4 and f2fs specify that
>> xts tweak size to be 16 bytes, and right now fill the last 8 bytes
>> with zero. Would it make sense to just put the inode number in there?
>> I didn't look at the actual key stuff - maybe the key is already
>> per-inode and it doesn't make any sense to add the inode info _again_,
>
> Yes, the key is per-file.  The user's key is mixed with a per-inode
> nonce to create a per-inode key.

Ok, so the only thing that makes sense is really the page offset. Sounds fine.

> BTW, as far as switching ext4 to use the shared code in fs/crypto ---
> I'm hoping to get that done for the next merge window.  There are a 2
> or 3 patches to fix some recently discovered bugs that I'll need to
> push into the fs/crypto code, but I'll take care of that for the next
> development cycle.

No worries. Considering this mistake (which happily seems to have an
innocent explanation for it) it would be good to have it verified that
the shared code does actually work for you, so that we don't end up in
the unhappy situation that the code got split up in order to be
shared, but some random detail choice then made it not actually work
for ext4 after all..

So even if I wouldn't want to pull any ext4 updates to use the new
shared location this merge windoe (I'm making ready to close the merge
window asap), it would be good to know that what we will have for 4.6
is going to work for you, and we don't end up with somethign that
diverges between f2fs and ext4 after all..

                Linus

------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
