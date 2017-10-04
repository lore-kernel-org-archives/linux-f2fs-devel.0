From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: introduce discard_granularity sysfs
 entry
Date: Wed, 4 Oct 2017 08:49:40 +0800
Message-ID: <07919a46-ca3e-298f-b9c0-5a375bdce843@kernel.org>
References: <20170807150956.9433-1-chao@kernel.org>
 <20170815034518.GA94478@jaegeuk-macbookpro.roam.corp.google.com>
 <085f08d4-1f46-6bd5-b81e-a09b51499267@huawei.com>
 <20170815175445.GB4293@jaegeuk-macbookpro.roam.corp.google.com>
 <0bb733a8-5f86-950f-9474-edde718b1546@kernel.org>
 <20170821204236.GA66826@jaegeuk-macbookpro.roam.corp.google.com>
 <CAD14+f3k312gUMYW9pifQNkhmtUrbV13gwJZFAWiU1Bx9E0KgQ@mail.gmail.com>
 <18d22f41-3937-b08e-de69-892864afc588@kernel.org>
 <CAD14+f2zQmvkyiP2exB6MYwA2J003vgsE9n6ij7_juHXfwzVXg@mail.gmail.com>
 <20171003201737.GB35961@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171003201737.GB35961@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Ju Hyung Park <qkrwngud825@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Ju Hyung, Jaegeuk,

On 2017/10/4 4:17, Jaegeuk Kim wrote:
> On 10/04, Ju Hyung Park wrote:
>> Hi Chao.
>>
>> Yep, that patch seems to have fixed it.
>> Doing "while true; do fstrim -v /; done" while "rm -rf"ing a 2GB
>> kbuild directory
>> (with lots of small .o files and stuff) ended flawlessly.

Thanks for the test. ;)

>>
>> I hope to see this patch merged with next 4.14 merge cycle.
> 
> Cool! I'll merge this patch and submit for 4.14. :)

Thanks for the quick merging. ;)

Thanks,

