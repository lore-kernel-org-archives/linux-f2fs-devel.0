Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1B4C53200
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Jul 2026 03:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U00MW+C6EtNdjb1DzIvazA+mfCpBwVWM8E7m+Y+yKSE=; b=fwlvY17+vlyrbysA3TPy+Mmwsi
	gKYByF1RSH0/OpKoq6gBuZbf2wBZRkG4YDLXJaOE4pR3UxgzRq7yzvrRMo1ir2lNV2DAMrtrzJT4A
	S7rTMR5PMm4Zaap5r2APo9NogmyXwYC/r3A6xJSwVGiUpFbmuGZ2W5ZPW1Cvvg1lboqM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wovBC-0008IT-KQ;
	Wed, 29 Jul 2026 03:42:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wovBB-0008IJ-09
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 03:42:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eHgFkfWejT9do5fnb5Hr+6Q3B6RHUXfwb+ipYzt9I0g=; b=LbKugNcz9WKm8vHoHO7UbNO74C
 Yiu4k+Uk4qajAE/ZXE/wlo2D9mg2xsc5WGH8F2tA4LaVvmHGuMQ6bwJJE5MlqQscE6EO++Zr3I+E4
 UzyfcLYJOVJ/DYIs8cTWDGE0DM8LjPxGffKW+EJBl9/U+Kf6W0+oITbmPVZiT2+E4M6A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eHgFkfWejT9do5fnb5Hr+6Q3B6RHUXfwb+ipYzt9I0g=; b=jdH4ZdGjlmZ5wCXG2woS2ySiSu
 OKa4/DKxDx+3sALBOpf4KiM/uZiury1MHLn0x9ALdjr1OPT2E6s2+KzTuDMFMAqISojvxS1C2cCIR
 oIEf+FBj2iD3AuwuMphbIwK0eGj4kySRStlyT6+p1ykEfZ/7zKXZq+1arHU9OtsaPx+E=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wovBA-0007zV-8p for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 03:42:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DDE5543C58
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 03:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4141F00A3D;
 Wed, 29 Jul 2026 03:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785296514;
 bh=eHgFkfWejT9do5fnb5Hr+6Q3B6RHUXfwb+ipYzt9I0g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SFVR1AG4945SdDvP837m6LiiONVurVoyEN0hS6y0bBO78tR/gOvj7ZxMQZOj7Wpb5
 2+idyjd1VN6YKfNZST/gvPmiQcvXT1dTO4oJAcQ4Oduocvl0BrRNQdj1xqbYJkJiaI
 G7oQuQ2zA7k/IxUoaCQFqQ5xUvt/tG4t7ehUaf+oTfCb8+ue56BRHAmDtV0mWK4+gF
 p/yBtF1n6Wc0Yz2/S+xen7KjzTOd5zNrxY18uqesND1X1IoS1lxHAZUfEDoDYF6qmU
 ruGq71PhRXA9ZtBCK0uINP7bn4Q9UkSTvXCt4aTBTEyBIi1bO7J9LTQR5uAgjSgIkW
 rRE9ozuPR0gGw==
Date: Wed, 29 Jul 2026 03:41:53 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <aml2gcHER_hlCpjU@google.com>
References: <20260706072606.3709384-1-chao@kernel.org>
 <alfL3c5Br1wQhvfb@google.com>
 <9aa5a524-de44-4d07-b6df-70776dd7b0e5@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9aa5a524-de44-4d07-b6df-70776dd7b0e5@kernel.org>
X-Headers-End: 1wovBA-0007zV-8p
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to zero post-EOF data when
 extending file size
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 07/20, Chao Yu via Linux-f2fs-devel wrote:
> On 7/16/26 02:05, Jaegeuk Kim wrote:
> > This causes sysmtem hang during xfstests.
> 
> Fixed a potential deadlock issue during checkpoint in v2, though I can
> not reproduce it.

I got this on generic/269 with v2. I'll dequeue the patch first.

