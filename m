From: Matthias Prager <linux@matthiasprager.de>
Subject: Re: [BUG] f2fs: mounting with kernel >= 4.5.0 fails
Date: Mon, 21 Mar 2016 00:52:44 +0100
Message-ID: <56EF37CC.1080907@matthiasprager.de>
References: <56EF1BCF.5010809@matthiasprager.de>
	<20160320224509.GA4752@jaegeuk.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linux@matthiasprager.de>) id 1ahn9V-0003Yb-Dr
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 20 Mar 2016 23:52:57 +0000
Received: from dd15408.kasserver.com ([85.13.136.168])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ahn9T-0002Fr-Um
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 20 Mar 2016 23:52:57 +0000
In-Reply-To: <20160320224509.GA4752@jaegeuk.hsd1.ca.comcast.net>
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

Hello,

thank you for the quick response! The supplied patch indeed fixes the
problem. Kernel 4.5.0 now mounts the fs with 1 GiB section size without
any errors. File transfer also works as it should.

Sidenote: I'm currently testing a Seagate 8TB smr hdd with regards to
performance under different filesystems. f2fs shows by far the most
consistent performance, when used with the mentioned parameters. Great
work this fs!

---
Matthias

Am 20.03.2016 um 23:45 schrieb Jaegeuk Kim:
> Hello,
> 
> Thank you for the report.
> It seems just a simple bug in sanity_check routine.
> 
> Could you please check the attached patch?
> 
> Thanks,
> 
> On Sun, Mar 20, 2016 at 10:53:19PM +0100, Matthias Prager wrote:
>> Hello,
>>
>> since kernel 4.5.0 I'm unable to mount f2fs filesystems with costom
>> section sizes.
>>
>> I use 1 GiB section sizes (for smr-hdds). A filesystem created with the
>> command:
>>
>>> mkfs.f2fs -l test2 -o 0 -a 0 -s 9 /dev/sdj
>>
>> fails to mount in kernel 4.5.0 with the following dmesg output (3TB hdd):
>>> [  263.898973] F2FS-fs (sdj): Wrong MAIN_AREA boundary, start(1502208) end(732566528) blocks(731063808)
>>> [  263.898977] F2FS-fs (sdj): Can't find valid F2FS filesystem in 1th superblock
>>> [  263.899142] F2FS-fs (sdj): Wrong MAIN_AREA boundary, start(1502208) end(732566528) blocks(731063808)
>>> [  263.899144] F2FS-fs (sdj): Can't find valid F2FS filesystem in 2th superblock
>>> [  263.899148] F2FS-fs (sdj): Wrong MAIN_AREA boundary, start(1502208) end(732566528) blocks(731063808)
>>> [  263.899150] F2FS-fs (sdj): Can't find valid F2FS filesystem in 1th superblock
>>> [  263.899152] F2FS-fs (sdj): Wrong MAIN_AREA boundary, start(1502208) end(732566528) blocks(731063808)
>>> [  263.899154] F2FS-fs (sdj): Can't find valid F2FS filesystem in 2th superblock
>>
>> It makes no difference whether the fs is created using kernel 4.5.0 or
>> earlier kernels (f2fs-tools are version 1.6.0 from gentoo stable, I
>> tested kernels 4.1.19, 4.3.3 and 4.4.6).
>>
>> Using the command:
>>
>>> mkfs.f2fs -l test2 -o 0 -a 0 /dev/sdj
>>
>> instead (without the '-s 9' parameter), the fs is mountable with kernel
>> 4.5.0 without any issues.
>>
>> (The other parameters make no difference - i.e. 'mkfs.f2fs /dev/sdj' is
>> fine for kernel 4.5.0, 'mkfs.f2fs -s 9 /dev/sdj' is not. Different
>> custom sections sizes don't seem to make a difference.)
>>
>> Is there a real problem with the fs or are the newly introduced checks
>> in kernel 4.5 simply buggy?
>>
>> ---
>> Matthias
>>
>> ------------------------------------------------------------------------------
>> Transform Data into Opportunity.
>> Accelerate data analysis in your applications with
>> Intel Data Analytics Acceleration Library.
>> Click to learn more.
>> http://pubads.g.doubleclick.net/gampad/clk?id=278785231&iu=/4140
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785231&iu=/4140
