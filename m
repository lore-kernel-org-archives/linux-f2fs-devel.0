From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH v3 RESEND] f2fs: add bug_on when f2fs_gc even
 fails to get one victim
Date: Sat, 25 Nov 2017 17:12:01 +0800
Message-ID: <74b3c52a-0f8d-2d53-668f-f6d149ddb6ea@huawei.com>
References: <1510880948-154538-1-git-send-email-yunlong.song@huawei.com>
 <ad823d10-ac5c-095d-2eb6-5f84c559a098@huawei.com>
 <77657045-2bba-2c31-f668-de6351c3f342@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yunlong.song@huawei.com>) id 1eIWWd-00029Y-57
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 25 Nov 2017 09:13:27 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eIWWa-0002VT-KM
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 25 Nov 2017 09:13:27 +0000
In-Reply-To: <77657045-2bba-2c31-f668-de6351c3f342@kernel.org>
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
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: linux-fsdevel@vger.kernel.org, miaoxie@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Ok, I have found a panic with this bug_on for generic/027 today:

[ 5157.753224] F2FS-fs (loop2): Mounted with checkpoint version = 2e2
generic/027    [ 5168.741251] run fstests generic/027 at 2017-11-25 04:46:40
[ 5189.445989] F2FS-fs (loop3): Found nat_bits in checkpoint
[ 5189.510872] F2FS-fs (loop3): Mounted with checkpoint version = 165da00b
[ 5250.613849] ------------[ cut here ]------------
[ 5250.616840] kernel BUG at 
/opt/s00293685/src/kernel/jaegeuk/f2fs/fs/f2fs/gc.c:1038!
[ 5250.628467] invalid opcode: 0000 [#1] SMP
[ 5250.628467] Modules linked in:
[ 5250.628467] CPU: 7 PID: 3173 Comm: xfs_io Not tainted 4.14.0-rc4+ #128
[ 5250.628467] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
[ 5250.628467] task: ffff880130f2be80 task.stack: ffffc9000acd0000
[ 5250.628467] RIP: 0010:f2fs_gc+0x9da/0xa80
[ 5250.628467] RSP: 0018:ffffc9000acd3b48 EFLAGS: 00000246
[ 5250.628467] RAX: 000000000000001b RBX: ffff880134fa2648 RCX: 
ffff880134fa2f00
[ 5250.628467] RDX: 0000000000000006 RSI: 0000000000000200 RDI: 
0000000000000001
[ 5250.628467] RBP: ffffc9000acd3c38 R08: 000000000000001b R09: 
0000000000000001
[ 5250.628467] R10: 0000000000000000 R11: 0000000000000001 R12: 
0000000000000000
[ 5250.628467] R13: 0000000000000001 R14: ffff880138472000 R15: 
0000000000000002
[ 5250.628467] FS:  0000000001666880(0000) GS:ffff88013fdc0000(0000) 
knlGS:0000000000000000
[ 5250.628467] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5250.628467] CR2: 00000000006ef120 CR3: 0000000130f48000 CR4: 
00000000000006e0
[ 5250.628467] Call Trace:
[ 5250.628467]  f2fs_balance_fs+0x13c/0x1f0
[ 5250.628467]  f2fs_create+0x146/0x260
[ 5250.628467]  path_openat+0xe31/0x12c0
[ 5250.628467]  do_filp_open+0x7e/0xd0
[ 5250.628467]  ? kmem_cache_alloc+0x92/0x160
[ 5250.628467]  ? getname_flags+0x4f/0x1f0
[ 5250.628467]  do_sys_open+0x115/0x1f0
[ 5250.628467]  SyS_open+0x1e/0x20
[ 5250.628467]  entry_SYSCALL_64_fastpath+0x13/0x94
[ 5250.628467] RIP: 0033:0x4171d0
[ 5250.628467] RSP: 002b:00007fff9a45b678 EFLAGS: 00000246 ORIG_RAX: 
0000000000000002
[ 5250.628467] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 
00000000004171d0
[ 5250.628467] RDX: 0000000000000180 RSI: 0000000000000042 RDI: 
00007fff9a45c1cb
[ 5250.628467] RBP: 00007fff9a45c1bf R08: 00007fff9a45b7f0 R09: 
0000000000000001
[ 5250.628467] R10: 00000000004bd8d3 R11: 0000000000000246 R12: 
0000000000000006
[ 5250.628467] R13: 00007fff9a45b830 R14: 0000000000000180 R15: 
0000000000000000
[ 5250.628467] Code: 00 bb c3 ff ff ff e9 2c fa ff ff 4d 8b 27 bb fb ff 
ff ff c7 44 24 7c 00 00 00 00 c7 84 24 80 00 00 00 00 00 00 00 e9 0c fa 
ff ff <0f> 0b 41 8b 96 fc 03 00 00 41 8b be f4 03 00 00 4c 8b 21 45 8b
[ 5250.628467] RIP: f2fs_gc+0x9da/0xa80 RSP: ffffc9000acd3b48
[ 5250.685538] ---[ end trace 00b8c84c59632b32 ]---

Let me fix it one by one.

On 2017/11/23 21:05, Chao Yu wrote:
> On 2017/11/22 11:50, Yunlong Song wrote:
>> ping again...
>>
>> On 2017/11/17 9:09, Yunlong Song wrote:
>>> This can help to find potential bugs on some corner case.
> Could you test this patch with fstest suit? if there are any testcases
> can trigger this bug_on, it will be better to fix them all together.
>
> Thanks,
>
>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>> ---
>>>    fs/f2fs/gc.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index 5d5bba4..c89128b 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -1035,6 +1035,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>>            goto stop;
>>>        }
>>>        if (!__get_victim(sbi, &segno, gc_type)) {
>>> +        f2fs_bug_on(sbi, !total_freed && has_not_enough_free_secs(sbi, 0, 0));
>>>            ret = -ENODATA;
>>>            goto stop;
>>>        }
> .
>

-- 
Thanks,
Yunlong Song



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
