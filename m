From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs corruption due to f2fs_gc crash.
Date: Fri, 20 Jan 2017 07:43:00 +0800
Message-ID: <20170119234300.GB42028@jaegeuk.local>
References: <ae02335a-e8ac-9891-5ebe-015315250899@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cUMMM-0005v0-Sb
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Jan 2017 23:43:14 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cUMML-0001fa-MM
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Jan 2017 23:43:14 +0000
Content-Disposition: inline
In-Reply-To: <ae02335a-e8ac-9891-5ebe-015315250899@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: KARBOWSKI Piotr <piotr.karbowski@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hello,

On 01/19, KARBOWSKI Piotr wrote:
> Hello,
> 
> I am running a system with a microSD card, on the top of which a dmcrypt 
> luks is used, and f2fs on that.
> 
> Every time I boot my system, fsck takes a fair amount of time to fix the 
> filesystem. Shortly after boot I can spot a f2fs_gc crash (I suppose 
> it's crash) in the kernel log.
> 
> [    0.000000] CPU: 4 PID: 2286 Comm: f2fs_gc-253:6 Not tainted 4.9.4 #1
> [    0.000000] Hardware name: LENOVO 20AUA1FFPB/20AUA1FFPB, BIOS 
> J4ET87WW(1.87) 09/21/2016
> [    0.000000]  0000000000000000 ffffffff81452dd9 0000000000000000 
> 0000000000000000
> [    0.000000]  ffffffff810b1099 0000000000000000 ffffc90005113da0 
> 0000000000000007
> [    0.000000]  0000000000000006 0000000000000006 ffff880213bc8000 
> ffffffff813ef8a3
> [    0.000000] Call Trace:
> [    0.000000]  [<ffffffff81452dd9>] ? dump_stack+0x46/0x5d
> [    0.000000]  [<ffffffff810b1099>] ? __warn+0xb9/0xe0
> [    0.000000]  [<ffffffff813ef8a3>] ? do_garbage_collect+0xb03/0xbe0
> [    0.000000]  [<ffffffff810e184b>] ? dequeue_task_fair+0x5ab/0x1300
> [    0.000000]  [<ffffffff813efc1f>] ? f2fs_gc+0x15f/0x4b0
> [    0.000000]  [<ffffffff813f01f7>] ? gc_thread_func+0x287/0x360
> [    0.000000]  [<ffffffff8181cc63>] ? __schedule+0x173/0x5f0
> [    0.000000]  [<ffffffff810ea2c0>] ? wake_atomic_t_function+0x50/0x50
> [    0.000000]  [<ffffffff813eff70>] ? f2fs_gc+0x4b0/0x4b0
> [    0.000000]  [<ffffffff810b558e>] ? do_group_exit+0x2e/0xa0
> [    0.000000]  [<ffffffff810ccf39>] ? kthread+0xb9/0xd0
> [    0.000000]  [<ffffffff810cce80>] ? kthread_park+0x50/0x50
> [    0.000000]  [<ffffffff81820b12>] ? ret_from_fork+0x22/0x30
> [    0.000000] ---[ end trace c7ec9ea0d14d95b3 ]---
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 2286 at fs/f2fs/gc.c:866 
> do_garbage_collect+0xb03/0xbe0
> [    0.000000] Modules linked in: ctr ccm algif_skcipher af_alg 
> ipt_MASQUERADE iptable_nat mmc_block arc4 rtsx_pci_sdmmc mmc_core 
> snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic iwlmvm 
> mac80211 snd_hda_intel snd_hda_codec snd_hwdep snd_hda_core snd_pcm 
> snd_timer iwlwifi cfg80211 rtsx_pci mfd_core coretemp kvm_intel 
> thinkpad_acpi snd soundcore rfkill
> [    0.000000] CPU: 0 PID: 2286 Comm: f2fs_gc-253:6 Tainted: G        W 
>       4.9.4 #1
> [    0.000000] Hardware name: LENOVO 20AUA1FFPB/20AUA1FFPB, BIOS 
> J4ET87WW(1.87) 09/21/2016
> [    0.000000]  0000000000000000 ffffffff81452dd9 0000000000000000 
> 0000000000000000
> [    0.000000]  ffffffff810b1099 0000000000000000 ffffc90005113da0 
> 0000000000000008
> [    0.000000]  0000000000000007 0000000000000007 ffff880213bc8000 
> ffffffff813ef8a3
> [    0.000000] Call Trace:
> [    0.000000]  [<ffffffff81452dd9>] ? dump_stack+0x46/0x5d
> [    0.000000]  [<ffffffff810b1099>] ? __warn+0xb9/0xe0
> [    0.000000]  [<ffffffff813ef8a3>] ? do_garbage_collect+0xb03/0xbe0
> [    0.000000]  [<ffffffff810e184b>] ? dequeue_task_fair+0x5ab/0x1300
> [    0.000000]  [<ffffffff813efc1f>] ? f2fs_gc+0x15f/0x4b0
> [    0.000000]  [<ffffffff813f01f7>] ? gc_thread_func+0x287/0x360
> [    0.000000]  [<ffffffff8181cc63>] ? __schedule+0x173/0x5f0
> [    0.000000]  [<ffffffff810ea2c0>] ? wake_atomic_t_function+0x50/0x50
> [    0.000000]  [<ffffffff813eff70>] ? f2fs_gc+0x4b0/0x4b0
> [    0.000000]  [<ffffffff810b558e>] ? do_group_exit+0x2e/0xa0
> [    0.000000]  [<ffffffff810ccf39>] ? kthread+0xb9/0xd0
> [    0.000000]  [<ffffffff810cce80>] ? kthread_park+0x50/0x50
> [    0.000000]  [<ffffffff81820b12>] ? ret_from_fork+0x22/0x30
> [    0.000000] ---[ end trace c7ec9ea0d14d95b4 ]---
> 
> 
> I had this on kernel 4.8 and 4.9. I have another system, where I also 
> use f2fs over dmcrypt, but on ssd not microSD card and I see no problem 
> there. Could you please comment on this?

Thank you for the report.
If possible, could you share the fsck log whether it repaired something?
That message is caused by wrong summary type, which is able to be fixed by
fsck.

Thanks,

> 
> -- Piotr.
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
