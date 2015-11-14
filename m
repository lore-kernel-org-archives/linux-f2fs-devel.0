From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] mkfs.f2fs: introduce -b option to support
 specified fs size formating
Date: Sat, 14 Nov 2015 10:27:15 -0800
Message-ID: <20151114182715.GA44860@KimJaegeukui-MacBook-Air.local>
References: <01ab01d11b94$a3231470$e9693d50$@samsung.com>
	<5646C76D.3010802@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZxfXn-0004Z5-9a
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 14 Nov 2015 18:27:23 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZxfXm-0001Ui-DJ for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 14 Nov 2015 18:27:23 +0000
Content-Disposition: inline
In-Reply-To: <5646C76D.3010802@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: He YunLei <heyunlei@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hello,

On Sat, Nov 14, 2015 at 01:32:29PM +0800, He YunLei wrote:
> hi,
> 
> We can specify fs size in function f2fs_parse_options as follow:
>      if ((optind + 1) < argc) {
>          /* We have a sector count. */
>          config.total_sectors = atoll(argv[optind+1]);
> which one is better?

Yeah, there is.
I don't think we need to add redundant options.

> 
> Thanks
> 
> On 2015/11/10 16:48, Chao Yu wrote:
> > This patch introduces a new option '-b', with this option user can specify
> > required fs size for formating. _scratch_mkfs_sized in xfstest is one of
> > user cases.

We need to add one for f2fs in xfstest.
Actually, I have a patch pending in my local xfstest.
Let me submit that sooner or later. :)

Thanks,

------------------------------------------------------------------------------
