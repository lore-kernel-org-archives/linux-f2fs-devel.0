From: Chao Yu <chao@kernel.org>
Subject: Re: video archive on a microSD card
Date: Wed, 17 Aug 2016 23:54:28 +0800
Message-ID: <bd0fc9a6-03d3-e32c-f6c7-f64d4ba8506e@kernel.org>
References: <146631471002747@web20h.yandex.ru>
	<281281471258049@web6h.yandex.ru>
	<eac97eb4-6b4a-a987-48e9-72680238e50a@huawei.com>
	<7021471263772@web16m.yandex.ru> <158901471427237@web4g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1ba3B0-00080q-MR
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 17 Aug 2016 15:54:46 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ba3Az-0000PO-1Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 17 Aug 2016 15:54:46 +0000
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id C49502012D
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 17 Aug 2016 15:54:37 +0000 (UTC)
Received: from [192.168.1.101] (unknown [49.77.128.92])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 9AB24201C8
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 17 Aug 2016 15:54:35 +0000 (UTC)
In-Reply-To: <158901471427237@web4g.yandex.ru>
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

Hi Alexander,

On 2016/8/17 17:47, Alexander Gordeev wrote:
> Hi Chao,
> 
>> On 2016/8/15 20:22, Alexander Gordeev wrote:
>>> 15.08.2016, 14:58, "Chao Yu" <yuch...@huawei.com>:
>>>> Hi Alexander,
>>>>
>>>> On 2016/8/15 18:47, Alexander Gordeev wrote:
>>>>>  Hi All,
>>>>>
>>>>>  12.08.2016, 14:52, "Alexander Gordeev" <a...@gordick.net>:
>>>>>>  Hi All,
>>>>>>
>>>>>>  I hope I'm writing to the right mailing list. If not please give me 
>>>>>> directions to the right place.
>>>>>>  I'm trying to write video archive to a microSD card on an ARM based IP 
>>>>>> camera. The camera's SDK uses Linux 3.10.
>>>>>>  The kernel is quite old and F2FS is there since 3.8 AFAIK so it's 
>>>>>> probably not mature yet. However, I decided to give it a try.
>>>>>>  The idea is to write video continuously in 5 minute chunks. I also have 
>>>>>> an index file per each archive chunk file to for faster seeks and a single 
>>>>>> SQLite database.
>>>>>>  When utilization is about 95%, the chunks and their indexes from the 
>>>>>> archive tail are deleted. So it's like a ring buffer. Also the 
>>>>>> overprovision ratio is the default 5%.
>>>>>>  It worked quite good for several days with about 95% utilization, but 
>>>>>> then today it went bad. Writes are taking several seconds quite often as 
>>>>>> shown by strace.
>>>>>>  vmstat shows that my process waits for IO most of the time:
>>>>>>
>>>>>>  procs -----------memory---------- ---swap-- -----io---- -system-- 
>>>>>> ----cpu----
>>>>>>   r b swpd free buff cache si so bi bo in cs us sy id wa
>>>>>>   2 2 0 6352 4 35924 0 0 8 88 562 1316 41 7 0 52
>>>>>>   1 2 0 6324 4 35928 0 0 4 44 553 1231 40 8 0 52
>>>>>>   1 2 0 6324 4 35928 0 0 0 0 690 1471 36 10 0 54
>>>>>>   1 3 0 6296 4 35932 0 0 0 0 530 1242 40 5 0 54
>>>>>>   2 2 0 6296 4 35936 0 0 4 48 545 1244 40 6 0 54
>>>>>>   1 2 0 6296 4 35940 0 0 4 44 549 1275 39 6 0 55
>>>>>>   2 2 0 6288 4 35944 0 0 4 44 563 1315 39 8 0 53
>>>>>>   3 2 0 6296 4 35944 0 0 0 0 502 1158 41 2 0 57
>>>>>>   1 3 0 6296 4 35952 0 0 8 88 700 1527 40 9 0 51
>>>>>>   1 2 0 6296 4 35952 0 0 0 0 482 1141 38 8 0 55
>>>>>>   1 2 0 6296 4 35956 0 0 4 44 594 1383 38 13 0 49
>>>>>>   1 2 0 6296 4 35956 0 0 0 0 489 1160 37 5 0 58
>>>>>>   5 1 0 6268 4 35980 0 0 12 132 704 1565 42 9 0 49
>>>>>>   2 1 0 6268 4 35984 0 0 4 44 531 1215 39 10 0 51
>>>>>>   3 2 0 6268 4 35992 0 0 8 92 714 1574 36 9 0 55
>>>>>>   1 1 0 6268 4 35992 0 0 0 0 485 1163 39 6 0 55
>>>>>>   1 1 0 6240 4 36000 0 0 8 92 553 1282 38 9 0 53
>>>>>>   1 2 0 6240 4 36000 0 0 0 0 488 1135 39 7 0 54
>>>>>>   1 1 0 6240 4 36000 0 0 0 0 552 1264 39 9 0 52
>>>>>>   3 1 0 6240 4 36000 0 0 0 0 510 1187 40 6 0 54
>>>>>>   1 2 0 6240 4 36004 0 0 4 44 674 1496 43 8 0 49
>>>>>>   1 1 0 6240 4 36012 0 0 8 88 572 1373 39 9 0 53
>>>>>>   4 1 0 6232 4 36016 0 0 4 48 549 1248 41 4 0 55
>>>>>>   3 1 0 6240 4 36016 0 0 0 0 520 1209 36 8 0 55
>>>>>>
>>>>>>  Here is also /sys/kernel/debug/f2fs/status for reference:
>>>>>>  =====[ partition info(sda). #0 ]=====
>>>>>>  [SB: 1] [CP: 2] [SIT: 4] [NAT: 118] [SSA: 60] [MAIN: 29646(OverProv:1529 
>>>>>> Resv:50)]
>>>>>>
>>>>>>  Utilization: 94% (13597314 valid blocks)
>>>>>>    - Node: 16395 (Inode: 2913, Other: 13482)
>>>>>>    - Data: 13580919
>>>>>>
>>>>>>  Main area: 29646 segs, 14823 secs 14823 zones
>>>>>>    - COLD data: 3468, 1734, 1734
>>>>>>    - WARM data: 12954, 6477, 6477
>>>>>>    - HOT data: 28105, 14052, 14052
>>>>>>    - Dir dnode: 29204, 14602, 14602
>>>>>>    - File dnode: 19960, 9980, 9980
>>>>>>    - Indir nodes: 29623, 14811, 14811
>>>>>>
>>>>>>    - Valid: 13615
>>>>>>    - Dirty: 13309
>>>>>>    - Prefree: 0
>>>>>>    - Free: 2722 (763)
>>>>>>
>>>>>>  GC calls: 8622 (BG: 4311)
>>>>>>    - data segments : 8560
>>>>>>    - node segments : 62
>>>>>>  Try to move 3552161 blocks
>>>>>>    - data blocks : 3540278
>>>>>>    - node blocks : 11883
>>>>>>
>>>>>>  Extent Hit Ratio: 49 / 4171
>>>>>>
>>>>>>  Balancing F2FS Async:
>>>>>>    - nodes 6 in 141
>>>>>>    - dents 0 in dirs: 0
>>>>>>    - meta 13 in 346
>>>>>>    - NATs 16983 > 29120
>>>>>>    - SITs: 17
>>>>>>    - free_nids: 1861
>>>>>>
>>>>>>  Distribution of User Blocks: [ valid | invalid | free ]
>>>>>>    [-----------------------------------------------|-|--]
>>>>>>
>>>>>>  SSR: 1230719 blocks in 14834 segments
>>>>>>  LFS: 15150190 blocks in 29589 segments
>>>>>>
>>>>>>  BDF: 89, avg. vblocks: 949
>>>>>>
>>>>>>  Memory: 6754 KB = static: 4763 + cached: 1990
>>>>>>
>>>>>>  Please note that I tried to put all the archive and index files into the 
>>>>>> cold area using the file extensions mechanism.
>>>>>>  And indeed I saw numbers close to the total amount of segments in the 
>>>>>> cold area a couple of days ago.
>>>>>>  But now the cold area gets smaller very quickly. What am I doing wrong?
>>>>
>>>> How could you know the cold area is getting smaller? if it is looks as you 
>>>> said,
>>>> the behavior of f2fs seems not reasonable.
>>>
>>> I'm not sure about this. I just saw numbers after "COLD data: "  above to be 
>>> quite close to the total amount after "Main area:".
>>
>> Hmm.. number after "COLD data:" means No. of current cold segment, section and 
>> zone.
>>
>>> This is quite reasonable because I tried to the video files into the cold 
>>> area. So the cold area should take almost all the device.
>>> The idea is to separate video files from SQLite database writes. I got to 
>>> this idea while reading some docs on f2fs.
>>
>> I think this would be a good idea if SQLite db files and idx&video file have
>> different updating frequency.
> 
> Yes, their times of life are quite different probably. I don't know exactly how
> SQLite manages its db files. I think it's not append only. So I thought that it
> would be a right idea to separate the other files, that I'm in total control
> of, from SQLite db file.
> 
> My video archive and index files are written in append-only manner. They are
> never overwritten. They can only be deleted when the archive is rotated.

Will video archive and index file be appended to size which is unaligned to 4k,
and later, be appended continuously?

> Per my understanding of f2fs internals, it should write these "cold" files and
> usual "hot" files to different sections (that should map internally to
> different allocation units). So the sections used by "cold" data should almost
> never get "dirty" because most of the time all their blocks become free at
> the same time. Of course, the files are not exactly 4MB in size so the last
> section of the deleted file will become dirty. If it is moved by garbage
> collector and becomes mixed with fresh "cold" data, then indeed it might cause
> some problems, I think. What is your opinion?

If your fs is not fragmented, it may be as what you said, otherwise, SSR will
still try to reuse invalid block of other temperture segments, then your cold
data will be fixed with warm data too.

I guess, what you are facing is the latter one:
SSR: 1230719 blocks in 14834 segments

Maybe we can try to alter updating policy from OPU to IPU for your case to avoid
performance regression of SSR and more frequently FG-GC:

echo 1 > /sys/fs/f2fs/"yourdevicename"/ipu_policy

Thanks,

> 
> Maybe disabling garbage collection for "cold" data may help?
> 
>>>>>>  Can this be fixed by using a backport from 
>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-stable.git ?
>>>>>>  Also I measured the SD card erase block size using flashbench. It seems 
>>>>>> it is 8MB, not 4MB, as I used here.
>>>>>>  Can this lead to such serious problems? Is 8MB block safe to hardcode or 
>>>>>> should I use flashbench every time?
>>>>
>>>> I think 4MB is OK, if we set section size to 8MB, it will make us 
>>>> encountering
>>>> long latency of most operation due to foreground GC in where we may move more
>>>> blocks in one section.
>>>
>>> I see. I thought I have to align the section to the internal flash erase 
>>> block size.
>>> Actually, my problem is the increased latency after several days of rotating 
>>> the archive a 95% utilization.
>>
>>   - Valid: 15671
>>   - Dirty: 12904
>>   - Prefree: 0
>>   - Free: 1071 (27)
>>
>> CP calls: 3320 (BG: 0)
>> GC calls: 2240 (BG: 1)
>>   - data segments : 3866 (1236)
>>   - node segments : 243 (0)
>>
>> I can see that in your partition there are lots of dirty segments, and few free
>> segment, in this statement, we will be more likely to trigger synchronously
>> foreground garbage collection which may lead to long latency. Also, it is
>> indicated in you "GC calls" statement.
> 
> Yes, I see.
> 
>> Can you do synchronously GC through F2FS_IOC_GARBAGE_COLLECT ioctl with
>> parameter @sync which value is set as 1 until free segments size is more close
>> to free space FS show to user? I expect this can help to recover performance in
>> your enviornment.
>>
>> If this does not help, I think we should do some trace in order to find out the
>> root cause of write delay.
> 
> I'll try the ioctl, thanks!
> 
> -- 
>  Alexander
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

------------------------------------------------------------------------------
