From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs Crash Consistency Problem
Date: Mon, 17 Apr 2017 15:34:16 -0700
Message-ID: <20170417223416.GA3842@jaegeuk.local>
References: <d5ab8383-25f3-ffd6-c506-20993348c499@gmail.com>
	<20170413211935.GA3826@jaegeuk.local>
	<60e7c703-13f1-0f7e-24cc-2c5fae3bc958@gmail.com>
	<20170414235834.GA8933@jaegeuk.local>
	<b462f78b-7188-72ee-8b42-4e019e669161@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1d0FE4-0006wq-Gz
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Apr 2017 22:34:28 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d0FE2-000344-IL
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Apr 2017 22:34:28 +0000
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B0829203A9
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 17 Apr 2017 22:34:19 +0000 (UTC)
Received: from localhost (107-1-141-74-ip-static.hfc.comcastbusiness.net
	[107.1.141.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 2CB84203A5
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 17 Apr 2017 22:34:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <b462f78b-7188-72ee-8b42-4e019e669161@gmail.com>
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

On 04/15, Raouf Rokhjavan wrote:
> 
> 
> On 04/15/17 04:28, Jaegeuk Kim wrote:
> > On 04/14, Raouf Rokhjavan wrote:
> >>
> >> On 04/14/17 01:49, Jaegeuk Kim wrote:
> >> Hi
> >>
> >> First of all, thank you so much for your help.
> >>> Hello,
> >>>
> >>> I just ran log-writer with fsstress and found one issue when replaying IOs.
> >>> If you replay after mkfs.f2fs, you get the wrong valid checkpoint which was
> >>> overwritten by previous run. IOWs, at the beginning of replay, there was
> >>> no *correct* checkpoint representing that initial moment. So, I think you
> >>> need to replay the log including mkfs.
> >> I made check my scripts to make sure about the CKPT in the boundary of mkfs.
> >> To do that, I wrote something which produces this output:
> >>
> >> SECTION       -- f2fs_consistency
> >> FSTYP         -- f2fs
> >> PLATFORM      -- Linux/x86_64 localhost 4.9.8
> >>
> >> generic/009 1s ... 1s
> >> Ran: generic/009
> >> Passed all 1 tests
> >>
> >> SECTION       -- f2fs_consistency
> >> =========================
> >> Ran: generic/009
> >> Passed all 1 tests
> >>
> >> ***** Replaying mkfs *****
> >> mkfs_end entry is 1552.
> >> CKPT after mkfs_end
> >> Info: CKPT version = 6bd74d5f
> >>
> >> Replaying test #009 ...
> >>
> >> START_ENTRY is 1553
> >> END_ENTRY is 1825
> >>
> >> ***** Entry #1553 *****
> >> CKPT after replay
> >> Info: CKPT version = 6bd74d5f
> >> CKPT after mount/umount
> >> Info: CKPT version = 6bd74d60
> >>
> >> ***** Entry #1554 *****
> >> CKPT after replay
> >> Info: CKPT version = 6bd74d60
> >> CKPT after mount/umount
> >> Info: CKPT version = 6bd74d61
> >>
> >> (Continues until)
> >>
> >> ***** Entry #1703 *****
> >> CKPT after replay
> >> Info: CKPT version = 6bd74df1
> >> CKPT after mount/umount
> >> Info: CKPT version = 6bd74df2
> >>
> >> ***** Entry #1704 *****
> >> CKPT after replay
> >> (fsck.f2fs with no option asks question at this point)
> >>> You can verify the below CKPT version info.
> >>> As I mentioned above, I guess you did with "--start-mark mkfs" which will lose
> >>> the initial checkpoint.
> >> As you can see in the result, the CKPT after mkfs replay matches with the
> >> CKPT after the first entry replay, so we can conclude CKPT is valid at this
> >> point. Accordingly, I believe everything goes well up to this point, Am I
> >> right?
> > Hmm, it seems you didn't set snapshot-base and snapshot-cow devices which are
> > acutally used by replay-individual.sh, since your CKPT versions just increase.
> Yes, you're completely right. I didn't set any snapshot target. In the 
> kernel Documentation of log-writes, it hasn't made any reference to 
> snapshot; honestly speaking, I didn't quite grab the point relating to 
> snapshot in "replay-individual.sh". I thought the main reason of this 
> target here is saving the state of whole disk (snapshot) after each log 
> entry, and it has nothing to do with f2fs consistency and specifically CKPT.

At mount time, f2fs writes checkpoint blocks occasionally, if there is a data
block to recover, which is like injecting another IOs in the original sequence.
That will break the FS consistency accordingly, and that's why you can see the
above increasing CKPT versions which were actually written by mount, not IO log.
In order to avoid such the IO injection by mount/umount, original script used
the snapshot device.

Thanks,

> 
> > It make sense that versions should look like what I've run replay-individual.sh
> > after executing generic/009.
> >
> > creating snapshot base
> > 0 2097152 snapshot-origin /dev/nvme0n1p1
> > setting up COW TABLE
> > 100+0 records in
> > 100+0 records out
> > 104857600 bytes (105 MB) copied, 0.330227 s, 318 MB/s
> > replayin to mark
> > replaying entry 3116          <- starting entry number of 009
> > Info: CKPT version = 724f931a
> > Info: CKPT version = 724f931b
> > replaying entry 3117
> > Info: CKPT version = 724f931a
> > Info: CKPT version = 724f931c
> > replaying entry 3118
> > Info: CKPT version = 724f931a
> > Info: CKPT version = 724f931c
> > replaying entry 3119
> > Info: CKPT version = 724f931a
> > Info: CKPT version = 724f931c
> > replaying entry 3120
> > Info: CKPT version = 724f931a
> > Info: CKPT version = 724f931c
> > replaying entry 3121
> > Info: CKPT version = 724f931a
> > Info: CKPT version = 724f931c
> > replaying entry 3122
> > Info: CKPT version = 724f931a
> > ...
> > replaying entry 3294
> > Info: CKPT version = 724f931b
> > Info: CKPT version = 724f931c
> > replaying entry 3295          <- ending entry number
> > Info: CKPT version = 724f931c
> > Info: CKPT version = 724f931d
> >
> > Again, I couldn't find any issue here.
> >
> > Thanks,
> I wonder how a dm-target like snapshot can affect the behavior of upper 
> layer like f2fs and specifically its CKPT versions !!! Would you please 
> explain it a little bit?
> 
> Regards, Raouf Rokhjavan
> >>> The -p [level] and default level is zero, which checks the image iif runtime
> >>> f2fs reported any bug case before. Otherwise, it simply returns. If you set
> >>> level 1, fsck.f2fs will check basic FS metadata parts.
> >> Does it mean if f2fs module reports nothing as it does in my case (Entry
> >> 1704), the fs is consistent?
> >> If so, why does fsck.f2fs complain about inaccessible NAT nodes which means
> >> inconsistency, at least based on what I think?
> >>
> >> I do appreciate.
> >>
> >> Regards,  Raouf Rokhjavan
> >>> Thanks,
> >>>
> >>> ------------------------------------------------------------------------------
> >>> Check out the vibrant tech community on one of the world's most
> >>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> >>> _______________________________________________
> >>> Linux-f2fs-devel mailing list
> >>> Linux-f2fs-devel@lists.sourceforge.net
> >>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
