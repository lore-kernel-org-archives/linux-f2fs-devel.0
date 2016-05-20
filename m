From: Chao Yu <chao@kernel.org>
Subject: Re: Kernel OOPS in f2fs-stable on ARM
Date: Sat, 21 May 2016 00:20:30 +0800
Message-ID: <4bc7dc8c-9e08-b36a-01d0-f2e50d42a4e8@kernel.org>
References: <d47e3dc22666855cd3941a9a6808a450@mail.tophosting.at>
	<571CCF50.2070603@kernel.org>
	<47ad19eec862bf788de5636e58d897b0@mail.tophosting.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1b3nAO-0006CU-UH
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 20 May 2016 16:20:48 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b3nAO-0007Ej-6f
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 20 May 2016 16:20:48 +0000
In-Reply-To: <47ad19eec862bf788de5636e58d897b0@mail.tophosting.at>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Georg Veichtlbauer <georg@veichtlbauer.net>, Jaegeuk Kim <jaegeuk@kernel.org>, Hou Pengyang <houpengyang@huawei.com>, Yunlong Song <yunlong.song@huawei.com>, bintian.wang@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi all,

I found a bug related to panic issue in ->evict_inode, I sent a patch for
fixing, I hope the patch can fix your problem, could you review or test it?

Thanks,

On 2016/5/19 0:58, Georg Veichtlbauer wrote:
> Hi,
> sorry for the late reply. Unfortunately, that patch did not fix the issue. Many
> other devices are having this problem, so my fellow CM maintainers start
> reverting to an old stable release. I'd prefer fixing the issue though.... ideas?
> Cheers,
> georg

------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
