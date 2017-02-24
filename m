From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH] f2fs: no need lock_op in
	f2fs_write_inline_data
Date: Fri, 24 Feb 2017 11:29:18 +0800
Message-ID: <0e037d54-9f45-d38b-da91-b5765fa83a62@huawei.com>
References: <20170223123120.18842-1-heyunlei@huawei.com>
	<20170223194529.GE2026@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1ch6aj-0000qH-8Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Feb 2017 03:30:45 +0000
Received: from [45.249.212.190] (helo=dggrg04-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ch6ai-0007qm-2r
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Feb 2017 03:30:45 +0000
In-Reply-To: <20170223194529.GE2026@jaegeuk.local>
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
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

	Can you explain more about this? Besides, how about inplace update?
	

On 2017/2/24 3:45, Jaegeuk Kim wrote:
> In this case, however, I don't think we
> can do like this.


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