[   90.879237] ------------[ cut here ]------------
[   90.881987] kernel BUG at segment.c:2902!
[   90.884058] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[   90.886628] CPU: 7 UID: 0 PID: 2566 Comm: f2fs_ckpt-252:3 Tainted: G           OE       7.2.0-rc5-custom #1 PREEMPT(full)
[   90.891533] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   90.894647] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[   90.900014] RIP: 0010:new_curseg+0xa17/0xa60 [f2fs]
[   90.902240] Code: 8b 71 48 e9 16 f8 ff ff 4c 8b 69 08 41 8b 84 24 4c 06 00 00 31 d2 41 8b 8c 24 48 06 00 00 f7 f1 89 45 a4 89 f0 e9 e9 fe ff ff <0f> 0b 49 8b 3c 24 68 40 0c 00 00 45 31 c0 31 c9 41 b9 8b ff ff ff
[   90.910818] RSP: 0018:ffffd4acc4167670 EFLAGS: 00010293
[   90.913153] RAX: 00000000000000f8 RBX: 0000000000000000 RCX: 0000000000000000
[   90.916400] RDX: ffffffffffffffff RSI: 00000000000000f8 RDI: 00000000000000f8
[   90.919494] RBP: ffffd4acc41676d0 R08: ffff8d640bdab2a0 R09: ffffffffc10673eb
[   90.923182] R10: 00000000000000f8 R11: 0000000000000014 R12: ffff8d64892c6000
[   90.926315] R13: ffff8d648c236b80 R14: 00000000000000f8 R15: 0000000000000000
[   90.929430] FS:  0000000000000000(0000) GS:ffff8d6504b73000(0000) knlGS:0000000000000000
[   90.933668] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   90.937206] CR2: 00005577fade9868 CR3: 0000000092d82002 CR4: 0000000000372ef0
[   90.940305] Call Trace:
[   90.941486]  <TASK>
[   90.942464]  f2fs_allocate_data_block+0x69b/0xb10 [f2fs]
[   90.944862]  do_write_page+0x72/0x360 [f2fs]
[   90.946798]  ? __folio_start_writeback+0x90/0x1d0
[   90.949485]  f2fs_do_write_node_page+0x35/0x70 [f2fs]
[   90.952813]  __write_node_folio+0x33c/0x640 [f2fs]
[   90.955104]  ? debug_smp_processor_id+0x17/0x20
[   90.957550]  f2fs_sync_node_pages+0x3d8/0x530 [f2fs]
[   90.960954]  block_operations+0x41d/0x590 [f2fs]
[   90.963415]  ? __pfx_issue_checkpoint_thread+0x10/0x10 [f2fs]
[   90.966293]  f2fs_write_checkpoint+0x15a/0x13c0 [f2fs]
[   90.969193]  ? update_load_avg+0x79/0x2e0
[   90.971712]  ? kvm_clock_get_cycles+0x18/0x40
[   90.974030]  ? module_sect_read+0x81/0xc0
[   90.976675]  ? __pfx_issue_checkpoint_thread+0x10/0x10 [f2fs]
[   90.980146]  __write_checkpoint_sync+0x75/0xb0 [f2fs]
[   90.983100]  __checkpoint_and_complete_reqs+0x3b/0x110 [f2fs]
[   90.986332]  ? __pfx_issue_checkpoint_thread+0x10/0x10 [f2fs]
[   90.989853]  issue_checkpoint_thread+0x4b/0x100 [f2fs]
[   90.992622]  ? __pfx_autoremove_wake_function+0x10/0x10
[   90.995875]  kthread+0x10a/0x140
[   90.998141]  ? __pfx_kthread+0x10/0x10
[   91.000585]  ret_from_fork+0x1ef/0x2b0
[   91.002565]  ? __pfx_kthread+0x10/0x10
[   91.004510]  ret_from_fork_asm+0x1a/0x30

