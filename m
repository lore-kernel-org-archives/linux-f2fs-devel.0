From: William Brana <wbrana@gmail.com>
Subject: Re: 4.9.23: hang on sync
Date: Thu, 20 Apr 2017 17:16:47 +0200
Message-ID: <CAJ7jCmnV_Ru2Rm9eTZ5QO6GRPZ8sJiM_L5Fe9veg95CeJ35QZw@mail.gmail.com>
References: <CAJ7jCmkr3eD3V+GHMQXV2Erd3tq6ByXb=j5a2hQF9sy6+7RT8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wbrana@gmail.com>) id 1d1DpJ-0008CG-7p
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 20 Apr 2017 15:16:57 +0000
Received: from mail-ua0-f180.google.com ([209.85.217.180])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1d1DpF-0007Ab-GH
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 20 Apr 2017 15:16:57 +0000
Received: by mail-ua0-f180.google.com with SMTP id a1so54531628uaf.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 20 Apr 2017 08:16:53 -0700 (PDT)
In-Reply-To: <CAJ7jCmkr3eD3V+GHMQXV2Erd3tq6ByXb=j5a2hQF9sy6+7RT8g@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

steps to reproduce:
1) mkfs
2) mount
3) untar
4) sync
sync seems to write huge amount of data with size which exceeds size
of partition
it seems to related to -s 12 ( 24 MB is block size of SSD )

On 4/20/17, William Brana <wbrana@gmail.com> wrote:
> command sync was hung with
> partition size: 2 GB
> mkfs.f2fs -s 12
> 400 MB of small files
> https://gentoo.osuosl.org/snapshots/portage-latest.tar.xz
>

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
