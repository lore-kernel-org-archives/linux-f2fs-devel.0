From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH -v2] f2fs: Remove lock from check_valid_map
Date: Tue, 09 Sep 2014 13:43:46 +0800
Message-ID: <1410241426.732.378.camel@yhuang-dev>
References: <1410059104-9060-1-git-send-email-ying.huang@intel.com>
	<1410061110-31081-1-git-send-email-ying.huang@intel.com>
	<20140908035024.GA13009@jaegeuk-mac02.hsd1.ca.comcast.net>
	<CAC=cRTOdvOp=zBT986SqGXC2+iRxGzSgKdFYzTQjbAamYsGVsg@mail.gmail.com>
	<20140909051303.GB24581@jaegeuk-mac02.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ying.huang@intel.com>) id 1XREDb-0000Vj-QH
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 09 Sep 2014 05:43:55 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XREDZ-0005NY-Tl for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 09 Sep 2014 05:43:55 +0000
In-Reply-To: <20140909051303.GB24581@jaegeuk-mac02.hsd1.ca.comcast.net>
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
Cc: huang ying <huang.ying.caritas@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On Mon, 2014-09-08 at 22:13 -0700, Jaegeuk Kim wrote:
> Hi Huang,
> 
> On Mon, Sep 08, 2014 at 03:36:35PM +0800, huang ying wrote:
> > Hi, Jaegeuk,
> > 
> > On Mon, Sep 8, 2014 at 11:50 AM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > 
> > > Hi,
> > >
> > > On Sun, Sep 07, 2014 at 11:38:30AM +0800, Huang Ying wrote:
> > > > Only one bit is read in check_valid_map, holding a lock to do that
> > > > doesn't help anything except decreasing performance.
> > > >
> > > > Signed-off-by: Huang, Ying <ying.huang@intel.com>
> > > > ---
> > > >
> > > > v2: Fixed a build warning.
> > > >
> > > > ---
> > > >  fs/f2fs/gc.c |    3 ---
> > > >  1 file changed, 3 deletions(-)
> > > >
> > > > --- a/fs/f2fs/gc.c
> > > > +++ b/fs/f2fs/gc.c
> > > > @@ -378,14 +378,11 @@ static void put_gc_inode(struct list_hea
> > > >  static int check_valid_map(struct f2fs_sb_info *sbi,
> > > >                               unsigned int segno, int offset)
> > > >  {
> > > > -     struct sit_info *sit_i = SIT_I(sbi);
> > > >       struct seg_entry *sentry;
> > > >       int ret;
> > > >
> > > > -     mutex_lock(&sit_i->sentry_lock);
> > > >       sentry = get_seg_entry(sbi, segno);
> > > >       ret = f2fs_test_bit(offset, sentry->cur_valid_map);
> > > > -     mutex_unlock(&sit_i->sentry_lock);
> > > >       return ret;
> > >
> > > The f2fs_test_bit is not atomic, so I'm not sure this is a good approach.
> > > How about introducing rw_semaphore?
> > >
> > 
> > IMO, f2fs_test_bit just read a global variable (a byte in cur_valid_map),
> > then check its value. The byte may be changed in another CPU concurrently.
> > But even protected with a mutex, it can be changed in another CPU
> > immediately after mutex_unlock.  So mutex does not help  here.  Here we
> > just read a global variable, not read/modify/write, so, we don't need
> > atomic too.
> 
> Hmm. This is a pretty hard corner case to allow the mutex removal under the
> following assumption.
> 
> 1. All the sit entries are cached in a global array, which means that it never
> happens that any sit entry pointers are changed.
> 
> 2. I agree that f2fs_gc tries to conduct the cleaning with best effort, and
> it triggers again when it detects there is something to do more.
> So, check_valid_bitmap doesn't need to make a precise decision.
> 
> But, what I concern is the consistent policy to use such the mutex.
> If we break the rule, it becomes harder to debug potential bugs.

Yes.  We definitely need a rule.  But I suggest to make a small tweak to
the rule.  If we just read one variable with fixed address, we need not
to use a mutex to protect that.

> Anyway, have you been facing with such the lock contention?

No, I just review the code and thinks the mutex is not necessary.

Best Regards,
Huang, Ying



------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce.
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
