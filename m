Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4936C55175
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uxwF0rXjb65ysCIrPFscM8MhX8L+TkzKPD/Ik+jL5ss=; b=l0U+ptJpNzNR8JkViDErjCkaVd
	+Wslh+FmuMF9749znLi5l54NOon4b0NynO+piWk28FSB0XsmoD8NBYs6Q8n5e+eos+6SEh5bC5npe
	3lDtXJZrcRdWqolgmcZr4g2yjtlVlYNBe9VHxQl3pcG1ucSFQRSJXrCNiXT1FbcZWAU8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqp1b-0004tc-3t;
	Mon, 03 Aug 2026 09:31:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqp1Z-0004tV-BI
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 09:31:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oaBLOP9AFgMylfQ9JuKvumZBzT5RDhSyXI9epCNyMHY=; b=dQLixkiNhDjC5NpUHWAiCI66Gj
 Wupr2LtCkO2K8LxhiF6+RLKt/Fcgo7pdEbHP5iWcIfsfhhKuJg/p36815Tr/hjVAZBhW20yhsiRBB
 /KS14wc8CQjs9RmL6xyrvRTeh2iXt90V7WntFfD1tj1hGp87Py9E2pd+CJk0FSxAEYW0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oaBLOP9AFgMylfQ9JuKvumZBzT5RDhSyXI9epCNyMHY=; b=KidI4+r7RS1LWIfXWvjwqcChiq
 72gqhYUC0TV1IfeuWdU+ALfDhgqjsGBJ4otwxhT7fdnJnmCimToJBII8XiT1KMcByRRaauywE100N
 B3FopepB94zBKK1vfqz2teFDz1xs5wn0kNfJEBEBJwingivz9G+cg5aqkrn1c5yJyD90=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqp1X-0003qX-Td for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 09:31:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 61EAF41641;
 Mon,  3 Aug 2026 09:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D591F000E9;
 Mon,  3 Aug 2026 09:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785749510;
 bh=oaBLOP9AFgMylfQ9JuKvumZBzT5RDhSyXI9epCNyMHY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=LgL/97RUsuglTZYA3bmGlgXetp6OvGKHObeyoby/KdoU9MM6uLKtwzY2M9Yc7+N+f
 9VOMpHWZOeK/byYmoVAmxHZZmhjOUyZqP84T+2G5Hr0qKD04/NXkqxFB6uWjtM7e15
 iuBV5RUZZ0h83h/nebFCfwCeyuRavzaNzNQcR6MuTyseOGUOmg8GtCEUk2bQ6/Q1gy
 ItfWOHmwoGQazmaWqNuPSWgU5avc1gAKhztf5Q/kp0UWOXwq3yL4in/IrPzgXN6C6Z
 Vva9DzdO2f8lvgQOyBgJpRWY09RxaXkGUaWowiCJ9FHOtYioUmgsjogBlM5jSAPf+5
 FFmOUud7lRS+w==
Message-ID: <b054d8cd-8220-49e5-8ff2-fb44753dc5a8@kernel.org>
Date: Mon, 3 Aug 2026 17:31:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260803092307.1437283-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260803092307.1437283-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wqp1X-0003qX-Td
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: avoid NULL checkpoint thread
 access in sysfs
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
Cc: stable@kernel.org, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch should include below change? otherwise it's not a self-contained
fix.

@@ -1007,13 +1007,15 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
  	ssize_t ret;
  	bool gc_entry = (!strcmp(a->attr.name, "gc_urgent") ||
  					a->struct_type == GC_THREAD);
+	bool thread_entry = !strcmp(a->attr.name, "ckpt_thread_ioprio");

-	if (gc_entry) {
+	if (gc_entry || thread_entry) {
  		if (!down_read_trylock(&sbi->sb->s_umount))
  			return -EAGAIN;
  	}
  	ret = __sbi_store(a, sbi, buf, count);
-	if (gc_entry)
+	if (gc_entry || thread_entry)
  		up_read(&sbi->sb->s_umount);

On 8/3/26 17:23, Wenjie Qi wrote:
> checkpoint_merge can be enabled even when no checkpoint merge thread is
> running. A read-only mount is one case: f2fs does not start
> f2fs_issue_ckpt there, but ckpt_thread_ioprio is still writable through
> sysfs.
> 
> The ckpt_thread_ioprio store path updates the saved ioprio value and,
> when checkpoint_merge is enabled, calls set_task_ioprio() for the
> checkpoint thread. If cprc->f2fs_issue_ckpt is NULL, that dereferences a
> NULL task pointer.
> 
> Keep storing the requested ioprio, but apply it only when the
> checkpoint thread exists.
> 
> Fixes: e65920661708 ("f2fs: add ckpt_thread_ioprio sysfs node")
> Cc: stable@kernel.org
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
>   fs/f2fs/sysfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index be92c05a5420..070f9807ae81 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -557,7 +557,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   			return -EINVAL;
>   
>   		cprc->ckpt_thread_ioprio = IOPRIO_PRIO_VALUE(class, level);
> -		if (test_opt(sbi, MERGE_CHECKPOINT)) {
> +		if (cprc->f2fs_issue_ckpt) {
>   			ret = set_task_ioprio(cprc->f2fs_issue_ckpt,
>   					cprc->ckpt_thread_ioprio);
>   			if (ret)



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
