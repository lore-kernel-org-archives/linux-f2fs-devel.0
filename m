From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [GIT PULL] f2fs for 4.8
Date: Wed, 27 Jul 2016 14:02:36 -0700
Message-ID: <20160727210236.GA73525@jaegeuk>
References: <20160727040800.GA69756@jaegeuk>
	<CA+55aFwnNLqsuL_LwAV4OYQf9v+pje5w=OwoE=oA-R8QpXB-Cg@mail.gmail.com>
	<86e4eb4c-3cb8-8e0f-ebb4-48cdf4dea8e8@fb.com>
	<CA+55aFx+v=iM2t+4OhF2AqbdszNYWt6677C2LvX-iYmDEnh_Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bSVyW-0002WQ-U6
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Jul 2016 21:02:44 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bSVyW-000120-3i
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Jul 2016 21:02:44 +0000
Content-Disposition: inline
In-Reply-To: <CA+55aFx+v=iM2t+4OhF2AqbdszNYWt6677C2LvX-iYmDEnh_Rg@mail.gmail.com>
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
Cc: Jens Axboe <axboe@fb.com>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>

On Wed, Jul 27, 2016 at 11:46:11AM -0700, Linus Torvalds wrote:
> On Wed, Jul 27, 2016 at 11:29 AM, Jens Axboe <axboe@fb.com> wrote:
> >
> > Looks OK to me, though I think you could have dropped the ->bi_rw
> > assignment in f2fs_submit_page_bio():
> >
> >         bio->bi_rw = fio->op_flags;
> >         bio_set_op_attrs(bio, fio->op, fio->op_flags);
> >
> >         __submit_bio(fio->sbi, bio, fio->type);
> 
> Ahh, yes. I'll add a patch to drop that line, unless you just want to
> do it yourself (or Jaegeuk Kim wants to do it in the f2fs tree).

Actually, I was writing an email to point that out. :)
Thanks to Jens for the patch for this.
Anyway, the changes look good to me as well.

> Jaegeuk, I'd still really want confirmation that it all actually
> works. The extra line should be harmless, even if Jens is right that
> it is ugly and wrong. It might be worth testing with that line
> removed.

I've confirmed that there is no problem; I've checked a round of xfstests and
fsstress test.

Thank you for resolving the conflicts.

Thanks,

------------------------------------------------------------------------------
