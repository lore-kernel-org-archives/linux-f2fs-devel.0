From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] f2fs updates for v4.6
Date: Mon, 21 Mar 2016 11:09:45 -0700
Message-ID: <CA+55aFzuS39yE8_3U_UTF6i1hQorLA7upEP1zPK-31iOYwRQfQ@mail.gmail.com>
References: <20160320225859.GA5047@jaegeuk.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linus971@gmail.com>) id 1ai4H2-0004yp-Dc
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Mar 2016 18:09:52 +0000
Received: from mail-ig0-f173.google.com ([209.85.213.173])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ai4H1-0001FD-BY
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Mar 2016 18:09:52 +0000
Received: by mail-ig0-f173.google.com with SMTP id nk17so77214972igb.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 21 Mar 2016 11:09:51 -0700 (PDT)
In-Reply-To: <20160320225859.GA5047@jaegeuk.hsd1.ca.comcast.net>
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
Cc: Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>

On Sun, Mar 20, 2016 at 3:58 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> I made another pull request which removes the previous wrong commits and adds
> a single commit to migrate the f2fs crypto into fs/crypto.

Ok, merged.  Please double-check the end result, but since most of the
skcipher update was literally to just change "ablk" to "sk", the merge
seems to have been pretty trivial.

It all compiles for me, but since I don't use f2fs, I have nothing to test.

(It's not pushed out quite yet - I'm still test-building everything
else, so if you pull my tree and don't see the merge, wait a few
minutes and it should be there).

                Linus

------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
