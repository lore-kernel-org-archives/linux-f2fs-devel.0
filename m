From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [GIT PULL] f2fs updates for v4.6
Date: Sat, 26 Mar 2016 01:10:07 -0500
Message-ID: <20160326061007.GA24620@zzz>
References: <20160320225859.GA5047@jaegeuk.hsd1.ca.comcast.net>
	<CA+55aFzuS39yE8_3U_UTF6i1hQorLA7upEP1zPK-31iOYwRQfQ@mail.gmail.com>
	<20160321184520.GA8199@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ebiggers3@gmail.com>) id 1ajhQN-0000Q7-SZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Mar 2016 06:10:15 +0000
Received: from mail-ig0-f179.google.com ([209.85.213.179])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ajhQN-0003b1-75
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Mar 2016 06:10:15 +0000
Received: by mail-ig0-f179.google.com with SMTP id cl4so23493573igb.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 25 Mar 2016 23:10:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160321184520.GA8199@jaegeuk.gateway>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>

Why was the XTS tweak initialization changed in commit 0b81d0779072 ("fs crypto:
move per-file encryption from f2fs tree to fs/crypto")?

Old code:

       memcpy(xts_tweak, &index, sizeof(index));
       memset(&xts_tweak[sizeof(index)], 0,
                       F2FS_XTS_TWEAK_SIZE - sizeof(index));

New code:
       memcpy(xts_tweak, &inode->i_ino, sizeof(index));
       memset(&xts_tweak[sizeof(index)], 0,
                       FS_XTS_TWEAK_SIZE - sizeof(index));

Now the XTS tweak is the same for all pages of each inode.

------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
