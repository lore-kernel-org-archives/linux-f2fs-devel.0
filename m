From: Tom Li <biergaizi@members.fsf.org>
Subject: Mount a f2fs file system after the power cut cause
	kernel oops
Date: Thu, 23 Jan 2014 05:28:04 +0800
Message-ID: <CAB6YEzWo9jhXLDL2JRs4cy9tHtiH1v9RzAhHLyRHyvA4MGPMPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <biergaizi2009@gmail.com>) id 1W65Lc-0002Y3-IB
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Jan 2014 21:28:32 +0000
Received: from mail-pd0-f182.google.com ([209.85.192.182])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1W65Lb-0002QE-8M
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Jan 2014 21:28:32 +0000
Received: by mail-pd0-f182.google.com with SMTP id v10so902015pde.13
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 22 Jan 2014 13:28:25 -0800 (PST)
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

Hello,

    After a power cut, I can not mount my F2FS filesystem. It cause a
Kernel Panic on booting. I dump the image of the partition and tried
to run fsck.f2fs, the output is:

Info: sector size = 512
Info: total sectors = 13264896 (in 512bytes)

    [FSCK] Unreachable nat entries                        [Ok..] [0x0]
    [FSCK] SIT valid block bitmap checking                [Ok..]
    [FSCK] Hard link checking for regular file            [Ok..] [0x3da]
    [FSCK] valid_block_count matching with CP             [Ok..] [0x3ef7c]
    [FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0x13a04]
    [FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x13a04]
    [FSCK] valid_inode_count matched with CP              [Ok..] [0xa2ee]

Done.

    Then I tried to mount it. But it cause a Kernel Oops on my Linux 3.12.7.

[  523.391639] ------------[ cut here ]------------
[  523.391640] kernel BUG at fs/f2fs/recovery.c:309!
[  523.391641] invalid opcode: 0000 [#2] PREEMPT SMP
[  523.391653] Modules linked in: rfcomm btusb ath9k_htc ath9k_common
ath9k_hw ath mac80211 cfg80211 hid_logitech_dj hid_generic zfs(PO)
nvidia(PO) zunicode(PO) bnep bluetooth rfkill usb_storage
snd_hda_codec_realtek zavl(PO) zcommon(PO) znvpair(PO) spl(O)
zlib_deflate r8169 xhci_hcd mii ehci_pci thermal processor fan
snd_hda_intel snd_hda_codec snd_pcm snd_page_alloc snd_timer snd
ehci_hcd thermal_sys soundcore psmouse button pcspkr coretemp hwmon
vboxnetadp(O) vboxnetflt(O) vboxdrv(O)
[  523.391655] CPU: 3 PID: 5511 Comm: mount Tainted: P      D    O
3.12.7-e-nvidia #1
[  523.391656] Hardware name: System manufacturer System Product
Name/P8P67, BIOS 3602 11/01/2012
[  523.391656] task: ffff880214dab480 ti: ffff8800c4dd2000 task.ti:
ffff8800c4dd2000
[  523.391661] RIP: 0010:[<ffffffff81211176>]  [<ffffffff81211176>]
recover_fsync_data+0xdd6/0xde0
[  523.391661] RSP: 0018:ffff8800c4dd3cf0  EFLAGS: 00010297
[  523.391662] RAX: ffff8801fd124000 RBX: ffff880201cbc000 RCX: 000000000008101d
[  523.391662] RDX: 000000001fffffff RSI: ffff880000000000 RDI: ffffea0007f44900
[  523.391663] RBP: 000000002007fffb R08: ffff8802154c1690 R09: ffff88011e45f308
[  523.391663] R10: 0000160000000000 R11: 0000000000000000 R12: ffff8802014f5000
[  523.391664] R13: ffff880208b34cc8 R14: ffff8800c4dd3d60 R15: 00000000000132aa
[  523.391664] FS:  00007f2aa819b780(0000) GS:ffff88021ecc0000(0000)
knlGS:0000000000000000
[  523.391665] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  523.391665] CR2: 00000036ae6385d0 CR3: 00000000ca934000 CR4: 00000000000407e0
[  523.391666] Stack:
[  523.391667]  ffffea0008053d00 ffff880000000000 ffff880208b34c00
ffff8802014f5168
[  523.391668]  0000000008b34c00 ffffffff200803f5 ffffea000000007a
ffff880201dcc4c0
[  523.391669]  ffffea0008053d40 000000000017c1ad 0000000000000007
ffff880201cbc000
[  523.391669] Call Trace:
[  523.391672]  [<ffffffff81203820>] ? f2fs_remount+0x100/0x100
[  523.391673]  [<ffffffff81203ecb>] ? f2fs_fill_super+0x6ab/0x750
[  523.391674]  [<ffffffff8113ecf2>] ? mount_bdev+0x192/0x1d0
[  523.391676]  [<ffffffff8113f63c>] ? mount_fs+0xc/0xb0
[  523.391677]  [<ffffffff81157cd5>] ? vfs_kern_mount+0x55/0xe0
[  523.391679]  [<ffffffff8115a0c1>] ? do_mount+0x1c1/0x9e0
[  523.391681]  [<ffffffff811054b8>] ? memdup_user+0x38/0x70
[  523.391682]  [<ffffffff8115a95c>] ? SyS_mount+0x7c/0xc0
[  523.391683]  [<ffffffff81468e9b>] ? tracesys+0xdd/0xe2
[  523.391692] Code: e9 47 f7 ff ff 45 31 c9 e9 e9 f5 ff ff 4c 89 e7
e8 90 f7 ed ff e9 ff f2 ff ff 0f 0b 48 8b 7c 24 40 e8 7f f7 ed ff e9
c2 f7 ff ff <0f> 0b 0f 1f 84 00 00 00 00 00 80 3e 00 48 8b 47 30 75 17
0f b6
[  523.391693] RIP  [<ffffffff81211176>] recover_fsync_data+0xdd6/0xde0
[  523.391694]  RSP <ffff8800c4dd3cf0>
[  523.391695] ---[ end trace f1ea9d9255c3139d ]---

    The partition doesn't contain any useful data, please don't worry
about it. I hope you can figure out the issue soon.

    Also, I can provide the image of the corrupted partition if needed.

Thanks,

Tom Li.

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
