From: Raouf Rokhjavan <rokhjavan.r@gmail.com>
Subject: Re: f2fs Crash Consistency Problem
Date: Sat, 15 Apr 2017 09:03:09 +0430
Message-ID: <60b2d6f5-540b-30e7-cec1-82fbfdcad253@gmail.com>
References: <d5ab8383-25f3-ffd6-c506-20993348c499@gmail.com>
	<20170413211935.GA3826@jaegeuk.local>
	<60e7c703-13f1-0f7e-24cc-2c5fae3bc958@gmail.com>
	<20170414184520.GA6827@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rokhjavan.r@gmail.com>) id 1czFOi-0007C3-Ff
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 15 Apr 2017 04:33:20 +0000
Received: from mail-wr0-f196.google.com ([209.85.128.196])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1czFOh-0005Ne-5O
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 15 Apr 2017 04:33:20 +0000
Received: by mail-wr0-f196.google.com with SMTP id l28so14270653wre.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 14 Apr 2017 21:33:19 -0700 (PDT)
In-Reply-To: <20170414184520.GA6827@jaegeuk.local>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>



On 04/14/17 23:15, Jaegeuk Kim wrote:
> On 04/14, Raouf Rokhjavan wrote:
>> First of all, thank you so much for your help.
>>> Hello,
>>>
>>> I just ran log-writer with fsstress and found one issue when replaying IOs.
>>> If you replay after mkfs.f2fs, you get the wrong valid checkpoint which was
>>> overwritten by previous run. IOWs, at the beginning of replay, there was
>>> no *correct* checkpoint representing that initial moment. So, I think you
>>> need to replay the log including mkfs.
>> I made check my scripts to make sure about the CKPT in the boundary of mkfs.
>> To do that, I wrote something which produces this output:
>>
>> SECTION       -- f2fs_consistency
>> FSTYP         -- f2fs
>> PLATFORM      -- Linux/x86_64 localhost 4.9.8
>>
>> generic/009 1s ... 1s
>> Ran: generic/009
>> Passed all 1 tests
>>
>> SECTION       -- f2fs_consistency
>> =========================
>> Ran: generic/009
>> Passed all 1 tests
>>
>> ***** Replaying mkfs *****
>> mkfs_end entry is 1552.
>> CKPT after mkfs_end
>> Info: CKPT version = 6bd74d5f
>>
>> Replaying test #009 ...
>>
>> START_ENTRY is 1553
>> END_ENTRY is 1825
>>
>> ***** Entry #1553 *****
>> CKPT after replay
>> Info: CKPT version = 6bd74d5f
>> CKPT after mount/umount
> What does this mean? Did you mount/umount after replaying each entry?
> I suspect it will break the original behaviors resulting in fs inconsistency.
My test logic is this:
1. setup a log-writes dm-device including including REPLAYDEV and LOGDEV.
2. run mkfs.f2fs on log-writes dm-device
3. run a xfstests on log-writes dm-device which is mounted and 
configured as xfstests' TEST_DEV (no SCRATCH_DEV is configured in order 
to control the mkfs log and replay process)
4. remove the log-writes dm-device
5. replay the logs of mkfs
6. replay remaining entries from mkfs_end mark up to the end of log and 
check the consistency of file system
     - replay each entry -> fsck.f2fs -> mount, umount > fsck.f2fs

The gist of my scripts is something like this:
# ./replay-log --log $LOGDEV --replay $REPLAYDEV --end-mark mkfs_end
# ./replay-log -v --log $LOGDEV --replay $REPLAYDEV --start-mark 
009_start --fsck "./fsck_script.sh" --check 1

*** ./fsck_script.sh ***
fsck.f2fs $REPLAYDEV
mount -t f2fs $REPLAYDEV $CCTESTS_MNT
umount $CCTESTS_MNT
fsck.f2fs $REPLAYDEV

I do this since it's quite similar to what occurs during the power 
failure. At any given point (any entry) system crashes, and after that, 
the file system is mounted/umounted.
>
> BTW, when I tested below, I couldn't find any issue.
>
> # dmsetup create log
> # mkfs.f2fs
> # run xfstests/009
> # dmsetup remove log
> # ./replay-log --log log --replay dev --fsck "fsck.f2fs dev" --check fua
You run fsck after FUA command to block layer, is there any specific 
reason for that? Since I thought REQ_FUA  guarantees writing requests to 
devices which leads to a consistent state. It is not quite
what we're looking for, testing the file system response in the face of 
inconsistency, Am I right?

Regards, Raouf Rokhjavan
>
> It'd be helpful that I can reproduce this tho. ;)
>
> Thanks,
>
>> Info: CKPT version = 6bd74d60
>>
>> ***** Entry #1554 *****
>> CKPT after replay
>> Info: CKPT version = 6bd74d60
>> CKPT after mount/umount
>> Info: CKPT version = 6bd74d61
>>
>> (Continues until)
>>
>> ***** Entry #1703 *****
>> CKPT after replay
>> Info: CKPT version = 6bd74df1
>> CKPT after mount/umount
>> Info: CKPT version = 6bd74df2
>>
>> ***** Entry #1704 *****
>> CKPT after replay
>> (fsck.f2fs with no option asks question at this point)
>>> You can verify the below CKPT version info.
>>> As I mentioned above, I guess you did with "--start-mark mkfs" which will lose
>>> the initial checkpoint.
>> As you can see in the result, the CKPT after mkfs replay matches with the
>> CKPT after the first entry replay, so we can conclude CKPT is valid at this
>> point. Accordingly, I believe everything goes well up to this point, Am I
>> right?
>>> The -p [level] and default level is zero, which checks the image iif runtime
>>> f2fs reported any bug case before. Otherwise, it simply returns. If you set
>>> level 1, fsck.f2fs will check basic FS metadata parts.
>> Does it mean if f2fs module reports nothing as it does in my case (Entry
>> 1704), the fs is consistent?
>> If so, why does fsck.f2fs complain about inaccessible NAT nodes which means
>> inconsistency, at least based on what I think?
>>
>> I do appreciate.
>>
>> Regards,  Raouf Rokhjavan
>>> Thanks,
>>>
>>> ------------------------------------------------------------------------------
>>> Check out the vibrant tech community on one of the world's most
>>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>>> _______________________________________________
>>> Linux-f2fs-devel mailing list
>>> Linux-f2fs-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