> 
> Thanks,
> 
>>
>> Thanks :)
>>
>> On Tue, Oct 3, 2017 at 12:59 AM, Chao Yu <chao@kernel.org> wrote:
>>> Hi Park,
>>>
>>> Thanks for the report, could have a try with below patch:
>>>
>>> From 5fa30e8cdcb93f210e25142c48a884be383c6121 Mon Sep 17 00:00:00 2001
>>> From: Chao Yu <yuchao0@huawei.com>
>>> Date: Mon, 2 Oct 2017 02:50:16 +0800
>>> Subject: [PATCH] f2fs: fix potential panic during fstrim
>>>
>>> As Ju Hyung Park reported:
>>>
>>> "When 'fstrim' is called for manual trim, a BUG() can be triggered
>>> randomly with this patch.
>>>
>>> I'm seeing this issue on both x86 Desktop and arm64 Android phone.
>>>
>>> On x86 Desktop, this was caused during Ubuntu boot-up. I have a
>>> cronjob installed which calls 'fstrim -v /' during boot. On arm64
>>> Android, this was caused during GC looping with 1ms gc_min_sleep_time
>>> & gc_max_sleep_time."
>>>
>>> Root cause of this issue is that f2fs_wait_discard_bios can only be
>>> used by f2fs_put_super, because during put_super there must be no
>>> other referrers, so it can ignore discard entry's reference count
>>> when removing the entry, otherwise in other caller we will hit bug_on
>>> in __remove_discard_cmd as there may be other issuer added reference
>>> count in discard entry.
>>>
>>> Thread A                                Thread B
>>>                                         - issue_discard_thread
>>> - f2fs_ioc_fitrim
>>>  - f2fs_trim_fs
>>>   - f2fs_wait_discard_bios
>>>    - __issue_discard_cmd
>>>     - __submit_discard_cmd
>>>                                          - __wait_discard_cmd
>>>                                           - dc->ref++
>>>                                           - __wait_one_discard_bio
>>>    - __wait_discard_cmd
>>>     - __remove_discard_cmd
>>>      - f2fs_bug_on(sbi, dc->ref)
>>>
>>> Fixes: 969d1b180d987c2be02de890d0fff0f66a0e80de
>>> Reported-by: Ju Hyung Park <qkrwngud825@gmail.com>
>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>> ---
>>>  fs/f2fs/f2fs.h    | 2 +-
>>>  fs/f2fs/segment.c | 6 +++---
>>>  fs/f2fs/super.c   | 2 +-
>>>  3 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 9a7c90386947..4b4a72f392be 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -2525,7 +2525,7 @@ void invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
>>>  bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
>>>  void refresh_sit_entry(struct f2fs_sb_info *sbi, block_t old, block_t new);
>>>  void stop_discard_thread(struct f2fs_sb_info *sbi);
>>> -void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
>>> +void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi, bool umount);
>>>  void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc);
>>>  void release_discard_addrs(struct f2fs_sb_info *sbi);
>>>  int npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index dedf0209d820..e28245b7e44e 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1210,11 +1210,11 @@ void stop_discard_thread(struct f2fs_sb_info *sbi)
>>>  }
>>>
>>>  /* This comes from f2fs_put_super and f2fs_trim_fs */
>>> -void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
>>> +void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi, bool umount)
>>>  {
>>>         __issue_discard_cmd(sbi, false);
>>>         __drop_discard_cmd(sbi);
>>> -       __wait_discard_cmd(sbi, false);
>>> +       __wait_discard_cmd(sbi, !umount);
>>>  }
>>>
>>>  static void mark_discard_range_all(struct f2fs_sb_info *sbi)
>>> @@ -2244,7 +2244,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
>>>         }
>>>         /* It's time to issue all the filed discards */
>>>         mark_discard_range_all(sbi);
>>> -       f2fs_wait_discard_bios(sbi);
>>> +       f2fs_wait_discard_bios(sbi, false);
>>>  out:
>>>         range->len = F2FS_BLK_TO_BYTES(cpc.trimmed);
>>>         return err;
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index 89f61eb3d167..933c3d529e65 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -801,7 +801,7 @@ static void f2fs_put_super(struct super_block *sb)
>>>         }
>>>
>>>         /* be sure to wait for any on-going discard commands */
>>> -       f2fs_wait_discard_bios(sbi);
>>> +       f2fs_wait_discard_bios(sbi, true);
>>>
>>>         if (f2fs_discard_en(sbi) && !sbi->discard_blks) {
>>>                 struct cp_control cpc = {
>>> --
>>> 2.14.1.145.gb3622a4ee
>>>
>>> On 2017/10/2 3:29, Ju Hyung Park wrote:
>>>> When 'fstrim' is called for manual trim, a BUG() can be triggered
>>>> randomly with this patch.
>>>>
>>>> I'm seeing this issue on both x86 Desktop and arm64 Android phone.
>>>>
>>>> On x86 Desktop, this was caused during Ubuntu boot-up. I have a
>>>> cronjob installed
>>>> which calls 'fstrim -v /' during boot.
>>>> On arm64 Android, this was caused during GC looping with
>>>> 1ms gc_min_sleep_time & gc_max_sleep_time.
>>>>
>>>> Thanks.
>>>>
>>>> [26671.666421] ------------[ cut here ]------------
>>>> [26671.666426] WARNING: CPU: 8 PID: 103479 at fs/f2fs/segment.c:797
>>>> __remove_discard_cmd+0xb9/0xd0
>>>> [26671.666427] Modules linked in: ftdi_sio usbserial uas usb_storage
>>>> vmnet(O) vmw_vsock_vmci_transport vsock vmw_vmci vmmon(O) rfcomm
>>>> xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4
>>>> iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4
>>>> xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge
>>>> stp llc bnep ebtable_filter ebtables ip6table_filter ip6_tables
>>>> xt_multiport iptable_filter binfmt_misc snd_hda_codec_hdmi eeepc_wmi
>>>> asus_wmi sparse_keymap video wmi_bmof mxm_wmi nls_iso8859_1 btusb
>>>> btrtl joydev btbcm btintel input_leds bluetooth edac_mce_amd
>>>> snd_hda_codec_realtek snd_hda_codec_generic kvm_amd kvm irqbypass
>>>> snd_seq_dummy snd_hda_intel snd_hda_codec snd_seq_oss snd_seq_midi
>>>> snd_hda_core snd_seq_midi_event snd_hwdep snd_pcm snd_rawmidi snd_seq
>>>> snd_seq_device
>>>> [26671.666450]  snd_timer snd soundcore k10temp i2c_piix4
>>>> nvidia_uvm(PO) shpchp wmi 8250_dw mac_hid parport_pc ppdev nfsd lp
>>>> auth_rpcgss parport oid_registry nfs_acl lockd grace sunrpc ip_tables
>>>> x_tables autofs4 raid10 raid456 async_raid6_recov async_memcpy
>>>> async_pq async_xor async_tx raid1 multipath linear hid_generic
>>>> hid_apple usbhid nvidia_drm(PO) nvidia_modeset(PO) nvidia(PO)
>>>> drm_kms_helper syscopyarea sysfillrect sysimgblt igb fb_sys_fops dca
>>>> ptp drm pps_core i2c_algo_bit ahci libahci gpio_amdpt gpio_generic
>>>> [26671.666471] CPU: 8 PID: 103479 Comm: fstrim Tainted: P           O
>>>>   4.13.4-zen+ #1
>>>> [26671.666472] Hardware name: System manufacturer System Product
>>>> Name/PRIME X399-A, BIOS 0318 08/11/2017
>>>> [26671.666472] task: ffff8804ad535800 task.stack: ffff88047ee38000
>>>> [26671.666474] RIP: 0010:__remove_discard_cmd+0xb9/0xd0
>>>> [26671.666474] RSP: 0018:ffff88047ee3bd00 EFLAGS: 00010202
>>>> [26671.666475] RAX: ffff88081801a500 RBX: ffff88047eeaed00 RCX: ffff88047eeaedf8
>>>> [26671.666475] RDX: 0000000000000001 RSI: ffff88047eeaed00 RDI: ffff880802555800
>>>> [26671.666476] RBP: ffff8808134d0000 R08: ffff8804ad535800 R09: 0000000000000001
>>>> [26671.666476] R10: ffff88047ee3bd18 R11: 0000000000000000 R12: ffff880802555800
>>>> [26671.666476] R13: 0000000000000000 R14: ffff88047eeaedd0 R15: ffff8808134d0000
>>>> [26671.666477] FS:  00007f44cddad2c0(0000) GS:ffff88081ca00000(0000)
>>>> knlGS:0000000000000000
>>>> [26671.666478] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [26671.666478] CR2: 00007f88f5776328 CR3: 000000058ce4a000 CR4: 00000000003406e0
>>>> [26671.666479] Call Trace:
>>>> [26671.666481]  ? __wait_discard_cmd+0x7a/0xc0
>>>> [26671.666482]  ? f2fs_trim_fs+0x1c1/0x210
>>>> [26671.666484]  ? f2fs_ioctl+0x75a/0x2320
>>>> [26671.666486]  ? do_filp_open+0x99/0xe0
>>>> [26671.666487]  ? cp_new_stat+0x138/0x150
>>>> [26671.666489]  ? do_vfs_ioctl+0x88/0x5c0
>>>> [26671.666490]  ? SyS_newfstat+0x29/0x40
>>>> [26671.666491]  ? SyS_ioctl+0x6f/0x80
>>>> [26671.666493]  ? entry_SYSCALL_64_fastpath+0x1e/0xa9
>>>> [26671.666493] Code: 48 89 de 8b 43 1c 48 8b 3d 4d 8c 31 01 29 85 74
>>>> 22 00 00 e8 fa 01 d5 ff f0 ff 8d 80 22 00 00 5b 5d c3 c7 43 64 00 00
>>>> 00 00 eb 92 <0f> ff f0 80 4f 20 04 e9 53 ff ff ff 90 66 2e 0f 1f 84 00
>>>> 00 00
>>>> [26671.666506] ---[ end trace 613553f7a4728b5a ]---
>>>> [26672.553742] general protection fault: 0000 [#1] PREEMPT SMP
>>>> [26672.553746] Modules linked in: ftdi_sio usbserial uas usb_storage
>>>> vmnet(O) vmw_vsock_vmci_transport vsock vmw_vmci vmmon(O) rfcomm
>>>> xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4
>>>> iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4
>>>> xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge
>>>> stp llc bnep ebtable_filter ebtables ip6table_filter ip6_tables
>>>> xt_multiport iptable_filter binfmt_misc snd_hda_codec_hdmi eeepc_wmi
>>>> asus_wmi sparse_keymap video wmi_bmof mxm_wmi nls_iso8859_1 btusb
>>>> btrtl joydev btbcm btintel input_leds bluetooth edac_mce_amd
>>>> snd_hda_codec_realtek snd_hda_codec_generic kvm_amd kvm irqbypass
>>>> snd_seq_dummy snd_hda_intel snd_hda_codec snd_seq_oss snd_seq_midi
>>>> snd_hda_core snd_seq_midi_event snd_hwdep snd_pcm snd_rawmidi snd_seq
>>>> snd_seq_device
>>>> [26672.553771]  snd_timer snd soundcore k10temp i2c_piix4
>>>> nvidia_uvm(PO) shpchp wmi 8250_dw mac_hid parport_pc ppdev nfsd lp
>>>> auth_rpcgss parport oid_registry nfs_acl lockd grace sunrpc ip_tables
>>>> x_tables autofs4 raid10 raid456 async_raid6_recov async_memcpy
>>>> async_pq async_xor async_tx raid1 multipath linear hid_generic
>>>> hid_apple usbhid nvidia_drm(PO) nvidia_modeset(PO) nvidia(PO)
>>>> drm_kms_helper syscopyarea sysfillrect sysimgblt igb fb_sys_fops dca
>>>> ptp drm pps_core i2c_algo_bit ahci libahci gpio_amdpt gpio_generic
>>>> [26672.553792] CPU: 10 PID: 1287 Comm: f2fs_discard-25 Tainted: P
>>>>   W  O    4.13.4-zen+ #1
>>>> [26672.553793] Hardware name: System manufacturer System Product
>>>> Name/PRIME X399-A, BIOS 0318 08/11/2017
>>>> [26672.553794] task: ffff8808159c1600 task.stack: ffff880813304000
>>>> [26672.553798] RIP: 0010:__remove_discard_cmd+0x6a/0xd0
>>>> [26672.553799] RSP: 0018:ffff880813307e20 EFLAGS: 00010296
>>>> [26672.553800] RAX: dead000000000200 RBX: ffff88047eeaed00 RCX: ffff8808159c1601
>>>> [26672.553801] RDX: dead000000000100 RSI: ffff8808134d2288 RDI: ffff88047eeaed00
>>>> [26672.553801] RBP: ffff8808134d0000 R08: 0000184230172c00 R09: 0000000000000006
>>>> [26672.553802] R10: ffff880813307e38 R11: 0000000000000023 R12: ffff880802555800
>>>> [26672.553803] R13: 0000000000000001 R14: ffff88047eeaed00 R15: ffff8808134d0000
>>>> [26672.553804] FS:  0000000000000000(0000) GS:ffff88081ca80000(0000)
>>>> knlGS:0000000000000000
>>>> [26672.553805] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [26672.553805] CR2: 00007f88f2f71328 CR3: 000000048be79000 CR4: 00000000003406e0
>>>> [26672.553806] Call Trace:
>>>> [26672.553808]  ? __wait_one_discard_bio+0x41/0x60
>>>> [26672.553809]  ? __wait_discard_cmd+0xbb/0xc0
>>>> [26672.553811]  ? issue_discard_thread+0x196/0x200
>>>> [26672.553813]  ? wait_woken+0x80/0x80
>>>> [26672.553814]  ? mark_discard_range_all.isra.11+0x40/0x40
>>>> [26672.553816]  ? kthread+0x112/0x130
>>>> [26672.553817]  ? kthread_create_on_node+0x40/0x40
>>>> [26672.553818]  ? do_group_exit+0x2e/0xa0
>>>> [26672.553820]  ? ret_from_fork+0x25/0x30
>>>> [26672.553821] Code: 8b 43 20 48 8b 3f e8 56 6c fe ff 58 80 7b 62 02
>>>> 75 07 f0 ff 8d 7c 22 00 00 48 8b 53 28 48 8b 43 30 48 8d b5 88 22 00
>>>> 00 48 89 df <48> 89 42 08 48 89 10 48 b8 00 01 00 00 00 00 ad de 48 89
>>>> 43 28
>>>> [26672.553835] RIP: __remove_discard_cmd+0x6a/0xd0 RSP: ffff880813307e20
>>>> [26672.553836] ---[ end trace 613553f7a4728b5b ]---
>>>>
>>>> On Tue, Aug 22, 2017 at 5:42 AM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>>>>> On 08/18, Chao Yu wrote:
>>>>>> Hi Jaegeuk,
>>>>>>
>>>>>> Sorry for the delay, the modification looks good to me. ;)
>>>>>
>>>>> We must avoid waking up discard thread caused by # of pending commands
>>>>> which are never issued.
>>>>>
>>>>> From a73f8807248c2f42328a2204eab16a3b8d32c83e Mon Sep 17 00:00:00 2001
>>>>> From: Chao Yu <yuchao0@huawei.com>
>>>>> Date: Mon, 7 Aug 2017 23:09:56 +0800
>>>>> Subject: [PATCH] f2fs: introduce discard_granularity sysfs entry
>>>>>
>>>>> Commit d618ebaf0aa8 ("f2fs: enable small discard by default") enables
>>>>> f2fs to issue 4K size discard in real-time discard mode. However, issuing
>>>>> smaller discard may cost more lifetime but releasing less free space in
>>>>> flash device. Since f2fs has ability of separating hot/cold data and
>>>>> garbage collection, we can expect that small-sized invalid region would
>>>>> expand soon with OPU, deletion or garbage collection on valid datas, so
>>>>> it's better to delay or skip issuing smaller size discards, it could help
>>>>> to reduce overmuch consumption of IO bandwidth and lifetime of flash
>>>>> storage.
>>>>>
>>>>> This patch makes f2fs selectng 64K size as its default minimal
>>>>> granularity, and issue discard with the size which is not smaller than
>>>>> minimal granularity. Also it exposes discard granularity as sysfs entry
>>>>> for configuration in different scenario.
>>>>>
>>>>> Jaegeuk Kim:
>>>>>  We must issue all the accumulated discard commands when fstrim is called.
>>>>>  So, I've added pend_list_tag[] to indicate whether we should issue the
>>>>>  commands or not. If tag sets P_ACTIVE or P_TRIM, we have to issue them.
>>>>>  P_TRIM is set once at a time, given fstrim trigger.
>>>>>  In addition, issue_discard_thread is calling too much due to the number of
>>>>>  discard commands remaining in the pending list. I added a timer to control
>>>>>  it likewise gc_thread.
>>>>>
>>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>> ---
>>>>>  Documentation/ABI/testing/sysfs-fs-f2fs |  9 ++++
>>>>>  fs/f2fs/f2fs.h                          | 12 +++++
>>>>>  fs/f2fs/segment.c                       | 91 ++++++++++++++++++++++++++++-----
>>>>>  fs/f2fs/sysfs.c                         | 23 +++++++++
>>>>>  4 files changed, 121 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
>>>>> index 621da3fc56c5..11b7f4ebea7c 100644
>>>>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>>>>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>>>>> @@ -57,6 +57,15 @@ Contact:     "Jaegeuk Kim" <jaegeuk.kim@samsung.com>
>>>>>  Description:
>>>>>                  Controls the issue rate of small discard commands.
>>>>>
>>>>> +What:          /sys/fs/f2fs/<disk>/discard_granularity
>>>>> +Date:          July 2017
>>>>> +Contact:       "Chao Yu" <yuchao0@huawei.com>
>>>>> +Description:
>>>>> +               Controls discard granularity of inner discard thread, inner thread
>>>>> +               will not issue discards with size that is smaller than granularity.
>>>>> +               The unit size is one block, now only support configuring in range
>>>>> +               of [1, 512].
>>>>> +
>>>>>  What:          /sys/fs/f2fs/<disk>/max_victim_search
>>>>>  Date:          January 2014
>>>>>  Contact:       "Jaegeuk Kim" <jaegeuk.kim@samsung.com>
>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>> index e252e5bf9791..4b993961d81d 100644
>>>>> --- a/fs/f2fs/f2fs.h
>>>>> +++ b/fs/f2fs/f2fs.h
>>>>> @@ -148,6 +148,8 @@ enum {
>>>>>                 (BATCHED_TRIM_SEGMENTS(sbi) << (sbi)->log_blocks_per_seg)
>>>>>  #define MAX_DISCARD_BLOCKS(sbi)                BLKS_PER_SEC(sbi)
>>>>>  #define DISCARD_ISSUE_RATE             8
>>>>> +#define DEF_MIN_DISCARD_ISSUE_TIME     50      /* 50 ms, if exists */
>>>>> +#define DEF_MAX_DISCARD_ISSUE_TIME     60000   /* 60 s, if no candidates */
>>>>>  #define DEF_CP_INTERVAL                        60      /* 60 secs */
>>>>>  #define DEF_IDLE_INTERVAL              5       /* 5 secs */
>>>>>
>>>>> @@ -196,11 +198,18 @@ struct discard_entry {
>>>>>         unsigned char discard_map[SIT_VBLOCK_MAP_SIZE]; /* segment discard bitmap */
>>>>>  };
>>>>>
>>>>> +/* default discard granularity of inner discard thread, unit: block count */
>>>>> +#define DEFAULT_DISCARD_GRANULARITY            16
>>>>> +
>>>>>  /* max discard pend list number */
>>>>>  #define MAX_PLIST_NUM          512
>>>>>  #define plist_idx(blk_num)     ((blk_num) >= MAX_PLIST_NUM ?           \
>>>>>                                         (MAX_PLIST_NUM - 1) : (blk_num - 1))
>>>>>
>>>>> +#define P_ACTIVE       0x01
>>>>> +#define P_TRIM         0x02
>>>>> +#define plist_issue(tag)       (((tag) & P_ACTIVE) || ((tag) & P_TRIM))
>>>>> +
>>>>>  enum {
>>>>>         D_PREP,
>>>>>         D_SUBMIT,
>>>>> @@ -236,11 +245,14 @@ struct discard_cmd_control {
>>>>>         struct task_struct *f2fs_issue_discard; /* discard thread */
>>>>>         struct list_head entry_list;            /* 4KB discard entry list */
>>>>>         struct list_head pend_list[MAX_PLIST_NUM];/* store pending entries */
>>>>> +       unsigned char pend_list_tag[MAX_PLIST_NUM];/* tag for pending entries */
>>>>>         struct list_head wait_list;             /* store on-flushing entries */
>>>>>         wait_queue_head_t discard_wait_queue;   /* waiting queue for wake-up */
>>>>> +       unsigned int discard_wake;              /* to wake up discard thread */
>>>>>         struct mutex cmd_lock;
>>>>>         unsigned int nr_discards;               /* # of discards in the list */
>>>>>         unsigned int max_discards;              /* max. discards to be issued */
>>>>> +       unsigned int discard_granularity;       /* discard granularity */
>>>>>         unsigned int undiscard_blks;            /* # of undiscard blocks */
>>>>>         atomic_t issued_discard;                /* # of issued discard */
>>>>>         atomic_t issing_discard;                /* # of issing discard */
>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>> index 05144b3a7f62..1387925a0d83 100644
>>>>> --- a/fs/f2fs/segment.c
>>>>> +++ b/fs/f2fs/segment.c
>>>>> @@ -1016,32 +1016,65 @@ static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
>>>>>         return 0;
>>>>>  }
>>>>>
>>>>> -static void __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
>>>>> +static int __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
>>>>>  {
>>>>>         struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>>>>>         struct list_head *pend_list;
>>>>>         struct discard_cmd *dc, *tmp;
>>>>>         struct blk_plug plug;
>>>>> -       int i, iter = 0;
>>>>> +       int iter = 0, issued = 0;
>>>>> +       int i;
>>>>>
>>>>>         mutex_lock(&dcc->cmd_lock);
>>>>>         f2fs_bug_on(sbi,
>>>>>                 !__check_rb_tree_consistence(sbi, &dcc->root));
>>>>>         blk_start_plug(&plug);
>>>>> -       for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
>>>>> +       for (i = MAX_PLIST_NUM - 1;
>>>>> +                       i >= 0 && plist_issue(dcc->pend_list_tag[i]); i--) {
>>>>>                 pend_list = &dcc->pend_list[i];
>>>>>                 list_for_each_entry_safe(dc, tmp, pend_list, list) {
>>>>>                         f2fs_bug_on(sbi, dc->state != D_PREP);
>>>>>
>>>>> -                       if (!issue_cond || is_idle(sbi))
>>>>> +                       /* Hurry up to finish fstrim */
>>>>> +                       if (dcc->pend_list_tag[i] & P_TRIM) {
>>>>> +                               __submit_discard_cmd(sbi, dc);
>>>>> +                               issued++;
>>>>> +                               continue;
>>>>> +                       }
>>>>> +
>>>>> +                       if (!issue_cond || is_idle(sbi)) {
>>>>> +                               issued++;
>>>>>                                 __submit_discard_cmd(sbi, dc);
>>>>> +                       }
>>>>>                         if (issue_cond && iter++ > DISCARD_ISSUE_RATE)
>>>>>                                 goto out;
>>>>>                 }
>>>>> +               if (list_empty(pend_list) && dcc->pend_list_tag[i] & P_TRIM)
>>>>> +                       dcc->pend_list_tag[i] &= (~P_TRIM);
>>>>>         }
>>>>>  out:
>>>>>         blk_finish_plug(&plug);
>>>>>         mutex_unlock(&dcc->cmd_lock);
>>>>> +
>>>>> +       return issued;
>>>>> +}
>>>>> +
>>>>> +static void __drop_discard_cmd(struct f2fs_sb_info *sbi)
>>>>> +{
>>>>> +       struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>>>>> +       struct list_head *pend_list;
>>>>> +       struct discard_cmd *dc, *tmp;
>>>>> +       int i;
>>>>> +
>>>>> +       mutex_lock(&dcc->cmd_lock);
>>>>> +       for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
>>>>> +               pend_list = &dcc->pend_list[i];
>>>>> +               list_for_each_entry_safe(dc, tmp, pend_list, list) {
>>>>> +                       f2fs_bug_on(sbi, dc->state != D_PREP);
>>>>> +                       __remove_discard_cmd(sbi, dc);
>>>>> +               }
>>>>> +       }
>>>>> +       mutex_unlock(&dcc->cmd_lock);
>>>>>  }
>>>>>
>>>>>  static void __wait_one_discard_bio(struct f2fs_sb_info *sbi,
>>>>> @@ -1126,34 +1159,56 @@ void stop_discard_thread(struct f2fs_sb_info *sbi)
>>>>>  void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
>>>>>  {
>>>>>         __issue_discard_cmd(sbi, false);
>>>>> +       __drop_discard_cmd(sbi);
>>>>>         __wait_discard_cmd(sbi, false);
>>>>>  }
>>>>>
>>>>> +static void mark_discard_range_all(struct f2fs_sb_info *sbi)
>>>>> +{
>>>>> +       struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>>>>> +       int i;
>>>>> +
>>>>> +       mutex_lock(&dcc->cmd_lock);
>>>>> +       for (i = 0; i < MAX_PLIST_NUM; i++)
>>>>> +               dcc->pend_list_tag[i] |= P_TRIM;
>>>>> +       mutex_unlock(&dcc->cmd_lock);
>>>>> +}
>>>>> +
>>>>>  static int issue_discard_thread(void *data)
>>>>>  {
>>>>>         struct f2fs_sb_info *sbi = data;
>>>>>         struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>>>>>         wait_queue_head_t *q = &dcc->discard_wait_queue;
>>>>> +       unsigned int wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
>>>>> +       int issued;
>>>>>
>>>>>         set_freezable();
>>>>>
>>>>>         do {
>>>>> -               wait_event_interruptible(*q, kthread_should_stop() ||
>>>>> -                                       freezing(current) ||
>>>>> -                                       atomic_read(&dcc->discard_cmd_cnt));
>>>>> +               wait_event_interruptible_timeout(*q,
>>>>> +                               kthread_should_stop() || freezing(current) ||
>>>>> +                               dcc->discard_wake,
>>>>> +                               msecs_to_jiffies(wait_ms));
>>>>>                 if (try_to_freeze())
>>>>>                         continue;
>>>>>                 if (kthread_should_stop())
>>>>>                         return 0;
>>>>>
>>>>> +               if (dcc->discard_wake)
>>>>> +                       dcc->discard_wake = 0;
>>>>> +
>>>>>                 sb_start_intwrite(sbi->sb);
>>>>>
>>>>> -               __issue_discard_cmd(sbi, true);
>>>>> -               __wait_discard_cmd(sbi, true);
>>>>> +               issued = __issue_discard_cmd(sbi, true);
>>>>> +               if (issued) {
>>>>> +                       __wait_discard_cmd(sbi, true);
>>>>> +                       wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
>>>>> +               } else {
>>>>> +                       wait_ms = DEF_MAX_DISCARD_ISSUE_TIME;
>>>>> +               }
>>>>>
>>>>>                 sb_end_intwrite(sbi->sb);
>>>>>
>>>>> -               congestion_wait(BLK_RW_SYNC, HZ/50);
>>>>>         } while (!kthread_should_stop());
>>>>>         return 0;
>>>>>  }
>>>>> @@ -1344,7 +1399,8 @@ static void set_prefree_as_free_segments(struct f2fs_sb_info *sbi)
>>>>>
>>>>>  void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>>  {
>>>>> -       struct list_head *head = &(SM_I(sbi)->dcc_info->entry_list);
>>>>> +       struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>>>>> +       struct list_head *head = &dcc->entry_list;
>>>>>         struct discard_entry *entry, *this;
>>>>>         struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
>>>>>         unsigned long *prefree_map = dirty_i->dirty_segmap[PRE];
>>>>> @@ -1426,11 +1482,12 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>>                         goto find_next;
>>>>>
>>>>>                 list_del(&entry->list);
>>>>> -               SM_I(sbi)->dcc_info->nr_discards -= total_len;
>>>>> +               dcc->nr_discards -= total_len;
>>>>>                 kmem_cache_free(discard_entry_slab, entry);
>>>>>         }
>>>>>
>>>>> -       wake_up(&SM_I(sbi)->dcc_info->discard_wait_queue);
>>>>> +       dcc->discard_wake = 1;
>>>>> +       wake_up_interruptible_all(&dcc->discard_wait_queue);
>>>>>  }
>>>>>
>>>>>  static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>>>>> @@ -1448,9 +1505,13 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>>>>>         if (!dcc)
>>>>>                 return -ENOMEM;
>>>>>
>>>>> +       dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
>>>>>         INIT_LIST_HEAD(&dcc->entry_list);
>>>>> -       for (i = 0; i < MAX_PLIST_NUM; i++)
>>>>> +       for (i = 0; i < MAX_PLIST_NUM; i++) {
>>>>>                 INIT_LIST_HEAD(&dcc->pend_list[i]);
>>>>> +               if (i >= dcc->discard_granularity - 1)
>>>>> +                       dcc->pend_list_tag[i] |= P_ACTIVE;
>>>>> +       }
>>>>>         INIT_LIST_HEAD(&dcc->wait_list);
>>>>>         mutex_init(&dcc->cmd_lock);
>>>>>         atomic_set(&dcc->issued_discard, 0);
>>>>> @@ -2127,6 +2188,8 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
>>>>>
>>>>>                 schedule();
>>>>>         }
>>>>> +       /* It's time to issue all the filed discards */
>>>>> +       mark_discard_range_all(sbi);
>>>>>  out:
>>>>>         range->len = F2FS_BLK_TO_BYTES(cpc.trimmed);
>>>>>         return err;
>>>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>>>>> index c40e5d24df9f..4bcaa9059026 100644
>>>>> --- a/fs/f2fs/sysfs.c
>>>>> +++ b/fs/f2fs/sysfs.c
>>>>> @@ -152,6 +152,27 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
>>>>>                 spin_unlock(&sbi->stat_lock);
>>>>>                 return count;
>>>>>         }
>>>>> +
>>>>> +       if (!strcmp(a->attr.name, "discard_granularity")) {
>>>>> +               struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>>>>> +               int i;
>>>>> +
>>>>> +               if (t == 0 || t > MAX_PLIST_NUM)
>>>>> +                       return -EINVAL;
>>>>> +               if (t == *ui)
>>>>> +                       return count;
>>>>> +
>>>>> +               mutex_lock(&dcc->cmd_lock);
>>>>> +               for (i = 0; i < MAX_PLIST_NUM; i++) {
>>>>> +                       if (i >= t - 1)
>>>>> +                               dcc->pend_list_tag[i] |= P_ACTIVE;
>>>>> +                       else
>>>>> +                               dcc->pend_list_tag[i] &= (~P_ACTIVE);
>>>>> +               }
>>>>> +               mutex_unlock(&dcc->cmd_lock);
>>>>> +               return count;
>>>>> +       }
>>>>> +
>>>>>         *ui = t;
>>>>>
>>>>>         if (!strcmp(a->attr.name, "iostat_enable") && *ui == 0)
>>>>> @@ -248,6 +269,7 @@ F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_idle, gc_idle);
>>>>>  F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_urgent, gc_urgent);
>>>>>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, reclaim_segments, rec_prefree_segments);
>>>>>  F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_small_discards, max_discards);
>>>>> +F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_granularity, discard_granularity);
>>>>>  F2FS_RW_ATTR(RESERVED_BLOCKS, f2fs_sb_info, reserved_blocks, reserved_blocks);
>>>>>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, batched_trim_sections, trim_sections);
>>>>>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
>>>>> @@ -290,6 +312,7 @@ static struct attribute *f2fs_attrs[] = {
>>>>>         ATTR_LIST(gc_urgent),
>>>>>         ATTR_LIST(reclaim_segments),
>>>>>         ATTR_LIST(max_small_discards),
>>>>> +       ATTR_LIST(discard_granularity),
>>>>>         ATTR_LIST(batched_trim_sections),
>>>>>         ATTR_LIST(ipu_policy),
>>>>>         ATTR_LIST(min_ipu_util),
>>>>> --
>>>>> 2.14.0.rc1.383.gd1ce394fe2-goog
>>>>>
>>>>>
>>>>> ------------------------------------------------------------------------------
>>>>> Check out the vibrant tech community on one of the world's most
>>>>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>>>>> _______________________________________________
>>>>> Linux-f2fs-devel mailing list
>>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
