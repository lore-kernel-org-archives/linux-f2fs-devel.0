From: Jun He <jhe@cs.wisc.edu>
Subject: Re: Invoke GC by user?
Date: Sat, 14 May 2016 10:16:51 -0500
Message-ID: <CABW1wHT1o3eph05=rnFWLZ8OVq7pK2gcy9zy2KT8p+W7aEHaFw@mail.gmail.com>
References: <CABW1wHRZddgZsbBwqT3W1rLkNz9R6Dw7u=3ozpVy26x7_rfYDg@mail.gmail.com>
	<20160513170507.GA27525@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jun.n.he@gmail.com>) id 1b1bJx-0004ZR-26
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 14 May 2016 15:17:37 +0000
Received: from mail-oi0-f45.google.com ([209.85.218.45])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1b1bJw-0001In-8B
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 14 May 2016 15:17:37 +0000
Received: by mail-oi0-f45.google.com with SMTP id k142so212515495oib.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 14 May 2016 08:17:36 -0700 (PDT)
In-Reply-To: <20160513170507.GA27525@jaegeuk.gateway>
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

Thanks. I'll try.

Jun

On Fri, May 13, 2016 at 12:05 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> Hello,
>
> On Fri, May 13, 2016 at 11:47:29AM -0500, Jun He wrote:
>> Hi,
>>
>> I understand that "F2FS does cleaning both on demand and in the
>> background. On-demand cleaning is triggered when there are not enough
>> free segments to serve VFS calls". Is there any way to start GC to
>> clean all garbage even when the free segments are enough?
>
> There are two ways.
> 1. mount option: -o background_gc=sync
>   This will invoke forground gc instead of background one periodically.
>
> 2. ->ioctl(F2FS_IOC_GARBAGE_COLLECT)
>   This can invoke one round of forground or background gc by user directly.
>
> Thanks,
>
>>
>> Thanks,
>> Jun
>>
>> ------------------------------------------------------------------------------
>> Mobile security can be enabling, not merely restricting. Employees who
>> bring their own devices (BYOD) to work are irked by the imposition of MDM
>> restrictions. Mobile Device Manager Plus allows you to control only the
>> apps on BYO-devices by containerizing them, leaving personal data untouched!
>> https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
