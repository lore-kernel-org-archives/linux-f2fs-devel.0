From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: avoid unnecessary fg_gc
Date: Mon, 27 Feb 2017 15:40:43 -0800
Message-ID: <20170227234043.GB9644@jaegeuk.local>
References: <20170224100135.70000-1-houpengyang@huawei.com>
	<0486c0d4-541c-ee21-c598-6656a291a274@huawei.com>
	<58B0E17C.1030306@huawei.com>
	<20170225020733.GB50867@jaegeuk.local>
	<ce5a4256-9275-eb89-e188-f5f200b8f77c@huawei.com>
	<20170225193959.GE51627@jaegeuk.local>
	<58B387ED.8080700@huawei.com>
	<094e099e-e97d-8eaa-fdcf-e62434f4b4f0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ciUuS-0007fH-Pc
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 23:40:52 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ciUuR-0001IK-SV
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 23:40:52 +0000
Content-Disposition: inline
In-Reply-To: <094e099e-e97d-8eaa-fdcf-e62434f4b4f0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: heyunlei <heyunlei@huawei.com>
Cc: guoweichao@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 02/27, heyunlei wrote:
> Hi Jaegeuk,
> 
> On 2017/2/27 9:59, Hou Pengyang wrote:
> > We use has_not_enough_free_secs to check if there are enough free segments,
> > 
> >          (free_sections(sbi) + freed) <=
> >             (node_secs + 2 * dent_secs + imeta_secs +
> >                      reserved_sections(sbi) + needed);
> 
> Now node SSR is enable, how can we change this condition simply as:
> 
> 	(free_sections(sbi) + freed) <= reserved_sections(sbi)

Currently, we can't guarantee successful SSR allocation all the time.

> If dirty node pages can find SSR segment, write it in SSR mode,
> 
> or it will consume free segments, and then we do FG_GC.
> 
> 
> 
> Another thing is that each process has a chance to do FG_GC, it's no problem
> 
> for all normal processes, but may be not a good thing for a process within
> 
> certain limits such as lower priority, with bound cpu to do FG_GC. Maybe it
> 
> will block system for a long time. So what can we do to improve this?

Could you please elaborate this in more detail?

Thanks,

> 
> Thanks.
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
