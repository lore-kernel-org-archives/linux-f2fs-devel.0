From: Matthias Prager <linux@matthiasprager.de>
Subject: Re: f2fs bug: Unable to mount big volumes in kernel 4.5
Date: Mon, 21 Mar 2016 10:58:49 +0100
Message-ID: <56EFC5D9.4060609@matthiasprager.de>
References: <56EEC766.2030503@davizone.at>
	<20160320224654.GB4752@jaegeuk.hsd1.ca.comcast.net>
	<00d401d18320$75f94e80$61ebeb80$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linux@matthiasprager.de>) id 1ahwc0-0007aE-WA
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Mar 2016 09:59:01 +0000
Received: from dd15408.kasserver.com ([85.13.136.168])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ahwbz-00014I-6E
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Mar 2016 09:59:00 +0000
In-Reply-To: <00d401d18320$75f94e80$61ebeb80$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'David Gnedt' <david.gnedt@davizone.at>
Cc: linux-f2fs-devel@lists.sourceforge.net

Am 21.03.2016 um 04:18 schrieb Chao Yu:
> Hi all,
> 
>> -----Original Message-----
>> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
>> Sent: Monday, March 21, 2016 6:47 AM
>> To: David Gnedt
>> Cc: Chao Yu
>> Subject: Re: f2fs bug: Unable to mount big volumes in kernel 4.5
>>
>> Hello,
>>
>> As you pointed out, it seems there is a bug in sanity check routine, which
>> doesn't cover the large section case.
> 
> Actually, there is a bug in f2fs-tools 1.6.0, it will trigger sanity check failure
> in f2fs kernel module since in mkfs.f2fs we will align segment_count and
> segment_count_main with different size if parameter -s or -z is configured larger
> than 1.
> 
> Following commit in dev branch of f2fs-tools has fixed this issue, could you test this
> patch firstly?
> ("mkfs.f2fs: set segment_count in super block correctly")
I just did (with an unpatched 4.5.0 kernel) and with this f2f2-tools
patch applied a newly created fs with '-s 9' does mount without errors.

There seem to be quite a few interesting commits in the f2fs-tools dev
tree. Is a new release of f2fs-tools planned soon?

> 
> Thanks,
> 
>>
>> Could you test the attached patch?
>>
>> Thanks,
>>
>> On Sun, Mar 20, 2016 at 04:53:10PM +0100, David Gnedt wrote:
>>> Hello,
>>>
>>> I have a problem with mounting a very big f2fs volume (8TB Seagate SMR drive) in
>>> kernel 4.5. It works without any problems in 4.4.6, but with 4.5 I get errors
>>> during mount (see attached file smr_log.txt).
>>>
>>> I have created the volume with f2fs-tools 1.6.0 and also a fsck works without
>>> any problems (see attached file smr_fsck.txt).
>>>
>>> I suspect the following commit to be the cause:
>>>
>>> commit 9a59b62fd88196844cee5fff851bee2cfd7afb6e
>>> f2fs: do more integrity verification for superblock
>>>
>>>
>> https://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git/commit/fs/f2fs/super.c?id=9a
>> 59b62fd88196844cee5fff851bee2cfd7afb6e
>>>
>>> I haven't had time to dig deeper, but my guess is that the volume is too big, so
>>> that the 32bit integers overflow during the new check routine
>>> sanity_check_area_boundary().
>>>
>>> Please let me know, if you need any more information. F2fs is currently the only
>>> filesystem that really works on those SMR drives, therefore it is an important
>>> issue to me.
>>>
>>> Best regards,
>>> David Gnedt
>>
>>> [437136.843299] F2FS-fs (dm-7): Wrong MAIN_AREA boundary, start(4063232) end(1953505792)
>> blocks(1949433856)
>>> [437136.843302] F2FS-fs (dm-7): Can't find valid F2FS filesystem in 1th superblock
>>> [437136.843418] F2FS-fs (dm-7): Wrong MAIN_AREA boundary, start(4063232) end(1953505792)
>> blocks(1949433856)
>>> [437136.843419] F2FS-fs (dm-7): Can't find valid F2FS filesystem in 2th superblock
>>> [437136.843420] F2FS-fs (dm-7): Wrong MAIN_AREA boundary, start(4063232) end(1953505792)
>> blocks(1949433856)
>>> [437136.843421] F2FS-fs (dm-7): Can't find valid F2FS filesystem in 1th superblock
>>> [437136.843422] F2FS-fs (dm-7): Wrong MAIN_AREA boundary, start(4063232) end(1953505792)
>> blocks(1949433856)
>>> [437136.843422] F2FS-fs (dm-7): Can't find valid F2FS filesystem in 2th superblock
>>
>>> Info: sector size = 512
>>> Info: total sectors = 15628046336 (7630882 MB)
>>> Info: MKFS version
>>>   "Linux version 4.4.0-040400-generic (kernel@gomeisa) (gcc version 5.2.1 20151010 (Ubuntu
>> 5.2.1-22ubuntu2) ) #201601101930 SMP Mon Jan 11 00:32:41 UTC 2016"
>>> Info: FSCK version
>>>   from "Linux version 4.4.0-040400-generic (kernel@gomeisa) (gcc version 5.2.1 20151010
>> (Ubuntu 5.2.1-22ubuntu2) ) #201601101930 SMP Mon Jan 11 00:32:41 UTC 2016"
>>>     to "Linux version 4.5.0-040500-generic (kernel@tangerine) (gcc version 5.2.1 20151010
>> (Ubuntu 5.2.1-22ubuntu2) ) #201603140130 SMP Mon Mar 14 05:32:22 UTC 2016"
>>> Info: superblock features = 0 :
>>> Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
>>> Info: total FS sectors = 15628046336 (7630882 MB)
>>> Info: CKPT version = 122a
>>> Info: checkpoint state = 1 :  unmount
>>>
>>> [FSCK] Unreachable nat entries                        [Ok..] [0x0]
>>> [FSCK] SIT valid block bitmap checking                [Ok..]
>>> [FSCK] Hard link checking for regular file            [Ok..] [0x0]
>>> [FSCK] valid_block_count matching with CP             [Ok..] [0x57cea239]
>>> [FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0x61b3bd]
>>> [FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x61b3bd]
>>> [FSCK] valid_inode_count matched with CP              [Ok..] [0x4c0a61]
>>> [FSCK] free segment_count matched with CP             [Ok..] [0xe31ac]
>>> [FSCK] next block offset is free                      [Ok..]
>>> [FSCK] fixing SIT types
>>> [FSCK] other corrupted bugs                           [Ok..]
>>>
>>> Done.
> 


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
