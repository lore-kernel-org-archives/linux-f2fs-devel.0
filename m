From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: add bug_on when f2fs_gc even fails
 to get one victim
Date: Tue, 31 Oct 2017 11:17:12 +0800
Message-ID: <9d750ff6-7b71-562b-ea24-9faad7dd10ae@huawei.com>
References: <1507729864-118702-1-git-send-email-yunlong.song@huawei.com>
 <1507901500-162168-1-git-send-email-yunlong.song@huawei.com>
 <7f05bef6-929f-ea7b-9d60-e9a6d8e70d3c@kernel.org>
 <31f2c1b6-58ee-bb52-0b75-f6172b6f801f@huawei.com>
 <c6e82b46-fe59-ad29-aab7-6c876ebaba5b@huawei.com>
 <7eb77c60-ed9b-2440-cc46-55c2eb8573d1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e9N5O-0007Zv-RN
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 03:19:30 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e9N5M-0002yH-Fx
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 03:19:30 +0000
In-Reply-To: <7eb77c60-ed9b-2440-cc46-55c2eb8573d1@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlong Song <yunlong.song@huawei.com>, Chao Yu <chao@kernel.org>, jaegeuk@kernel.org, yunlong.song@icloud.com
Cc: linux-fsdevel@vger.kernel.org, miaoxie@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/10/31 9:32, Yunlong Song wrote:
> I think there may be bugs somewhere, since no victim is selected but it 
> really needs gc.
> What is the size of the data image?

I have providered the testcase, could you check that?

>>>> I can hit this bugon with generic/015 of fstest easily, could have a look at
>>>> this?

Anyway, I have looked into this issue at last weekend, forgot to post related
info. It shows that if the image size is very small, e.g. 50MB, current
segment will encroach overprov and reserved segments, so free segment count will
always be small than reserved segment threshold, result in triggering bugon in
FGGC.

[SB: 1] [CP: 2] [SIT: 2] [NAT: 2] [SSA: 1] [MAIN: 17(OverProv:14 Resv:12)]

  - Valid: 6
  - Dirty: 0
  - Prefree: 0
  - Free: 11 (11)

I modify mkfs.f2fs forcedly as below, which could let generic/015 passed:

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 8a821d3a1747..774bbef73d9a 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -371,6 +371,12 @@ static int f2fs_prepare_super_block(void)
 			(2 * (100 / c.overprovision + 1) + 6)
 			* c.segs_per_sec;

+	if (get_sb(segment_count_main) * (100 - c.overprovision) / 100 -
+		c.reserved_segments < 6) {
+		c.overprovision = 50;
+		c.reserved_segments = get_sb(segment_count_main) - 6 * 2;
+	}
+
 	uuid_generate(sb->uuid);

 	/* precompute checksum seed for metadata */

Thanks,

> 
> On 2017/10/16 11:25, Chao Yu wrote:
>> On 2017/10/14 20:34, Yunlong Song wrote:
>>> Do you mean check out-of-space test? I have tried that but no bugon.
>> Yes, test recent f2fs codes with kernel 4.13.0-rc1+ in VM, FYI:
>>
>> kernel BUG at gc.c:1034!
>> invalid opcode: 0000 [#1] SMP
>> Hardware name: Xen HVM domU, BIOS 4.1.2_115-900.260_ 11/06/2015
>> RIP: 0010:f2fs_gc+0x6e5/0x6f0 [f2fs]
>> RSP: 0018:ffffc90004af7b40 EFLAGS: 00010202
>> RAX: ffff8801b0a15940 RBX: 0000000000000000 RCX: 0000000000000000
>> RDX: ffff8801b0a15940 RSI: ffff8801978d5f00 RDI: ffff880128148048
>> RBP: ffffc90004af7c38 R08: ffff8801978d5f00 R09: 0000000000000003
>> R10: 0000000000000003 R11: ffff8800060703a0 R12: 0000000000000000
>> R13: 0000000000000000 R14: 0000000000000001 R15: ffff8801b4279800
>> FS:  00007f23493cb740(0000) GS:ffff880216f00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007ffd05402ff8 CR3: 00000001bffb3000 CR4: 00000000001406e0
>> Call Trace:
>>   f2fs_balance_fs+0x123/0x140 [f2fs]
>>   f2fs_create+0x130/0x240 [f2fs]
>>   path_openat+0xee7/0x1360
>>   do_filp_open+0x7e/0xd0
>>   do_sys_open+0x115/0x1f0
>>   SyS_open+0x1e/0x20
>>   do_syscall_64+0x6e/0x160
>>   entry_SYSCALL64_slow_path+0x25/0x25
>>
>> Thanks,
>>
>>> On 2017/10/14 8:17, Chao Yu wrote:
>>>> On 2017/10/13 21:31, Yunlong Song wrote:
>>>>> This can help us to debug on some corner case.
>>>> I can hit this bugon with generic/015 of fstest easily, could have a look at
>>>> this?
>>>>
>>>> Thanks,
>>>>
>>>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>>> ---
>>>>>    fs/f2fs/gc.c | 6 +++++-
>>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>>> index 197ebf4..2b03202 100644
>>>>> --- a/fs/f2fs/gc.c
>>>>> +++ b/fs/f2fs/gc.c
>>>>> @@ -986,6 +986,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>>>>    		.ilist = LIST_HEAD_INIT(gc_list.ilist),
>>>>>    		.iroot = RADIX_TREE_INIT(GFP_NOFS),
>>>>>    	};
>>>>> +	bool need_fggc = false;
>>>>>    
>>>>>    	trace_f2fs_gc_begin(sbi->sb, sync, background,
>>>>>    				get_pages(sbi, F2FS_DIRTY_NODES),
>>>>> @@ -1018,8 +1019,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>>>>    			if (ret)
>>>>>    				goto stop;
>>>>>    		}
>>>>> -		if (has_not_enough_free_secs(sbi, 0, 0))
>>>>> +		if (has_not_enough_free_secs(sbi, 0, 0)) {
>>>>>    			gc_type = FG_GC;
>>>>> +			need_fggc = true;
>>>>> +		}
>>>>>    	}
>>>>>    
>>>>>    	/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
>>>>> @@ -1028,6 +1031,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>>>>    		goto stop;
>>>>>    	}
>>>>>    	if (!__get_victim(sbi, &segno, gc_type)) {
>>>>> +		f2fs_bug_on(sbi, !total_freed && need_fggc);
>>>>>    		ret = -ENODATA;
>>>>>    		goto stop;
>>>>>    	}
>>>>>
>>>> .
>>>>
>>
>> .
>>
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
