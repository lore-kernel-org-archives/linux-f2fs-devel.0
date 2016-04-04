From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] f2fs fixes for v4.6-rc3
Date: Mon, 4 Apr 2016 13:07:11 -0700
Message-ID: <CA+55aFwa9b5=aYKXNKfCaQN27PFY8GChuhCK+pkrqCfGn6FpKQ@mail.gmail.com>
References: <20160404052110.GB80122@jaegeuk.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linus971@gmail.com>) id 1anAmP-0003BO-Om
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Apr 2016 20:07:23 +0000
Received: from mail-ig0-f179.google.com ([209.85.213.179])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1anAmO-00024l-Pt
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Apr 2016 20:07:21 +0000
Received: by mail-ig0-f179.google.com with SMTP id kb1so999988igb.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 04 Apr 2016 13:07:20 -0700 (PDT)
In-Reply-To: <20160404052110.GB80122@jaegeuk.ucsc.edu>
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

On Sun, Apr 3, 2016 at 10:21 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> Could you please pull the below commits for v4.6-rc3?

Pulled, but..

>   git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-linus

.. the above is a tag, but it's not signed, nor even annotated. So it
has no message about what the fixes are in it, it's just the plain
SHA1 id.

Now, I don't really require signed tags from kernel.org, but it would
still be nice. And I *do* want a little blurb about the fixes, even if
it doesn't have to be all that exhaustive. Putting that in the tag is
convenient, but I'm ok with it being just in the email message too,
like you usually do.

This case had neither, so now my merge message is not as descriptive
as I prefer them ;(

             Linus

------------------------------------------------------------------------------
