From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH] f2fs: avoid unnecessary fg_gc
Date: Mon, 27 Feb 2017 10:28:26 +0800
Message-ID: <094e099e-e97d-8eaa-fdcf-e62434f4b4f0@huawei.com>
References: <20170224100135.70000-1-houpengyang@huawei.com>
	<0486c0d4-541c-ee21-c598-6656a291a274@huawei.com>
	<58B0E17C.1030306@huawei.com> <20170225020733.GB50867@jaegeuk.local>
	<ce5a4256-9275-eb89-e188-f5f200b8f77c@huawei.com>
	<20170225193959.GE51627@jaegeuk.local> <58B387ED.8080700@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1ciB4q-0005RH-IM
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 02:30:16 +0000
Received: from [45.249.212.190] (helo=dggrg04-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ciB4n-00019N-FG
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 02:30:16 +0000
In-Reply-To: <58B387ED.8080700@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Hou Pengyang <houpengyang@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: guoweichao@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On 2017/2/27 9:59, Hou Pengyang wrote:
> We use has_not_enough_free_secs to check if there are enough free segments,
>
>          (free_sections(sbi) + freed) <=
>             (node_secs + 2 * dent_secs + imeta_secs +
>                      reserved_sections(sbi) + needed);

Now node SSR is enable, how can we change this condition simply as:

	(free_sections(sbi) + freed) <= reserved_sections(sbi)

If dirty node pages can find SSR segment, write it in SSR mode,

or it will consume free segments, and then we do FG_GC.



Another thing is that each process has a chance to do FG_GC, it's no problem

for all normal processes, but may be not a good thing for a process within

certain limits such as lower priority, with bound cpu to do FG_GC. Maybe it

will block system for a long time. So what can we do to improve this?

Thanks.



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
