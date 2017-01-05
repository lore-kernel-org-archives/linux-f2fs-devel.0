From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 08/10] f2fs: relax async discard commands more
Date: Thu, 5 Jan 2017 11:59:48 -0800
Message-ID: <20170105195948.GB2064@jaegeuk.local>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
	<20161230185117.3832-8-jaegeuk@kernel.org>
	<a32a776f-00a3-740b-5b62-7137250f4531@huawei.com>
	<f450fd45-1cf9-1969-007e-7cd72b614e08@huawei.com>
	<1bf8505d-2ac4-e635-685d-287bab6ad0e2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cPECc-0005SQ-3z
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 Jan 2017 19:59:58 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cPECa-0001SZ-1f
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 Jan 2017 19:59:58 +0000
Content-Disposition: inline
In-Reply-To: <1bf8505d-2ac4-e635-685d-287bab6ad0e2@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On 01/05, Chao Yu wrote:
> Hi Jaegeuk,
> 
> I can see patch named ("f2fs: call f2fs_wait_all_discard_bio for an error case")
> was merged in dev-test, but I think it's no needed to change error case handling
> like this since f2fs_wait_all_discard_bio should always be called after
> clear_prefree_segments.

Indeed, it's right. ;)

Thanks,

> 
> Thanks,
> 
> On 2017/1/5 11:19, Chao Yu wrote:
> > On 2017/1/4 17:29, Chao Yu wrote:
> >> On 2016/12/31 2:51, Jaegeuk Kim wrote:
> >>> This patch relaxes async discard commands to avoid waiting its end_io during
> >>> checkpoint.
> >>> Instead of waiting them during checkpoint, it will be done when actually reusing
> >>> them.
> >>>
> >>> Test on initial partition of nvme drive.
> >>>
> >>>  # time fstrim /mnt/test
> >>>
> >>> Before : 6.158s
> >>> After : 4.822s
> >>>
> >>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>
> >> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> >>
> >> One comment below,
> > 
> > I still have a comment on this patch.
> > 
> >>> -void f2fs_wait_all_discard_bio(struct f2fs_sb_info *sbi)
> >>> +/* This should be covered by global mutex, &sit_i->sentry_lock */
> >>> +void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, unsigned int segno)
> >>>  {
> >>>  	struct list_head *wait_list = &(SM_I(sbi)->wait_list);
> >>>  	struct bio_entry *be, *tmp;
> >>> @@ -646,7 +650,15 @@ void f2fs_wait_all_discard_bio(struct f2fs_sb_info *sbi)
> >>>  		struct bio *bio = be->bio;
> >>>  		int err;
> >>>  
> >>> -		wait_for_completion_io(&be->event);
> >>> +		if (!completion_done(&be->event)) {
> >>> +			if ((be->start_segno >= segno &&
> >>> +					be->end_segno <= segno) ||
> >>
> >> segno >= be->start_segno && segno < be->end_segno ?
> > 
> > Can you check this?
> > 
> > Thanks,
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
