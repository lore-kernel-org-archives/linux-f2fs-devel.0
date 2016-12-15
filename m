From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] f2fs update for 4.10
Date: Wed, 14 Dec 2016 17:18:57 -0800
Message-ID: <20161215011857.GA3540@kroah.com>
References: <20161212221548.GA4001@jaegeuk.local>
	<CA+55aFw4dRsn0dG2RO7sgKFDF--jjb8_ZgQg_ghL+tpDKH63Tw@mail.gmail.com>
	<20161214184014.GA1116@jaegeuk.local>
	<20161214191820.GB1116@jaegeuk.local>
	<CA+55aFyvoaBXmyO56_uwMEtovMD7dW8YFMM9ZaahcBLVoE=CSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gregkh@linuxfoundation.org>) id 1cHKhB-0002k3-Eq
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 15 Dec 2016 01:18:53 +0000
Received: from mail.linuxfoundation.org ([140.211.169.12])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cHKhA-0003JJ-HH
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 15 Dec 2016 01:18:53 +0000
Content-Disposition: inline
In-Reply-To: <CA+55aFyvoaBXmyO56_uwMEtovMD7dW8YFMM9ZaahcBLVoE=CSg@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>

On Wed, Dec 14, 2016 at 04:38:32PM -0800, Linus Torvalds wrote:
> On Wed, Dec 14, 2016 at 11:18 AM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > BTW, I just downloaded mainline, and tried to build a debian package but
> > failed due to missing Documentation/Changes.
> >
> > I've found out that it was renamed by commit 186128f753
> >  ("docs-rst: add documents to development-process")
> >
> > And when taking a look at its description, it was supposed to do symlink for
> > document files, but did rename all of them.
> 
> Indeed.
> 
> Tssk. I've added the one symlink. Maybe we should add the others too,
> but for now let's keep it minimal.

Crap, I missed that in the patch I acked, I should have noticed that.

Thanks for the symlink, Mauro, want to make the rest of the files actual
symlinks as well, instead of just the rename?

thanks,

greg k-h

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
