From: Matthias Prager <linux@matthiasprager.de>
Subject: Re: f2fs bug: Unable to mount big volumes in kernel 4.5
Date: Mon, 21 Mar 2016 23:56:02 +0100
Message-ID: <56F07C02.2020106@matthiasprager.de>
References: <56EEC766.2030503@davizone.at>
	<20160320224654.GB4752@jaegeuk.hsd1.ca.comcast.net>
	<00d401d18320$75f94e80$61ebeb80$@samsung.com>
	<56F06067.2060404@davizone.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linux@matthiasprager.de>) id 1ai8k9-000780-2R
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Mar 2016 22:56:13 +0000
Received: from dd15408.kasserver.com ([85.13.136.168])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ai8k7-00042o-NP
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Mar 2016 22:56:13 +0000
In-Reply-To: <56F06067.2060404@davizone.at>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: David Gnedt <david.gnedt@davizone.at>, Chao Yu <chao2.yu@samsung.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hello everyone,

if there really is a suboptimal/faulty alignment being done by
f2fs-tools <=1.6.0 (and I haven't done the math, so I'm just assuming),
wouldn't it be prudent to include a modified kernel patch, which allows
for mounting of older filesystems, but puts out a warning in dmesg which
advises the user to run fsck.f2fs some time in the future?

---
Matthias

Am 21.03.2016 um 21:58 schrieb David Gnedt:
> Hello,
> 
>> Following commit in dev branch of f2fs-tools has fixed this issue, could you
> test this
>> patch firstly?
>> ("mkfs.f2fs: set segment_count in super block correctly")
> 
> Sorry, I cannot recreate the volume on the 8TB Seagate drive right now, but I
> did a test with a loopback device of equal size.
> 
> Should I be worried about the changes in mkfs.f2fs since 1.6.0? Would it be
> suggested to recreate the filesystem? Or is it maybe possible to manually fix it?
> If it is really only the alignment, I think it shouldn't matter for SMR drives,
> as they are not using constant size zones anyway, so misalignment cannot be
> avoided with f2fs.
> 
>>> Could you test the attached patch?
> 
> I did a roundup test of all kernel/f2fs-tools version I thought that make sense.
> I hope the patch will be included in upcoming mainline kernels.
> 
> Short summary:
> --------------
> Filesystems created with a recent dev version of f2fs-tools work without any
> problems and don't need the f2fs kernel patch.
> Filesystems created with older f2fs-tools need the f2fs kernel patch to mount
> correctly.
> I guess that is exactly what everyone expected to be the outcome.
> 
> Full details:
> -------------
> f2fs-tools D:  release 1.6.0 (Seagate SMR drive)
> f2fs-tools L1: release 1.6.0 (Loopback)
> f2fs-tools L2: 2016-01-08 mkfs.f2fs: introduce zone align for main area (Loopback)
> f2fs-tools L3: 2016-03-16 mkfs.f2fs: set segment_count in super block correctly
> (Loopback)
> 
> Test procedure:
> $ truncate -s 8001559724032 f2fs-tools-1.6.0.img
> $ losetup -f f2fs-tools-1.6.0.img
> $ mkfs.f2fs -s64 -t0 -a0 /dev/loop0
> $ mount -t f2fs -onoinline_data,noatime,flush_merge,no_heap,ro /dev/loop0 /mnt
> $ umount /mnt
> 
> Kernel: Linux 4.4.6 x86_64
> f2fs-tools D:  Works
> f2fs-tools L1: Works
> f2fs-tools L2: Works
> f2fs-tools L3: Works
> 
> Kernel: Linux 4.5.0 x86_64
> f2fs-tools D:  Failed -> Same errors as before
> f2fs-tools L1: Failed -> Same errors as before
> f2fs-tools L2: Failed -> Same errors as before
> f2fs-tools L3: Works
> 
> Kernel: Linux 4.5.0+patch x86_64
> f2fs-tools D:  Works
> f2fs-tools L1: Works
> f2fs-tools L2: Works
> f2fs-tools L3: Works
> 
> Best regards,
> David Gnedt
> 


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
