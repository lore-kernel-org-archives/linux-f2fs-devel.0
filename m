From: Chao Yu <yuchaochina@hotmail.com>
Subject: Re: [PATCH] mkfs.f2fs: introduce -b option to support
	specified fs size formating
Date: Sun, 15 Nov 2015 14:34:21 +0800
Message-ID: <COL402-EAS427CA76C7AA32C91A7345BEAB1F0@phx.gbl>
References: <01ab01d11b94$a3231470$e9693d50$@samsung.com>	<5646C76D.3010802@huawei.com>
	<20151114182715.GA44860@KimJaegeukui-MacBook-Air.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchaochina@hotmail.com>) id 1Zxquu-0004J8-Kf
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 15 Nov 2015 06:36:00 +0000
Received: from col004-omc3s2.hotmail.com ([65.55.34.140])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Zxqut-0000Kr-KZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 15 Nov 2015 06:36:00 +0000
In-Reply-To: <20151114182715.GA44860@KimJaegeukui-MacBook-Air.local>
Content-Language: zh-cn
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
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Sunday, November 15, 2015 2:27 AM
> To: He YunLei; He YunLei
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH] mkfs.f2fs: introduce -b option to support specified fs size
> formating
> 
> Hello,
> 
> On Sat, Nov 14, 2015 at 01:32:29PM +0800, He YunLei wrote:
> > hi,
> >
> > We can specify fs size in function f2fs_parse_options as follow:
> >      if ((optind + 1) < argc) {
> >          /* We have a sector count. */
> >          config.total_sectors = atoll(argv[optind+1]);
> > which one is better?
> 
> Yeah, there is.
> I don't think we need to add redundant options.

Actually, Yes, it's redundant.

But what I try to do is introducing an option what can be used more simply by
users of mkfs.f2fs. That means: 1. user do not need take time to calculate
total sector number of our new fs; 2. It will not make any trouble for the user
who does not know the sector size of storage device.

One more intention here is to fix the mismatch between of parameter passed in
_scratch_mkfs_sized and parameter received in mkfs.f2fs. As one is block size,
and another is sector size.

> 
> >
> > Thanks
> >
> > On 2015/11/10 16:48, Chao Yu wrote:
> > > This patch introduces a new option '-b', with this option user can specify
> > > required fs size for formating. _scratch_mkfs_sized in xfstest is one of
> > > user cases.
> 
> We need to add one for f2fs in xfstest.

Yeah, I'm prepare to previously once this patch can be merged.

> Actually, I have a patch pending in my local xfstest.
> Let me submit that sooner or later. :)

Good, glad to see we can make xfstest supporting mkfs_sized for f2fs. :)

Thanks,

> 
> Thanks,
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
