From: Matthias Prager <linux@matthiasprager.de>
Subject: Re: f2fs bug: Unable to mount big volumes in kernel 4.5
Date: Wed, 23 Mar 2016 17:41:57 +0100
Message-ID: <56F2C755.5060402@matthiasprager.de>
References: <56EEC766.2030503@davizone.at>
	<20160320224654.GB4752@jaegeuk.hsd1.ca.comcast.net>
	<00d401d18320$75f94e80$61ebeb80$@samsung.com>
	<56F06067.2060404@davizone.at> <56F07C02.2020106@matthiasprager.de>
	<20160322203613.GA14498@jaegeuk.gateway>
	<56F29214.9040001@davizone.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linux@matthiasprager.de>) id 1ailrF-0002Nl-GL
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Mar 2016 16:42:09 +0000
Received: from dd15408.kasserver.com ([85.13.136.168])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ailrE-0000Rt-0s
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Mar 2016 16:42:09 +0000
In-Reply-To: <56F29214.9040001@davizone.at>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: David Gnedt <david.gnedt@davizone.at>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

Am 23.03.2016 um 13:54 schrieb David Gnedt:
> Hello,
> 
> On 2016-03-22 21:36, Jaegeuk Kim wrote:
>> So, could you check the patch that I replied or the same patch that I attached
>> here?
>> That should dynamically fix this issue when mounting f2fs.
> 
> I had to manually apply the patch on 4.5 sources. I have attached the modified
> patch. If you want, I can also test based on the recent f2fs kernel tree.
> 
> I have used a similar setup as in my last test. The new patch fixes the old
> volumes as expected:
> [144530.446411] F2FS-fs (loop0): Fix alignment : done, start(4063232)
> end(1953505792) block(1949433856)
> [144530.447700] F2FS-fs (loop0): Fix alignment : done, start(4063232)
> end(1953505792) block(1949433856)
> 
> Additionally, the fixed volumes mount without problems on all kernel versions I
> tested: 4.5.0 x86_64, 4.5.0+patchv2 x86_64
> I haven't tried 4.4.6 x86_64 yet, but if you want I can do that later today.
> 
> The only thing that might not be as expected is that the alignment is also fixed
> when the volume is mounted read-only.
I will get to my tests later today, but wanted to comment on this
detail. Writing on a read-only fs is a no go! There usually is a reason
why someone mounts an filesystem read-only and f2fs should not simply
ignore such a flag.

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
