From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: avoid unnecessary fg_gc
Date: Mon, 27 Feb 2017 14:25:45 +0800
Message-ID: <ead88558-08d8-68c7-bfe3-8f14ae5f5a8e@huawei.com>
References: <20170224100135.70000-1-houpengyang@huawei.com>
	<0486c0d4-541c-ee21-c598-6656a291a274@huawei.com>
	<58B0E17C.1030306@huawei.com> <20170225020733.GB50867@jaegeuk.local>
	<ce5a4256-9275-eb89-e188-f5f200b8f77c@huawei.com>
	<20170225193959.GE51627@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1ciEl9-0003Pm-5h
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 06:26:11 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ciEl7-0005Yv-FU
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 06:26:11 +0000
In-Reply-To: <20170225193959.GE51627@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, heyunlei <heyunlei@huawei.com>
Cc: guoweichao@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2017/2/26 3:39, Jaegeuk Kim wrote:
> On 02/25, heyunlei wrote:
>> Hi all,
>>
>> I am really confused by the condition below use sec_freed, is it always equal to zero?
> 
> Seems it is always zero. Let's fix it together.
> 
> Pengyang,
> 
> I merged your patches and finally got this.
> How do you think?
> 
>>From d1c2206e4f245a8fedec3a8f21ad522b3b1b2d0c Mon Sep 17 00:00:00 2001
> From: Hou Pengyang <houpengyang@huawei.com>
> Date: Sat, 25 Feb 2017 03:57:38 +0000
> Subject: [PATCH] f2fs: avoid bggc->fggc when enough free segments are
>  avaliable after cp
> 
> We use has_not_enough_free_secs to check if there are enough free segments,
> 
>     	(free_sections(sbi) + freed) <=
> 	        (node_secs + 2 * dent_secs + imeta_secs +
> 			         reserved_sections(sbi) + needed);
> 
> Under scenario with large number of dirty nodes, these nodes would be flushed
> during cp, as a result, right side of the inequality would be decreased, while
> left side stays unchanged if these nodes are flushed in SSR way, which means
> there are enough free segments after this cp.
> 
> For this case, we just do a bggc instead of fggc.
> 
> Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
