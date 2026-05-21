Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC71CD5BB3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 May 2026 08:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QCHhrMmsaMKBhkhJcJw8zW7+mTm+YG+mHamURc7N548=; b=WmHBMwDSe1qjpKzfLOY0gRQZSY
	iTeDljIsu4dw1i0D42Hb6hv4JCmyGuIerOhhRtic+UrnE5Xgvc27SYwVxE3ybHNatXdmKYXl3ymim
	fQ2XOs5IneoT4bIiHyukbtvlRGdUktVOZc9we2qO0jCDPWb9r1rixM8iaA0qpOUXuNGw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wPyuQ-0000Oh-9m;
	Thu, 21 May 2026 08:37:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wPyuP-0000Ob-E4
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 08:37:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jeGQAOpwRLcc6vKzwNWEYiTrpfsLN7h1HzF/mzgI66w=; b=d+XahfKpFmknhFKgCW4kodJC4L
 tqOS09lOLLfQbaZz2LBYuanpqSIFEWw1OVHPeELAUHPDJ4mk92z2QWHEIVM/ZwEs0hrq6K/qtChq4
 ie88IbtSu/N0wgGQhHfvF57+jjWtU8K0+C1NaPGp90HzFAkVENdkYtL7OCoV20lVyY3Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jeGQAOpwRLcc6vKzwNWEYiTrpfsLN7h1HzF/mzgI66w=; b=WFIqnhB2MxInQPRGWkAxbBzjFr
 bxjVOTp4oiCWzF82TvCkvSrdJU6jaGFjOjnefQCmjnnI6aEvxqQhsFfaZZGwF2mjsublVXnDLyvji
 JfkaSHRJVdIeVjX6GZWESkw5+qV2HhPU5oY35I6sMSIEz3WVsacUrHoRMhCxrbpj5jNE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wPyuP-00056d-6k for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 08:37:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 16D83601F4;
 Thu, 21 May 2026 08:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDCD1F01561;
 Thu, 21 May 2026 08:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779352646;
 bh=jeGQAOpwRLcc6vKzwNWEYiTrpfsLN7h1HzF/mzgI66w=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=jjIit9nscSq+bfVMurspSl8fFCavRbj6G1REyMfjvJ71C+leNc/bLtUAB0jvka9x+
 jQ2KwjPGVgaQeOLfu9lMKbe8wb3CAmy5MEJM6hckoNZeCwnkXyfSpuo2tWbFLNjieb
 c/j/Pq/5E0Dmpb+l8qljCKKHOgG7A0h+R6pm69uac+270pOTEhqC74K46cW74259P1
 QBiHiWlvItR1Y4kZWJVIJtldlDz1C8+t6q9OTK1c79oqGMLPmRlhA9kbrVesePBUrv
 RBmMpUgMD7r1XMHCSuYyWgZO/Z47BGhyQTPJsgf7czag/y7hwC7xzkae+h/jplKXgt
 JQSUJT5vepfgA==
Message-ID: <389b09ff-ecac-44ed-8303-837408ddee17@kernel.org>
Date: Thu, 21 May 2026 16:37:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260521015126.1663277-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260521015126.1663277-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wPyuP-00056d-6k
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid false shutdown fserror reports
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
Cc: djwong@kernel.org, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/21/26 09:51, Wenjie Qi wrote:
> F2FS records image errors and checkpoint-stop reasons through the same
> s_error_work worker.  The ordinary f2fs_handle_error() path only updates
> s_errors, but the worker still calls fserror_report_shutdown()
> unconditionally after committing the superblock.
> 
> As a result, a metadata corruption report can be followed by a synthetic
> FAN_FS_ERROR event with ESHUTDOWN and an invalid superblock file handle,
> even though no stop reason was recorded.
> 
> Track whether save_stop_reason() actually changed the stop_reason array
> and only report the shutdown fserror for that case.  Pure s_errors updates
> still commit the superblock, but no longer generate a false shutdown event.
> 

Cc: stable@kernel.org

> Fixes: 50faed607d32 ("f2fs: support to report fserror")
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
