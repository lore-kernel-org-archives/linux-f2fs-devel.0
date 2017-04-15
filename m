From: Raouf Rokhjavan <rokhjavan.r@gmail.com>
Subject: Re: f2fs Crash Consistency Problem
Date: Sat, 15 Apr 2017 09:43:09 +0430
Message-ID: <b462f78b-7188-72ee-8b42-4e019e669161@gmail.com>
References: <d5ab8383-25f3-ffd6-c506-20993348c499@gmail.com>
	<20170413211935.GA3826@jaegeuk.local>
	<60e7c703-13f1-0f7e-24cc-2c5fae3bc958@gmail.com>
	<20170414235834.GA8933@jaegeuk.local>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rokhjavan.r@gmail.com>) id 1czG1P-0002GB-JS
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 15 Apr 2017 05:13:19 +0000
Received: from mail-wr0-f193.google.com ([209.85.128.193])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1czG1O-0005df-Ak
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 15 Apr 2017 05:13:19 +0000
Received: by mail-wr0-f193.google.com with SMTP id l28so14325945wre.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 14 Apr 2017 22:13:18 -0700 (PDT)
Received: from desktopr.example.com ([188.159.249.236])
	by smtp.gmail.com with ESMTPSA id
	c53sm4947622wra.16.2017.04.14.22.13.10
	for <linux-f2fs-devel@lists.sourceforge.net>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 14 Apr 2017 22:13:11 -0700 (PDT)
In-Reply-To: <20170414235834.GA8933@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-f2fs-devel@lists.sourceforge.net



On 04/15/17 04:28, Jaegeuk Kim wrote:
> On 04/14, Raouf Rokhjavan wrote:
>>
>> On 04/14/17 01:49, Jaegeuk Kim wrote:
>> Hi
>>
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
> Hmm, it seems you didn't set snapshot-base and snapshot-cow devices which are
> acutally used by replay-individual.sh, since your CKPT versions just increase.
Yes, you're completely right. I didn't set any snapshot target. In the 
kernel Documentation of log-writes, it hasn't made any reference to 
snapshot; honestly speaking, I didn't quite grab the point relating to 
snapshot in "replay-individual.sh". I thought the main reason of this 
target here is saving the state of whole disk (snapshot) after each log 
entry, and it has nothing to do with f2fs consistency and specifically CKPT.

> It make sense that versions should look like what I've run replay-individual.sh
> after executing generic/009.
>
> creating snapshot base
> 0 2097152 snapshot-origin /dev/nvme0n1p1
> setting up COW TABLE
> 100+0 records in
> 100+0 records out
> 104857600 bytes (105 MB) copied, 0.330227 s, 318 MB/s
> replayin to mark
> replaying entry 3116          <- starting entry number of 009
> Info: CKPT version = 724f931a
> Info: CKPT version = 724f931b
> replaying entry 3117
> Info: CKPT version = 724f931a
> Info: CKPT version = 724f931c
> replaying entry 3118
> Info: CKPT version = 724f931a
> Info: CKPT version = 724f931c
> replaying entry 3119
> Info: CKPT version = 724f931a
> Info: CKPT version = 724f931c
> replaying entry 3120
> Info: CKPT version = 724f931a
> Info: CKPT version = 724f931c
> replaying entry 3121
> Info: CKPT version = 724f931a
> Info: CKPT version = 724f931c
> replaying entry 3122
> Info: CKPT version = 724f931a
> ...
> replaying entry 3294
> Info: CKPT version = 724f931b
> Info: CKPT version = 724f931c
> replaying entry 3295          <- ending entry number
> Info: CKPT version = 724f931c
> Info: CKPT version = 724f931d
>
> Again, I couldn't find any issue here.
>
> Thanks,
I wonder how a dm-target like snapshot can affect the behavior of upper 
layer like f2fs and specifically its CKPT versions !!! Would you please 
explain it a little bit?

Regards, Raouf Rokhjavan
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
