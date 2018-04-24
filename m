From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: kernel BUG at fs/f2fs/node.c:LINE!
Date: Tue, 24 Apr 2018 10:27:59 -0600
Message-ID: <20180424162759.GA66918@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180424062000.GA57884@jaegeuk-macbookpro.roam.corp.google.com>
 <000000000000ae37a6056a9273f6@google.com>
 <CACT4Y+b2UgpGHDdfPgu3vp1MR8feL16C=HXsQwx7TC2-3U=0Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fB0nY-0004zJ-Af
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Apr 2018 16:28:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fB0nW-00DN3C-Rh
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Apr 2018 16:28:08 +0000
Content-Disposition: inline
In-Reply-To: <CACT4Y+b2UgpGHDdfPgu3vp1MR8feL16C=HXsQwx7TC2-3U=0Sg@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Dmitry Vyukov <dvyukov@google.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, syzbot <syzbot+d154ec99402c6f628887@syzkaller.appspotmail.com>

On 04/24, Dmitry Vyukov wrote:
> On Tue, Apr 24, 2018 at 8:42 AM, syzbot
> <syzbot+d154ec99402c6f628887@syzkaller.appspotmail.com> wrote:
> > Hello,
> >
> > syzbot tried to test the proposed patch but build/boot failed:
> >
> > failed to create VM pool: failed to create GCE image: failed to get create
> > image operation operation-1524552040215-56a926ecc71d9-3edfeb8b-8abca81c:
> > googleapi: Error 403: Rate Limit Exceeded, rateLimitExceeded
> >
> >
> > Tested on git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/dev
> > commit
> > b549e322861b99f1862fb5f08dfb5e5753a38635 (Sat Apr 21 06:44:59 2018 +0000)
> > f2fs: check cap_resource only for data blocks
> >
> > compiler: gcc (GCC) 8.0.1 20180413 (experimental)
> > Patch: https://syzkaller.appspot.com/x/patch.diff?id=5565179303559168
> > Kernel config:
> > https://syzkaller.appspot.com/x/.config?id=1808800213120130118
> 
> Hi Jaegeuk,
> 
> Re the last failure (rate limiting), now should be fixed with:
> https://github.com/google/syzkaller/commit/e2f4bf8f3818d49baf0f3789add75d5fd506ad8d
> which adds some backoff-and-retry logic.
> 
> Re the first one, do I understand it correctly that dev-test already
> contains the fix that you want to test?
> We did not foresee such case initially, but you are not the first one
> to try this. I've added support for testing without a patch now:
> https://github.com/google/syzkaller/commit/9366d03f001170479319878905031f63d4377c46
> and updated the docs:
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
> 
> So now this should work:
> 
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
> dev-test

Cool! Thank you so much.


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
