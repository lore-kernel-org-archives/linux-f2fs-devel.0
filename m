From: Sahitya Tummala <stummala@codeaurora.org>
Subject: Re: [PATCH] f2fs: fix unnecessary periodic wakeup of
 discard thread when dev is busy
Date: Sun, 2 Sep 2018 16:04:11 +0530
Message-ID: <20180902103411.GE12489@codeaurora.org>
References: <1535708366-11318-1-git-send-email-stummala@codeaurora.org>
 <ae0ec622-1fd3-d28a-019b-75a507e551f6@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <stummala@codeaurora.org>) id 1fwPi5-0007fT-GR
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 02 Sep 2018 10:34:25 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fwPi3-0072uM-8D
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 02 Sep 2018 10:34:25 +0000
Content-Disposition: inline
In-Reply-To: <ae0ec622-1fd3-d28a-019b-75a507e551f6@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Sun, Sep 02, 2018 at 04:52:40PM +0800, Chao Yu wrote:
> On 2018/8/31 17:39, Sahitya Tummala wrote:
> > When dev is busy, discard thread wake up timeout can be aligned with the
> > exact time that it needs to wait for dev to come out of busy. This helps
> > to avoid unnecessary periodic wakeups and thus save some power.
> > 
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > ---
> >  fs/f2fs/segment.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 8bcbb50..df14030 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -1379,6 +1379,8 @@ static int issue_discard_thread(void *data)
> >  	struct discard_policy dpolicy;
> >  	unsigned int wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
> >  	int issued;
> > +	unsigned long interval = sbi->interval_time[REQ_TIME] * HZ;
> > +	long delta;
> >  
> >  	set_freezable();
> >  
> > @@ -1410,7 +1412,11 @@ static int issue_discard_thread(void *data)
> >  			__wait_all_discard_cmd(sbi, &dpolicy);
> >  			wait_ms = dpolicy.min_interval;
> >  		} else if (issued == -1){
> > -			wait_ms = dpolicy.mid_interval;
> > +			delta = (sbi->last_time[REQ_TIME] + interval) - jiffies;
> 
> I agree that we need to consider power consumption. One more consideration is
> that discard thread may need different submission frequency comparing to garbage
> collection thread, maybe a little fast, would it be better to split
> sbi->interval_time[REQ_TIME] according to gc/discard type.
> 
> How do you think?
> 
> Thanks,
> 

Thanks for the review.

You mean when GC type is urgent? I see that for that case, the discard policy is
changed to DPOLICY_FORCE, which sets dpolicy->io_aware as false and hence,
cannot fall into this (issued == -1) case at all.

> > +			if (delta > 0)
> > +				wait_ms = jiffies_to_msecs(delta);
> > +			else
> > +				wait_ms = dpolicy.mid_interval;
> >  		} else {
> >  			wait_ms = dpolicy.max_interval;
> >  		}
> > 

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
