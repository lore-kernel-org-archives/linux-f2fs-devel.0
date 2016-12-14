From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [GIT PULL] f2fs update for 4.10
Date: Wed, 14 Dec 2016 11:18:20 -0800
Message-ID: <20161214191820.GB1116@jaegeuk.local>
References: <20161212221548.GA4001@jaegeuk.local>
	<CA+55aFw4dRsn0dG2RO7sgKFDF--jjb8_ZgQg_ghL+tpDKH63Tw@mail.gmail.com>
	<20161214184014.GA1116@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cHF4P-0004PN-Iz
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 14 Dec 2016 19:18:29 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cHF4O-0003yq-IV
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 14 Dec 2016 19:18:29 +0000
Content-Disposition: inline
In-Reply-To: <20161214184014.GA1116@jaegeuk.local>
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
Cc: Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>

On 12/14, Jaegeuk Kim wrote:
> On 12/14, Linus Torvalds wrote:
> > On Mon, Dec 12, 2016 at 2:15 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > >
> > > Could you please consider this pull request?
> > 
> > Pulled. Mind double-checking my resolution wrt commit 70fd76140a6c
> > ("block,fs: use REQ_* flags directly")?
> 
> Thank you, and the resolution looks good to me as well.

BTW, I just downloaded mainline, and tried to build a debian package but
failed due to missing Documentation/Changes.

I've found out that it was renamed by commit 186128f753
 ("docs-rst: add documents to development-process")

And when taking a look at its description, it was supposed to do symlink for
document files, but did rename all of them.

Afterwards, I could see some files were re-added by commit 08a9a8d44c1
  ("doc: re-add CodingStyle and SubmittingPatches")

In order to build a package for now, I just added a symlink like below.

---
 Documentation/Changes | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 Documentation/Changes

diff --git a/Documentation/Changes b/Documentation/Changes
new file mode 120000
index 000000000000..7564ae1682ba
--- /dev/null
+++ b/Documentation/Changes
@@ -0,0 +1 @@
+process/changes.rst
\ No newline at end of file
-- 
2.11.0

Thanks,

> 
> Thanks,
> 
> > 
> >                      Linus
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most 
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
