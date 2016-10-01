From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2 v2] f2fs: use crc and cp version to
 determine roll-forward recovery
Date: Fri, 30 Sep 2016 17:54:49 -0700
Message-ID: <20161001005449.GA63648@jaegeuk>
References: <20160920025504.72524-1-jaegeuk@kernel.org>
	<20160930171005.GC46477@jaegeuk>
	<5758dbdd-610e-64cf-3cef-44794e5b32b4@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bq8Zu-00061O-NA
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 01 Oct 2016 00:54:58 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bq8Zt-0003LL-Kw
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 01 Oct 2016 00:54:58 +0000
Content-Disposition: inline
In-Reply-To: <5758dbdd-610e-64cf-3cef-44794e5b32b4@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Sat, Oct 01, 2016 at 08:26:20AM +0800, Chao Yu wrote:
> On 2016/10/1 1:10, Jaegeuk Kim wrote:
> > @@ -1089,6 +1079,9 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >  	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
> >  		set_ckpt_flags(ckpt, CP_FSCK_FLAG);
> >  
> > +	/* set this flag to activate crc|cp_ver for recovery */
> > +	set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG);
> 
> Should let new introduced spinlock cover the flag updating in ("f2fs: introduce
> cp_lock to protect updating of ckpt_flags").

Fixed.

http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=aaec2b1d18792a5f27b69ff37f34f43f89f5aa3b

Thank you. :)

> 
> Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
