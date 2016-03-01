From: Keith Mok <ek9852@gmail.com>
Subject: Re: [PATCH] f2fs: Use crypto crc32 functions
Date: Tue, 1 Mar 2016 08:52:12 -0800
Message-ID: <CAHjoi4d-qntAVo84=oW0bZu5Lw7dQKq=SLy7W_e+HPh7dd_9oQ@mail.gmail.com>
References: <1456787577-59946-1-git-send-email-kmok@cyngn.com>
	<00d201d1739b$96fca580$c4f5f080$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ek9852@gmail.com>) id 1aanX1-0006m8-LK
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Mar 2016 16:52:19 +0000
Received: from mail-yk0-f173.google.com ([209.85.160.173])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aanWz-00045v-S2
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Mar 2016 16:52:19 +0000
Received: by mail-yk0-f173.google.com with SMTP id 1so5579180ykg.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 01 Mar 2016 08:52:17 -0800 (PST)
In-Reply-To: <00d201d1739b$96fca580$c4f5f080$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: jaegeuk@kernel.org, Keith Mok <kmok@cyngn.com>, linux-f2fs-devel@lists.sourceforge.net

Hi,

> f2fs_crc32/f2fs_crc_valid won't been invoked very often, so I don't think
that would cause much overhead in calculation and make things slow.
Right, the gain is not that big. But I think it still worth it. That's
not much code changes for it.

> Moreover, we could suffer crash if any error occurrs in crypto_shash_update, that would be a regression.
ext4 uses that and ext4 is used more widely than f2fs, haven't seem
any people complaint about that.

Thanks,

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
