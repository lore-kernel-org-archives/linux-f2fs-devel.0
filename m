From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 10/10] f2fs: return fs_trim if there is no
 candidate
Date: Wed, 22 Feb 2017 18:47:09 -0800
Message-ID: <20170223024709.GC29369@jaegeuk.local>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
	<20161230185117.3832-10-jaegeuk@kernel.org>
	<3ac2d369-bf84-13a6-713d-e5e6e1206993@huawei.com>
	<20170222212639.GB4003@jaegeuk.local>
	<57af549a-0e71-3181-ee0b-0f7c0a0bf87d@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cgjR8-0006nH-EI
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 02:47:18 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cgjR7-0002XP-8C
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 02:47:18 +0000
Content-Disposition: inline
In-Reply-To: <57af549a-0e71-3181-ee0b-0f7c0a0bf87d@huawei.com>
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

On 02/23, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2017/2/23 5:26, Jaegeuk Kim wrote:
...
> >>> +	__u64 trim_start = cpc->trim_start;
> >>
> >> bool has_candidate = false;
> >>
> >>> +
> >>> +	mutex_lock(&SIT_I(sbi)->sentry_lock);
> >>> +	for (; trim_start <= cpc->trim_end; trim_start++)
> >>> +		if (add_discard_addrs(sbi, cpc, true))
> >>> +			break;
> >>
> >> for (; cpc->trim_start <= cpc->trim_end; cpc->trim_start++)
> >> 	if (add_discard_addrs(sbi, cpc, true)) {
> >> 		has_candidate = true;
> >> 		break;
> >> 	}
> > 
> > Why do we need to do like this in which needs additional variable with multiple
> > assignment?
> 
> Because add_discard_addrs will check segment which cpc->trim_start points to,
> but if we do not increase cpc->trim_start in loop, we will always check one
> segment, right?

Yeah~ ;)

> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> >>
> >> cpc->trim_start = trim_start;
> >>
> >>> +	mutex_unlock(&SIT_I(sbi)->sentry_lock);
> >>> +
> >>> +	return trim_start <= cpc->trim_end;
> >>
> >> return has_candidate;
> >>
> >> Thanks,
> >>
> >>> +}
> >>> +
> >>>  int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
> >>>  {
> >>>  	__u64 start = F2FS_BYTES_TO_BLK(range->start);
> >>> @@ -2251,7 +2269,7 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >>>  			/* add discard candidates */
> >>>  			if (cpc->reason != CP_DISCARD) {
> >>>  				cpc->trim_start = segno;
> >>> -				add_discard_addrs(sbi, cpc);
> >>> +				add_discard_addrs(sbi, cpc, false);
> >>>  			}
> >>>  
> >>>  			if (to_journal) {
> >>> @@ -2289,7 +2307,7 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >>>  		__u64 trim_start = cpc->trim_start;
> >>>  
> >>>  		for (; cpc->trim_start <= cpc->trim_end; cpc->trim_start++)
> >>> -			add_discard_addrs(sbi, cpc);
> >>> +			add_discard_addrs(sbi, cpc, false);
> >>>  
> >>>  		cpc->trim_start = trim_start;
> >>>  	}
> >>>
> >>
> >>
> >> ------------------------------------------------------------------------------
> >> Check out the vibrant tech community on one of the world's most
> >> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> >> _______________________________________________
> >> Linux-f2fs-devel mailing list
> >> Linux-f2fs-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 
> > .
> > 
> 
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
