Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DABCD4F21
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 17 May 2026 09:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S7h6ggXy3KxKIoKFcmrEfiIAg7oMlAwuDBRX5oVA7P4=; b=P/PmgvHXjwUWAjX6f+/IOhybMp
	z5IU+hUGkjCkhX8Z/NcLyQb/llXJvCnmAVfudU4hYUJZ5znfA0P1iSva9q5pipKJGHC5xt8xHM6YL
	1gqQRwWBT5a6C5Xlbe8LfpdcRyHf9GM4RGiwOB/Xvld6rP8Q4fXgptG4kz3U4gCt0J3w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wOXqG-00077u-GF;
	Sun, 17 May 2026 09:31:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wOXpl-000778-7D
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 17 May 2026 09:30:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ygIIc4BES+W1z1Mq+eUBzLR6/6Rego1lJQuJGryreAU=; b=IiIq9pqxzm7IsIAlw18LK/G6Rx
 MQJRorBQSAiBGkuzJPPAfbM0EEacI1jiZSuzdxlEckNbfH+Yeb7nN5o0njFPnf93J5BuydByzhvQr
 WMMkAAy/cUcCg1DuzZgNP9IYNZs1jeBIPTafzck/TTKCeWesPa5mO9pC3dWCuwlsWpLk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ygIIc4BES+W1z1Mq+eUBzLR6/6Rego1lJQuJGryreAU=; b=Lnnc/n3NNA45CizeouBZOTcsfs
 o8ewh3cxHGcatTKUFBhuQZbSORwsHsXksPBZdIlfc0Ym9F+Olrfc52WeiBunRy1XosSgQVdRNvJjD
 kaLQ73CsvbacIekod0d6yoRucrHPQrAplY14rFFP3deV4K+7H94dWaD7uyNXb4twRcfw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wOXpg-0003AU-Gm for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 17 May 2026 09:30:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5D9D560125;
 Sun, 17 May 2026 09:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5440CC2BCB0;
 Sun, 17 May 2026 09:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779010243;
 bh=YANNKqUqyUqOuwroz2JAmWJGI6p6LJi2/DQAWHHrT48=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=u+Q1UoDEqy6joNAOTzsih5a6mp7wwNKF2QstaHpZWCvQ1R0aDuTnuWNYl6jVvcxEr
 ws9yn2ZTHfsw2QGBkf6sexd3+XWQckglIG4BW2DHgPQh6Qqd1vv3HxQDgir79E/O6x
 +A80EJV7oBwYHWYr6sTKgznIhIL7A0Ztx5vHQ7xnaRyus/Ui74unQ5xPpcGAz+1CEm
 MmroAuEQVbkEr+ogsXXppV1p6ts/WUEWiuneYYo3OZwBG1KGriYBK3vKzSCmJyQ5UI
 q20uIVmdQ46OxpuQfrefAlt7GF1TuS19VoJhIx2/EITvkFWXsGIeqJPT2DLrNLL5C8
 eSrx2brzwLk5Q==
Message-ID: <b8a943f8-e5b4-4944-b19e-ba129b8cae66@kernel.org>
Date: Sun, 17 May 2026 17:30:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Deepanshu Kartikey <kartikey406@gmail.com>, jaegeuk@kernel.org
References: <20260517005230.28172-1-kartikey406@gmail.com>
Content-Language: en-US
In-Reply-To: <20260517005230.28172-1-kartikey406@gmail.com>
X-Headers-End: 1wOXpg-0003AU-Gm
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't BUG on node footer mismatch in
 f2fs_write_end_io
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: syzbot+4af46ee83100e99bce09@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/17/2026 8:52 AM, Deepanshu Kartikey wrote:
> Syzbot reports a recurrence of the kernel BUG in f2fs_write_end_io:
> 
>    kernel BUG at fs/f2fs/data.c:388!
>    Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
>    CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 PREEMPT_{RT,(full)}
>    RIP: 0010:f2fs_write_end_io+0x16df/0x1740
>    Call Trace:
>     blk_update_request+0x57e/0xe60
>     blk_mq_end_request+0x3e/0x70
>     blk_done_softirq+0x10a/0x160
>     handle_softirqs+0x1de/0x6d0
>     run_ksoftirqd+0x52/0x180
> 
> Commit 50ac3ecd8e05 ("f2fs: fix to do sanity check on node footer
> in {read,write}_end_io") added f2fs_sanity_check_node_footer() to
> both end_io paths to catch corrupted node footers reachable from
> fuzzed on-disk images. In f2fs_write_end_io(), however, the
> existing
> 
>    f2fs_bug_on(sbi, folio->index != nid_of_node(folio));
> 
> was left in place immediately after the new helper call. The
> helper detects the mismatch, sets SBI_NEED_FSCK and emits a
> ratelimited warning, but its return value is discarded and the
> following f2fs_bug_on() panics on the exact same condition.
> 
> Tracing the reproducer confirms the failure path. A node folio
> with index=11 is looked up via __get_node_folio(), the
> synchronous sanity check at page_hit fails with -EFSCORRUPTED
> and out_err clears uptodate but leaves the dirty bit set from
> the folio's earlier lifecycle. A subsequent read_node_folio()
> fails with the same error (footer_nid=0, ino=0), and
> folio_end_read(folio, false) does not clear dirty either. The
> writeback iterator then finds the still-dirty folio via the
> PAGECACHE_TAG_DIRTY tag and submits it. f2fs_write_end_io()
> observes folio->index=11 with nid_of_node(folio)=0 and panics
> from softirq context via blk_done_softirq, even though
> f2fs_sanity_check_node_footer() has already correctly identified
> the corruption and would have signalled it via its return value.
> 
> A filesystem inconsistency reachable from a mounted image must
> not panic the kernel. Mirror the handling already used in
> f2fs_finish_read_bio(): capture the helper's return value and
> mark the bio with BLK_STS_IOERR on mismatch instead of issuing
> BUG_ON. SBI_NEED_FSCK is set by the helper, so fsck.f2fs will
> repair the inconsistency on the next mount.
> 
> Reported-by: syzbot+4af46ee83100e99bce09@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=4af46ee83100e99bce09
> Fixes: 50ac3ecd8e05 ("f2fs: fix to do sanity check on node footer in {read,write}_end_io")
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>   fs/f2fs/data.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 8d4f1e75dee3..c149b0ccf22d 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -382,11 +382,11 @@ static void f2fs_write_end_io(struct bio *bio)
>   						STOP_CP_REASON_WRITE_FAIL);
>   		}
>   
> -		if (is_node_folio(folio)) {
> -			f2fs_sanity_check_node_footer(sbi, folio,
> -				folio->index, NODE_TYPE_REGULAR, true);
> -			f2fs_bug_on(sbi, folio->index != nid_of_node(folio));

Well, I don't think removing the f2fs_bug_on() is the right way to fix this,
because we may lose chance to detect any f2fs bug w/o f2fs_bug_on().

The problem here is why we haven't detected such inconsistent node footer
before writebacking the node folio.

I find a missing case, please take a look:

https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=syzbot&id=20e7d40cfa8d2afdc16ed2d3df24ef68ebda71ba

Thanks,

> -		}
> +		if (is_node_folio(folio) &&
> +		    f2fs_sanity_check_node_footer(sbi, folio,
> +						  folio->index, NODE_TYPE_REGULAR, true))
> +			bio->bi_status = BLK_STS_IOERR;
> +
>   		if (f2fs_in_warm_node_list(folio))
>   			f2fs_del_fsync_node_entry(sbi, folio);
>   



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
