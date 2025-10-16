Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FFFCCD199
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vNPBjJZ4JAaZI1K/fWoi0HXgbk8y4YqtzbFt5PuGp1w=; b=YdKqtCuzi3Y4de/OVMLyCJ7WWb
	i5zBDP9NGMdBgsCCqQuXXjGqMUMFz+G2c+PKet0mQm9Jo8wIWtj+MVXRKWEQtRvat9EUDncG1OogP
	O6qq9oU0iVAHov8Rub02L+srmlZzL+xvivYZ/ns1DVB5Z+QsldUp5icQ96yGWMrwdVHI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v9S4Z-0000n6-7P;
	Thu, 16 Oct 2025 17:47:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1v9S4X-0000ms-VX
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Oct 2025 17:47:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8wQs9oFnC6ybHT0EgnQA3/zZobBtF+qfWQIKLQnKZ6E=; b=epCgC65waCh2PUrf6acYf72xHT
 3Vpw78BWed9xq/3wemVTdGQ0GqBVWinmNQ/bHyjorMOcbsbYgUM1nbUOwpRjHZqvL+HNNIYcwWgLG
 k5PnEONGo0fLaBrEpeq7bdYDl2ArHnHaY5U/dQ0ffnQHsrJPf/HVmxc/6Gtuj4jjCAEo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8wQs9oFnC6ybHT0EgnQA3/zZobBtF+qfWQIKLQnKZ6E=; b=Da7KaptDeHI9N5DOWgCQA2GmuY
 vFRuiw6KBSnGv1O9V3yPGqVQjWOdrTgizTUj9JExTRQ4vpcPiz50Jyg2cSxrJy01Rv8VofrVBGe6i
 oDkNkWesE8HOiL+l/eKSmtelvEC8LHQLoPP1U7Kg9HwiWlcQ0IUQee59P+B2if4eHHZ4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v9S4Y-0007ka-91 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Oct 2025 17:47:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E6C844176B;
 Thu, 16 Oct 2025 17:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B95EC4CEF1;
 Thu, 16 Oct 2025 17:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760636839;
 bh=r6DPlZVy4qFQFCrpXk4SSFgx6SI+uqSLFd6ZAb5HV1E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=StXFPJsrgX576876aQGb7oiXW0p6Oq4IfTuzmeTH3RSrHRNxNmjX9I5WE1cvPaP7J
 VvP263mbNKSQNv2grpRt1gk+sQ9bLHAeKG9N2AO1IhM+sfL4Ee1qBVVKKENjhM/xeH
 gO79bbOXKhaO9rOZNngA3TX1uY5Auo0R1sVT/f18E4Ep6BtBPm+PM7I/Y0HD9rmSet
 mA/P9iQIVZ7fLg/g9zjFmGnWSWqNd3C9rxnktme6ZkPQYh5qajCTopKinzpTn+wAtC
 zKSbSSQ9UkW5B+vaeAUFufZbRi+e+clEMLWqE3QaYqH4p64r3oGwbAm+pLkRjraTDG
 Li5fE1fCG8fsw==
Date: Thu, 16 Oct 2025 17:47:17 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <aPEvpeM_cXWcxcZe@google.com>
References: <20251006084615.2585252-1-jprusakowski@google.com>
 <c4643bb6-882a-4229-b938-e94398294905@kernel.org>
 <aOkuA_Ffq2klE5g6@google.com>
 <ac1bcf67-cc5f-4288-a2f3-c4fb6013c38a@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ac1bcf67-cc5f-4288-a2f3-c4fb6013c38a@kernel.org>
X-Headers-End: 1v9S4Y-0007ka-91
Subject: Re: [f2fs-dev] [PATCH] f2fs: ensure node page reads complete before
 f2fs_put_super() finishes
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/11, Chao Yu wrote:
> On 10/11/25 00:02, Jaegeuk Kim wrote:
> > On 10/09, Chao Yu wrote:
> >> On 10/6/2025 4:46 PM, Jan Prusakowski via Linux-f2fs-devel wrote:
> >>> Xfstests generic/335, generic/336 sometimes crash with the following message:
> >>>
> >>> F2FS-fs (dm-0): detect filesystem reference count leak during umount, type: 9, count: 1
> >>> ------------[ cut here ]------------
> >>> kernel BUG at fs/f2fs/super.c:1939!
> >>> Oops: invalid opcode: 0000 [#1] SMP NOPTI
> >>> CPU: 1 UID: 0 PID: 609351 Comm: umount Tainted: G        W           6.17.0-rc5-xfstests-g9dd1835ecda5 #1 PREEMPT(none)
> >>> Tainted: [W]=WARN
> >>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> >>> RIP: 0010:f2fs_put_super+0x3b3/0x3c0
> >>> Call Trace:
> >>>   <TASK>
> >>>   generic_shutdown_super+0x7e/0x190
> >>>   kill_block_super+0x1a/0x40
> >>>   kill_f2fs_super+0x9d/0x190
> >>>   deactivate_locked_super+0x30/0xb0
> >>>   cleanup_mnt+0xba/0x150
> >>>   task_work_run+0x5c/0xa0
> >>>   exit_to_user_mode_loop+0xb7/0xc0
> >>>   do_syscall_64+0x1ae/0x1c0
> >>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>>   </TASK>
> >>> ---[ end trace 0000000000000000 ]---
> >>>
> >>> It appears that sometimes it is possible that f2fs_put_super() is called before
> >>> all node page reads are completed.
> >>> Adding a call to f2fs_wait_on_all_pages() for F2FS_RD_NODE fixes the problem.
> >>>
> >>> Fixes: bf22c3cc8ce7 ("f2fs: fix the panic in do_checkpoint()")
> >>>
> >>> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
> >>> ---
> >>>   fs/f2fs/super.c | 1 +
> >>>   1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >>> index 1e0678e37a30..5c94bc42b8a1 100644
> >>> --- a/fs/f2fs/super.c
> >>> +++ b/fs/f2fs/super.c
> >>> @@ -1976,6 +1976,7 @@ static void f2fs_put_super(struct super_block *sb)
> >>>   	f2fs_flush_merged_writes(sbi);
> >>>   	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
> >>> +	f2fs_wait_on_all_pages(sbi, F2FS_RD_NODE);
> >>
> >> Jan,
> >>
> >> At this stage, GC and checkpoint are both stopped, why there is still read
> >> IOs on node page? Who is reading node page? Can you please dig more details
> >> for this issue?
> > 
> > We don't actually wait for completing read IOs. So, I think it doesn't matter
> > the threads are stopped?
> 
> Read on node page should be synchronous? so if the threads are stopped, there
> should be no node IOs? Oh, Or there is still pending asynchronous readahead IO
> on node page after all threads are stopped?

I remember we submit IOs and wait for its completion when we need by lock_page.

> 
> Thanks,
> 
> > 
> >>
> >> Thanks,
> >>
> >>>   	if (err || f2fs_cp_error(sbi)) {
> >>>   		truncate_inode_pages_final(NODE_MAPPING(sbi));


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
