From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] back-up raw_super in sbi
Date: Tue, 15 Dec 2015 17:04:40 +0800
Message-ID: <010301d13717$bcd8df00$368a9d00$@samsung.com>
References: <1449580633-17880-1-git-send-email-heyunlei@huawei.com>
	<20151208181902.GA10025@jaegeuk.local> <566E9261.8040702@huawei.com>
	<20151214172845.GB48918@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1a8lY7-00089J-Pp
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 09:05:35 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a8lY6-0004Sc-84
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 09:05:35 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZE02XYB6L2HE50@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 18:05:26 +0900 (KST)
In-reply-to: <20151214172845.GB48918@jaegeuk.local>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'He YunLei' <heyunlei@huawei.com>
Cc: hebiao6@huawei.com, stuart.li@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Hi all,

> > It looks good to me, but can we releasing grabbed block buffer 'sbi->raw_super_buf'
> > as Chao Yu said.
> 
> If then, don't we need to recover the polluted superblock?

We need, if we change to not grab super block buffer header, instead,
we have to record current super block no that raw_super referred to,
then in f2fs_commit_super we can try to grab block buffer of super block
with stored no.

Could you check the following patches?

Thanks,


------------------------------------------------------------------------------
