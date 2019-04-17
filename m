From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: f2fs: SIT corruption upon fsck
Date: Thu, 18 Apr 2019 01:29:36 +0900
Message-ID: <CAD14+f3z580Sabb3kr0oMibZ1E+zbmiYG-zfwJFgZPe4RfY+rQ@mail.gmail.com>
References: <CAD14+f2sT6HbP-vjwWo6A2O151hF=NqcP6_QqLEiEQaZ=QMgoQ@mail.gmail.com>
 <CAD14+f2oNaVbL6X_oHV=C4JMQMBCtH52OY6SSLEAXisza7fANQ@mail.gmail.com>
 <CAD14+f03GwTORdNyKEXo73pTW_1osGfnq6t68mN8w=ipZDrnrQ@mail.gmail.com>
 <20190417141513.GC23731@jaegeuk-macbookpro.roam.corp.google.com>
 <20190417155131.GA33751@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hGnRb-0007JM-59
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 16:29:55 +0000
Received: from mail-qt1-f170.google.com ([209.85.160.170])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hGnRZ-00COio-EQ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 16:29:55 +0000
Received: by mail-qt1-f170.google.com with SMTP id h39so28079873qte.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Apr 2019 09:29:53 -0700 (PDT)
In-Reply-To: <20190417155131.GA33751@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On Thu, Apr 18, 2019 at 12:51 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> nvm. I shoot the email too early. It seems that large_nat_bitmap gave old NAT
> set somehow, so that NAT points the previous checkpointed node blocks, since
> SSA were obsolete and some SIT were valid and others were invalid.
>
> When considering no node block was missing from dentry, I think GC was doing
> between two checkpoints.

For some contexts, this is the same issue I think I reported about 6
months ago, under a very similar scenario. I didn't have the luxury
back then to backup the original working image.

I was re-formatting my f2fs partition as I didn't use the large bitmap
option before. I backed up all the data via 'rsync -a' to another
filesystem, formatted via mkfs.f2fs -i, restored the data back to the
newly formatted f2fs partition(also via rsync) and did a gc_urgent
with 1ms gc_urgent_sleep_time. IIRC GC ran about 5,000 times.

After all that, deleting files from the newly formatted f2fs partition
randomly gave me truncation warnings.
I was just able to reproduce this truncation warning by taking another
btrfs snapshot of the original image and doing 'rm -rf /home'.

[ 4756.407571] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343043
[ 4756.407574] WARNING: CPU: 1 PID: 6473 at fs/f2fs/segment.c:2165
update_sit_entry+0x3a4/0x3f0
[ 4756.407590] CPU: 1 PID: 6473 Comm: rm Tainted: G        W  O
4.19.35-zen+ #1
[ 4756.407591] Hardware name: System manufacturer System Product
Name/ROG MAXIMUS X HERO (WI-FI AC), BIOS 1704 09/14/2018
[ 4756.407591] RIP: 0010:update_sit_entry+0x3a4/0x3f0
[ 4756.407592] Code: ff ff 48 8b 7d 00 44 89 f9 48 c7 c2 e0 e0 58 82
48 c7 c6 93 96 54 82 44 89 4c 24 14 4c 89 44 24 08 44 88 14 24 e8 68
29 fe ff <0f> 0b f0 80 4d 48 04 66 83 03 40 45 31 ed 31 c9 44 0f b6 14
24 4c
[ 4756.407592] RSP: 0018:ffff88849ace3c40 EFLAGS: 00010286
[ 4756.407593] RAX: 0000000000000039 RBX: ffffc90006442fd8 RCX: 0000000000000006
[ 4756.407593] RDX: 0000000000000007 RSI: 0000000000000086 RDI: ffff88884ec56340
[ 4756.407593] RBP: ffff8884b5ee3800 R08: 0000000000063813 R09: 000000000026e1d0
[ 4756.407594] R10: 0000000000000000 R11: ffffffff82d4c26d R12: 000000000001b3ff
[ 4756.407594] R13: 00000000ffffffff R14: 000000000001b3ff R15: 00000000036afc43
[ 4756.407594] FS:  00007fd799482780(0000) GS:ffff88884ec40000(0000)
knlGS:0000000000000000
[ 4756.407595] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4756.407595] CR2: 000036195d5f4000 CR3: 00000005bb1d9002 CR4: 00000000003606e0
[ 4756.407595] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 4756.407596] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 4756.407596] Call Trace:
[ 4756.407597]  ? f2fs_invalidate_blocks+0x83/0x110
[ 4756.407598]  ? f2fs_truncate_data_blocks+0xb9/0x340
[ 4756.407598]  ? truncate_nodes+0x39c/0x570
[ 4756.407599]  ? f2fs_truncate_inode_blocks+0x1a0/0x530
[ 4756.407600]  ? f2fs_truncate_blocks+0x179/0x3e0
[ 4756.407601]  ? f2fs_truncate+0x7a/0xf0
[ 4756.407602]  ? f2fs_evict_inode+0x2f6/0x380
[ 4756.407602]  ? evict+0xbf/0x1e0
[ 4756.407603]  ? do_unlinkat+0x27e/0x330
[ 4756.407604]  ? do_syscall_64+0x4a/0xf0
[ 4756.407604]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 4756.407605] ---[ end trace d1bb53850401c466 ]---

I get ton of these during 'rm' with blk incrementing.
This is the same log but with "F2FS" grepped:

[ 4756.403795] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343002
[ 4756.403888] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343003
[ 4756.404012] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343004
[ 4756.404119] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343005
[ 4756.404213] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343006
[ 4756.404330] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343007
[ 4756.404443] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343008
[ 4756.404537] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343009
[ 4756.404657] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343010
[ 4756.404767] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343011
[ 4756.404860] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343012
[ 4756.404979] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343013
[ 4756.405090] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343014
[ 4756.405183] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343015
[ 4756.405301] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343016
[ 4756.405414] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343017
[ 4756.405506] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343018
[ 4756.405626] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343019
[ 4756.405736] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343020
[ 4756.405831] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343021
[ 4756.405948] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343022
[ 4756.406065] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343023
[ 4756.406161] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343024
[ 4756.406262] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343025
[ 4756.406353] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343026
[ 4756.406437] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343027
[ 4756.406529] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343028
[ 4756.406609] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343029
[ 4756.406677] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343030
[ 4756.406746] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343031
[ 4756.406815] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343032
[ 4756.406884] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343033
[ 4756.406952] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343034
[ 4756.407021] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343035
[ 4756.407089] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343036
[ 4756.407158] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343037
[ 4756.407226] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343038
[ 4756.407294] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343039
[ 4756.407363] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343040
[ 4756.407432] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343041
[ 4756.407503] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343042
[ 4756.407571] F2FS-fs (loop1): Bitmap was wrongly cleared, blk:57343043

I think I can reproduce this by doing the same rsync, mkfs, rsync over
again, though it'll take a hell of a time.
Please note that I didn't have sudden power offs and unmounts were
done cleanly before I ran into those issues, so I think we need some
solution too at the kernel-side, not just fsck.

Judging by my experiences with reformatting f2fs partitions, I'm
fairly certain this is specific to large bitmap. (Now I'm wondering if
f2fs tests(e.g. using xfstests) are also done under large bitmap.) I
didn't have any similar issues with regular bitmap formatted f2fs on
my desktop, laptop and Android.

Thanks.
