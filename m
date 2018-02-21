From: Jayashree Mohan <jayashree2912@gmail.com>
Subject: Re: f2fs: keep isize once block is reserved cross EOF
Date: Wed, 21 Feb 2018 12:18:39 -0600
Message-ID: <CA+EzBbCR-0C0HGd0dY_jYeLc_k5TjiozhBVJuQuMc-NiONCLKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jayashree2912@gmail.com>) id 1eoYyX-00047l-Pv
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 21 Feb 2018 18:18:41 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail-vk0-f50.google.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 id 1eoYyX-0007Sm-HN
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 21 Feb 2018 18:18:41 +0000
Received: by mail-vk0-f50.google.com with SMTP id z190so1530170vkg.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 21 Feb 2018 10:18:41 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Hi,

I am Jayashree Mohan, a PhD student at the University of Texas at
Austin, working with Prof. Vijay Chidambaram. I've been working on the
Crashmonkey project, which is a test harness for file system crash
consistency checks[1].

Using CrashMonkey, we stumbled upon the following possible issue with f2fs:
Whenever we do a fallocate zero_range operation with the keep_size
flag, followed by a fdatasync and then crash(power off), on recovery
we see an incorrect file size. This issue aligns with the patch
here[2], except that generic/392 and generic/468 have tested
fallocate_punch_hole and fallocate operations, but not zero_range.

> On Wed, Nov 15, 2017 at 04:58:33PM +0800, Chao Yu wrote:
>> f2fs can skip isize updating in fsync(), since during mount, f2fs tries
>> to recovery isize according to valid block address or preallocated flag
>> in last fsynced dnode block.
>>
>> However, fallocate() breaks our rule with setting FALLOC_FL_KEEP_SIZE
>> flag, since it can preallocated block cross EOF, once the file is fsynced,
>> in POR, we will recover isize incorrectly based on these fallocated
>> blocks.


A simple workload to reproduce this would be :
1. create foo
2. Write (8K - 16K)  // foo size = 16K now
3. fsync()
4. falloc zero_range , keep_size (4202496 - 4210688) // foo size must be 16K
5. fdatasync()
Crash now

On recovery, we see that the file size is 4210688 and not 16K, which
violates the semantics of keep_size flag. We have a test case to
reproduce this using CrashMonkey on 4.15 kernel. Try this out by
simply running :
 ./c_harness -f /dev/sda -d /dev/cow_ram0 -t f2fs -e 102400  -P -v
tests/generic_468_zero.so

Do you think, this is a possible corner case that skipped your attention?
Let me know if I am missing some detail.

[1] https://github.com/utsaslab/crashmonkey
[2] https://sourceforge.net/p/linux-f2fs/mailman/message/36104201/


Thanks,

Jayashree Mohan
PhD in Computer Science
University of Texas at Austin.

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
