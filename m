From: Dmitry Vyukov via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: kernel BUG at fs/f2fs/node.c:LINE!
Date: Tue, 24 Apr 2018 16:28:02 +0200
Message-ID: <CACT4Y+b2UgpGHDdfPgu3vp1MR8feL16C=HXsQwx7TC2-3U=0Sg@mail.gmail.com>
References: <20180424062000.GA57884@jaegeuk-macbookpro.roam.corp.google.com>
 <000000000000ae37a6056a9273f6@google.com>
Reply-To: Dmitry Vyukov <dvyukov@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <dvyukov@google.com>) id 1fAyvm-0003gp-I5
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Apr 2018 14:28:30 +0000
Received: from mail-pf0-f170.google.com ([209.85.192.170])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fAyvk-00ABb3-QY
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Apr 2018 14:28:30 +0000
Received: by mail-pf0-f170.google.com with SMTP id p15so12400566pff.11
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 24 Apr 2018 07:28:28 -0700 (PDT)
In-Reply-To: <000000000000ae37a6056a9273f6@google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: syzbot <syzbot+d154ec99402c6f628887@syzkaller.appspotmail.com>
Cc: jaegeuk@kernel.org, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On Tue, Apr 24, 2018 at 8:42 AM, syzbot
<syzbot+d154ec99402c6f628887@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot tried to test the proposed patch but build/boot failed:
>
> failed to create VM pool: failed to create GCE image: failed to get create
> image operation operation-1524552040215-56a926ecc71d9-3edfeb8b-8abca81c:
> googleapi: Error 403: Rate Limit Exceeded, rateLimitExceeded
>
>
> Tested on git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/dev
> commit
> b549e322861b99f1862fb5f08dfb5e5753a38635 (Sat Apr 21 06:44:59 2018 +0000)
> f2fs: check cap_resource only for data blocks
>
> compiler: gcc (GCC) 8.0.1 20180413 (experimental)
> Patch: https://syzkaller.appspot.com/x/patch.diff?id=5565179303559168
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=1808800213120130118

Hi Jaegeuk,

Re the last failure (rate limiting), now should be fixed with:
https://github.com/google/syzkaller/commit/e2f4bf8f3818d49baf0f3789add75d5fd506ad8d
which adds some backoff-and-retry logic.

Re the first one, do I understand it correctly that dev-test already
contains the fix that you want to test?
We did not foresee such case initially, but you are not the first one
to try this. I've added support for testing without a patch now:
https://github.com/google/syzkaller/commit/9366d03f001170479319878905031f63d4377c46
and updated the docs:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches

So now this should work:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
dev-test

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