> 
> Thanks,
> 
> > 
> > On 07/06, Chao Yu via Linux-f2fs-devel wrote:
> > > generic/794  4s ... - output mismatch (see /share/git/fstests/results//generic/794.out.bad)
> > >      --- tests/generic/794.out   2026-06-12 08:46:32.766426241 +0800
> > >      +++ /share/git/fstests/results//generic/794.out.bad 2026-07-05 18:32:55.000000000 +0800
> > >      @@ -1,4 +1,16 @@
> > >       QA output created by 794
> > >       append_write
> > >      +FAIL: non-zero data in gap [4080,4096) after shutdown+remount
> > >      +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> > >      +*
> > >      +001000
> > >       truncate_up
> > >      ...
> > >      (Run 'diff -u /share/git/fstests/tests/generic/794.out /share/git/fstests/results//generic/794.out.bad'  to see the entire diff)
> > > Ran: generic/794
> > > Failures: generic/794
> > > Failed 1 of 1 tests
> > > 
> > > Steps of generic/794:
> > > 1. write 4096 bytes to file w/ 0x5a
> > > 2. use fiemap to get PBA of first block in file
> > > 3. truncate file to 4080
> > > 4. umount; write 4096 bytes to file w/ 0x5a directly via PBA; mount
> > > 5. extend filesize via
> > >     a) append 4096 from offset 4096, or
> > >     b) truncate 8192, or
> > >     c) fallocate 4096 from offset 4096
> > > 6. verify the gap is zeroed in memory [4080,4096)
> > > 7. sync range 4096 from offset 4096; shutdown -f (flush meta before shutdown)
> > > 8. umount; mount; verify [4080,4096) is zeroed or not.
> > > 
> > > When extending file size (e.g. via truncate, fallocate, or write) across an
> > > unaligned EOF boundary, we need to ensure that post-EOF data in the partial
> > > page is zeroed out in pagecache and marked dirty, meanwhile, tagging the inode
> > > with FI_ZERO_POST_EOF, so that following checkpoint() and fsync() can persist
> > > the page contain zeroed data before committing inode w/ updated i_size.
> > > 
> > > This help to prevent stale disk data beyond the previous EOF from being exposed
> > > after remounting or crash recovery.
> > > 
> > > Since f2fs is a LFS filesystem, we only support direct write via PBA in pinfile,
> > > and pinfile has section-aligned filesize, so in Android, there should no problem,
> > > but for other usage in different environment, let's fix this w/ fsync_mode=strict
> > > mount option.
> > > 
> > > Cc: stable@kernel.org
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > >   fs/f2fs/checkpoint.c |  4 ++++
> > >   fs/f2fs/f2fs.h       |  1 +
> > >   fs/f2fs/file.c       | 35 ++++++++++++++++++++++++++++++++---
> > >   3 files changed, 37 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > > index 064f5b537423..6f486d3a94c7 100644
> > > --- a/fs/f2fs/checkpoint.c
> > > +++ b/fs/f2fs/checkpoint.c
> > > @@ -1359,6 +1359,10 @@ static int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi)
> > >   		inode = igrab(&fi->vfs_inode);
> > >   		spin_unlock(&sbi->inode_lock[DIRTY_META]);
> > >   		if (inode) {
> > > +			if (is_inode_flag_set(inode, FI_ZERO_POST_EOF)) {
> > > +				filemap_write_and_wait(inode->i_mapping);
> > > +				clear_inode_flag(inode, FI_ZERO_POST_EOF);
> > > +			}
> > >   			sync_inode_metadata(inode, 0);
> > >   			/* it's on eviction */
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index 8e2fb0bda467..41be09dad43c 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -939,6 +939,7 @@ enum {
> > >   	FI_ATOMIC_REPLACE,	/* indicate atomic replace */
> > >   	FI_OPENED_FILE,		/* indicate file has been opened */
> > >   	FI_DONATE_FINISHED,	/* indicate page donation of file has been finished */
> > > +	FI_ZERO_POST_EOF,	/* indicate unaligned EOF gap was zeroed in pagecache */
> > >   	FI_MAX,			/* max flag, never be used */
> > >   };
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index 11cc8d79c235..2e9d585073ec 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -36,21 +36,43 @@
> > >   #include <trace/events/f2fs.h>
> > >   #include <uapi/linux/f2fs.h>
> > > +static int fill_zero(struct inode *inode, pgoff_t index,
> > > +					loff_t start, loff_t len);
> > > +
> > >   static void f2fs_zero_post_eof_page(struct inode *inode,
> > >   					loff_t new_size, bool lock)
> > >   {
> > >   	loff_t old_size = i_size_read(inode);
> > > +	unsigned int offset;
> > >   	if (old_size >= new_size)
> > >   		return;
> > > -	if (mapping_empty(inode->i_mapping))
> > > -		return;
> > > -
> > >   	if (lock)
> > >   		filemap_invalidate_lock(inode->i_mapping);
> > > +
> > >   	/* zero or drop pages only in range of [old_size, new_size] */
> > >   	truncate_inode_pages_range(inode->i_mapping, old_size, new_size);
> > > +
> > > +	/*
> > > +	 * When expanding an unaligned EOF size, zero post-EOF data in
> > > +	 * pagecache and set FI_ZERO_POST_EOF, so following checkpointing
> > > +	 * or fsync can persist correct data to disk before committing
> > > +	 * inode w/ updated i_size.
> > > +	 */
> > > +	if (F2FS_OPTION(F2FS_I_SB(inode)).fsync_mode != FSYNC_MODE_STRICT)
> > > +		goto out_unlock;
> > > +
> > > +	offset = old_size & (PAGE_SIZE - 1);
> > > +	if (offset) {
> > > +		unsigned int len = min_t(loff_t, PAGE_SIZE - offset,
> > > +							new_size - old_size);
> > > +		pgoff_t index = old_size >> PAGE_SHIFT;
> > > +
> > > +		fill_zero(inode, index, offset, len);
> > > +		set_inode_flag(inode, FI_ZERO_POST_EOF);
> > > +	}
> > > +out_unlock:
> > >   	if (lock)
> > >   		filemap_invalidate_unlock(inode->i_mapping);
> > >   }
> > > @@ -304,6 +326,13 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
> > >   	if (S_ISDIR(inode->i_mode))
> > >   		goto go_write;
> > > +	if (is_inode_flag_set(inode, FI_ZERO_POST_EOF)) {
> > > +		ret = filemap_write_and_wait(inode->i_mapping);
> > > +		if (ret)
> > > +			return ret;
> > > +		clear_inode_flag(inode, FI_ZERO_POST_EOF);
> > > +	}
> > > +
> > >   	/* if fdatasync is triggered, let's do in-place-update */
> > >   	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
> > >   		set_inode_flag(inode, FI_NEED_IPU);
> > > -- 
> > > 2.49.0
> > > 
> > > 
> > > 
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
